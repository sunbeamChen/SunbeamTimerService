//
//  SLogManager.h
//  Pods
//
//  Created by sunbeam on 2016/12/28.
//
//

#import <Foundation/Foundation.h>
#import "SConsoleLogManager.h"
#import "SFileLogManager.h"

#define SLog_Verbose(frmt, ...) DDLogVerbose(frmt, ##__VA_ARGS__)

#define SLog_Debug(frmt, ...) DDLogDebug(frmt, ##__VA_ARGS__)

#define SLog_Info(frmt, ...) DDLogInfo(frmt, ##__VA_ARGS__)

#define SLog_Warn(frmt, ...) DDLogWarn(frmt, ##__VA_ARGS__)

#define SLog_Error(frmt, ...) DDLogError(frmt, ##__VA_ARGS__)

static const DDLogLevel ddLogLevel = DDLogLevelVerbose;

#ifndef LOG_LEVEL_DEF
    #define LOG_LEVEL_DEF ddLogLevel
#endif

#ifndef LOG_ASYNC_ENABLED
    #define LOG_ASYNC_ENABLED YES
#endif

@interface SLogManager : NSObject

/**
 控制台日志
 */
@property (nonatomic, copy, readonly) SConsoleLogManager* consoleLogManager;

/**
 文件日志
 */
@property (nonatomic, copy, readonly) SFileLogManager* fileLogManager;

/**
 初始化SLogManager
 */
- (SLogManager *) initSLogManager:(BOOL) logOn;

@end
