//
//  SunbeamTimerEventDispatcher.m
//  Pods
//
//  Created by sunbeam on 16/8/1.
//
//

#import "SunbeamTimerEventDispatcher.h"

@implementation SunbeamTimerEventDispatcher

+ (SunbeamTimerEventDispatcher *) sharedSunbeamTimerEventDispatcher {
    static SunbeamTimerEventDispatcher *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)addListener:(id<SunbeamTimerEventListener>)listener
{
    if (listener == nil) {
        return;
    }
    
    [self.listeners addObject:listener];
}

- (void)removeListener:(id<SunbeamTimerEventListener>)listener
{
    [self.listeners removeObject:listener];
}

- (void)dispatchEvent:(SunbeamTimer *)stimer eventType:(SunbeamTimerEventType)eventType params:(NSMutableDictionary *)params
{
    for (id<SunbeamTimerEventListener> listener in self.listeners) {
        switch (eventType) {
            case SunbeamTimerEventType_Add:
            {
                if ([listener respondsToSelector:@selector(sunbeamTimerAdd:params:)]) {
                    [listener sunbeamTimerAdd:stimer params:params];
                }
                
                break;
            }
                
            case SunbeamTimerEventType_Destroy:
            {
                if ([listener respondsToSelector:@selector(sunbeamTimerDestroy:params:)]) {
                    [listener sunbeamTimerDestroy:stimer params:params];
                }
                
                break;
            }
                
            case SunbeamTimerEventType_Clear:
            {
                if ([listener respondsToSelector:@selector(sunbeamTimerClear)]) {
                    [listener sunbeamTimerClear];
                }
                
                break;
            }
                
            default:
                break;
        }
    }
}

#pragma mark - setter/getter
- (NSMutableArray *)listeners
{
    if (_listeners == nil) {
        _listeners = [[NSMutableArray alloc] init];
    }
    
    return _listeners;
}

@end
