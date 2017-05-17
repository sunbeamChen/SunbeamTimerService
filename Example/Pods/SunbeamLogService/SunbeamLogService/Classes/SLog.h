//
//  SLog.h
//  Pods
//
//  Created by sunbeam on 16/7/28.
//
//

#import <Foundation/Foundation.h>

#define SLOG_VERSION @"0.1.12"

#define SLogVerbose(format, ...) SLog_Verbose(format, ##__VA_ARGS__)

#define SLogDebug(format, ...) SLog_Debug(format, ##__VA_ARGS__)

#define SLogInfo(format, ...) SLog_Info(format, ##__VA_ARGS__)

#define SLogWarn(format, ...) SLog_Warn(format, ##__VA_ARGS__)

#define SLogError(format, ...) SLog_Error(format, ##__VA_ARGS__)

@interface SLog : NSObject

/**
*  初始化SLog服务
*
*  @return 初始化结果 YES－成功; NO－失败;
*/
+ (BOOL) initSLogService;

/**
 获取log文件本地路径

 @return log文件本地路径,路径为nil或获取失败时返回nil
 */
+ (NSString *) getLogFilePath;

@end
