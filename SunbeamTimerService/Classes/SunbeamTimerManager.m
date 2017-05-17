//
//  SunbeamTimerManager.m
//  Pods
//
//  Created by sunbeam on 16/7/31.
//
//

#import "SunbeamTimerManager.h"

#import "SunbeamTimerEventDispatcher.h"

#import <MSWeakTimer/MSWeakTimer.h>

#import <SunbeamLogService/SunbeamLogService.h>

#define NSTIMER_USERINFO_IDENTIFIER_KEY @"userInfo_identifier"

#define NSTIMER_USERINFO_SELF_KEY @"userInfo_self"

@interface SunbeamTimerManager() <SunbeamTimerEventListener>

// SunbeamTimerExecuteDelegate list [id<SunbeamTimerExecuteDelegate>]
@property (nonatomic, strong, readwrite) NSMutableArray* delegates;

// STimer list {"STimer identifier":"STimer"}
@property (nonatomic, strong, readwrite) NSMutableDictionary* sunbeamtimerList;

@property (nonatomic, copy) NSString* addSTimerToken;

@property (nonatomic, copy) NSString* destroySTimerToken;

@property (nonatomic, copy) NSString* clearSTimerToken;

@property (nonatomic, copy) NSString* executeSTimerToken;

@end

@implementation SunbeamTimerManager

+ (SunbeamTimerManager *) sharedSunbeamTimerManager {
    static SunbeamTimerManager *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self initEventListener];
        [self initSTimerToken];
        [SLog initSLogService];
    }
    
    return self;
}

// 初始化STimer执行时Token
- (void) initSTimerToken
{
    self.addSTimerToken = @"add STimer token";
    self.destroySTimerToken = @"destroy STimer token";
    self.clearSTimerToken = @"clear STimer token";
    self.executeSTimerToken = @"execute STimer token";
#ifdef DEBUG
    NSLog(@"\n======================\nSunbeam Timer Service version is %@\n======================", SUNBEAM_TIMER_SERVICE_VERSION);
#endif
}

//初始化EventListener
- (void) initEventListener
{
    [[SunbeamTimerEventDispatcher sharedSunbeamTimerEventDispatcher] addListener:self];
}

- (void)dealloc
{
    [[SunbeamTimerEventDispatcher sharedSunbeamTimerEventDispatcher] removeListener:self];
}

// 添加代理
- (void) addTimerExecuteDelegate:(id<SunbeamTimerExecuteDelegate>) delegate
{
    if (delegate == nil) {
        return;
    }
    [self.delegates addObject:delegate];
}

// 移除代理
- (void) removeTimerExecuteDelegate:(id<SunbeamTimerExecuteDelegate>) delegate
{
    [self.delegates removeObject:delegate];
}

// 添加STimer
- (void) addSunbeamTimer:(NSString *) identifier name:(NSString *) name desc:(NSString *) desc timeInterval:(NSTimeInterval) timeInterval userInfo:(NSDictionary *) userInfo repeats:(BOOL) repeats
{
    // 添加之前先销毁
    [self destroySunbeamTimer:identifier];
    
    SunbeamTimer* stimer = [[SunbeamTimer alloc] init];
    stimer.identifier = identifier;
    stimer.name = name;
    stimer.desc = desc;
    stimer.repeats = repeats;
    stimer.timeInterval = timeInterval;
    NSMutableDictionary* userInfoDictionary = [[NSMutableDictionary alloc] init];
    [userInfoDictionary setObject:identifier forKey:NSTIMER_USERINFO_IDENTIFIER_KEY];
    if (userInfo) {
        [userInfoDictionary setObject:userInfo forKey:NSTIMER_USERINFO_SELF_KEY];
    }
    stimer.timer = [MSWeakTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(stimerExecuteSelector:) userInfo:userInfoDictionary repeats:repeats dispatchQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    // 更新STimer cache
    [[SunbeamTimerEventDispatcher sharedSunbeamTimerEventDispatcher] dispatchEvent:stimer eventType:SunbeamTimerEventType_Add params:nil];
}

// 销毁STimer
- (void) destroySunbeamTimer:(NSString *) identifier
{
    if ([self checkSunbeamTimerExist:identifier]) {
        SunbeamTimer* stimer = [self.sunbeamtimerList objectForKey:identifier];
        [stimer.timer invalidate];
        stimer.timer = nil;
        // 更新STimer cache
        [[SunbeamTimerEventDispatcher sharedSunbeamTimerEventDispatcher] dispatchEvent:stimer eventType:SunbeamTimerEventType_Destroy params:nil];
    }
}

// 销毁所有STimer
- (void) clearAllSunbeamTimer
{
    // 更新STimer cache
    [[SunbeamTimerEventDispatcher sharedSunbeamTimerEventDispatcher] dispatchEvent:nil eventType:SunbeamTimerEventType_Clear params:nil];
}

// 检查指定identifier的STimer是否存在
- (BOOL) checkSunbeamTimerExist:(NSString *) identifier
{
    if (identifier == nil || [@"" isEqualToString:identifier]) {
        return NO;
    }
    
    SunbeamTimer* stimer = [self.sunbeamtimerList objectForKey:identifier];
    
    if (stimer) {
        return YES;
    }
    
    return NO;
}


#pragma mark - timer selector
// NSTimer execute selector
- (void) stimerExecuteSelector:(MSWeakTimer *) timer
{
    @synchronized (self.executeSTimerToken) {
        MSWeakTimer* tempTimer = timer;
        NSString* identifier = [tempTimer.userInfo objectForKey:NSTIMER_USERINFO_IDENTIFIER_KEY];
        NSDictionary* userInfo = [tempTimer.userInfo objectForKey:NSTIMER_USERINFO_SELF_KEY];
        SLogDebug(@"定时器执行：[%@][%@]", identifier, userInfo);
        for (id<SunbeamTimerExecuteDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(SunbeamTimerExecute:userInfo:)]) {
                [delegate SunbeamTimerExecute:identifier userInfo:userInfo];
            } else {
                SLogWarn(@"指定timer代理回调方法SunbeamTimerExecute:userInfo:未实现[%@]", delegate);
            }
        }
        // 定时器执行后移除
        SunbeamTimer* stimer = [self.sunbeamtimerList objectForKey:identifier];
        if (!stimer.repeats) {
            [self.sunbeamtimerList removeObjectForKey:identifier];
        }
    }
}

#pragma mark - cache update
- (void)sunbeamTimerAdd:(SunbeamTimer *)stimer params:(NSMutableDictionary *)params
{
    @synchronized (self.addSTimerToken) {
        [self.sunbeamtimerList setObject:stimer forKey:stimer.identifier];
        SLogDebug(@"定时器添加：[%@][%@][%@][%d]", stimer.identifier, stimer.name, stimer.desc, stimer.repeats);
        for (id<SunbeamTimerExecuteDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(SunbeamTimerAdded:)]) {
                [delegate SunbeamTimerAdded:stimer.identifier];
            }
        }
    }
}

- (void)sunbeamTimerDestroy:(SunbeamTimer *)stimer params:(NSMutableDictionary *)params
{
    @synchronized (self.destroySTimerToken) {
        [self.sunbeamtimerList removeObjectForKey:stimer.identifier];
        SLogDebug(@"定时器销毁：[%@][%@][%@][%d]", stimer.identifier, stimer.desc, stimer.desc, stimer.repeats);
        for (id<SunbeamTimerExecuteDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(SunbeamTimerDestroy:)]) {
                [delegate SunbeamTimerDestroy:stimer.identifier];
            }
        }
    }
}

- (void)sunbeamTimerClear
{
    @synchronized (self.clearSTimerToken) {
        NSMutableDictionary* tempSTimerList = self.sunbeamtimerList;
        for (SunbeamTimer* stimer in [tempSTimerList allValues]) {
            SLogDebug(@"清空指定定时器：[%@][%@][%@][%d]", stimer.identifier, stimer.desc, stimer.desc, stimer.repeats);
            [self destroySunbeamTimer:stimer.identifier];
        }
        for (id<SunbeamTimerExecuteDelegate> delegate in self.delegates) {
            if ([delegate respondsToSelector:@selector(SunbeamTimerClear:)]) {
                [delegate SunbeamTimerClear:tempSTimerList];
            }
        }
    }
}

#pragma mark - timer cache init
- (NSMutableArray *)delegates
{
    if (_delegates == nil) {
        _delegates = [[NSMutableArray alloc] init];
    }
    
    return _delegates;
}

- (NSMutableDictionary *)sunbeamtimerList
{
    if (_sunbeamtimerList == nil) {
        _sunbeamtimerList = [[NSMutableDictionary alloc] init];
    }
    
    return _sunbeamtimerList;
}

@end
