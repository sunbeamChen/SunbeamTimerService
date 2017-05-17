//
//  SunbeamTimerManager.h
//  Pods
//
//  Created by sunbeam on 16/7/31.
//
//

#import <Foundation/Foundation.h>

#define SUNBEAM_TIMER_SERVICE_VERSION @"0.1.10"

@protocol SunbeamTimerExecuteDelegate <NSObject>

@required
// STimer执行回调
- (void) SunbeamTimerExecute:(NSString *) identifier userInfo:(NSDictionary *) userInfo;

@optional
// STimer添加回调
- (void) SunbeamTimerAdded:(NSString *) identifier;

// STimer销毁回调
- (void) SunbeamTimerDestroy:(NSString *) identifier;

// STimer清理回调
- (void) SunbeamTimerClear:(NSMutableDictionary *) clearSTimerList;

@end

@interface SunbeamTimerManager : NSObject

+ (SunbeamTimerManager *) sharedSunbeamTimerManager;

// SunbeamTimerExecuteDelegate list [id<SunbeamTimerExecuteDelegate>]
@property (nonatomic, strong, readonly) NSMutableArray* delegates;

// STimer list {"STimer identifier":"STimer"}
@property (nonatomic, strong, readonly) NSMutableDictionary* sunbeamtimerList;

// 添加代理
- (void) addTimerExecuteDelegate:(id<SunbeamTimerExecuteDelegate>) delegate;

// 移除代理
- (void) removeTimerExecuteDelegate:(id<SunbeamTimerExecuteDelegate>) delegate;

// 添加STimer
- (void) addSunbeamTimer:(NSString *) identifier name:(NSString *) name desc:(NSString *) desc timeInterval:(NSTimeInterval) timeInterval userInfo:(NSDictionary *) userInfo repeats:(BOOL) repeats;

// 销毁STimer
- (void) destroySunbeamTimer:(NSString *) identifier;

// 清理所有STimer
- (void) clearAllSunbeamTimer;

// 检查指定identifier的STimer是否存在
- (BOOL) checkSunbeamTimerExist:(NSString *) identifier;

@end
