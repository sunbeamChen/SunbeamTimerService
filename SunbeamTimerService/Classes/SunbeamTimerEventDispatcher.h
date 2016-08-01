//
//  SunbeamTimerEventDispatcher.h
//  Pods
//
//  Created by sunbeam on 16/8/1.
//
//

#import <Foundation/Foundation.h>

#import "SunbeamTimer.h"

typedef NS_ENUM(NSInteger, SunbeamTimerEventType) {
    SunbeamTimerEventType_Add = 0,
    SunbeamTimerEventType_Destroy = 1,
    SunbeamTimerEventType_Clear = 2,
};

@protocol SunbeamTimerEventListener <NSObject>

@optional
// stimer初始化
- (void) sunbeamTimerAdd:(SunbeamTimer *) stimer params:(NSMutableDictionary *) params;

// stimer销毁
- (void) sunbeamTimerDestroy:(SunbeamTimer *) stimer params:(NSMutableDictionary *) params;

// stimer清理
- (void) sunbeamTimerClear;

@end

@interface SunbeamTimerEventDispatcher : NSObject

+ (SunbeamTimerEventDispatcher *) sharedSunbeamTimerEventDispatcher;

// 监听者
@property (nonatomic, strong) NSMutableArray* listeners;

- (void) addListener:(id<SunbeamTimerEventListener>) listener;

- (void) removeListener:(id<SunbeamTimerEventListener>) listener;

- (void) dispatchEvent:(SunbeamTimer *) stimer eventType:(SunbeamTimerEventType) eventType params:(NSMutableDictionary *) params;

@end
