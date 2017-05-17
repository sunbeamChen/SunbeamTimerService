//
//  SConsoleLogFormatter.m
//  Pods
//
//  Created by sunbeam on 2016/12/28.
//
//

#import "SConsoleLogFormatter.h"
#import "SLogUtil.h"

@interface SConsoleLogFormatter()

@property (nonatomic, assign) int loggerCount;

@property (nonatomic, strong) NSDateFormatter *threadUnsafeDateFormatter;

@end

@implementation SConsoleLogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *logLevel;
    
    switch (logMessage->_flag) {
        case DDLogFlagError    : logLevel = @"[Erro]"; break;
        case DDLogFlagWarning  : logLevel = @"[Warn]"; break;
        case DDLogFlagInfo     : logLevel = @"[Info]"; break;
        case DDLogFlagDebug    : logLevel = @"[Debu]"; break;
        default                : logLevel = @"[Verb]"; break;
    }
    
    NSString *dateAndTime = [self.threadUnsafeDateFormatter stringFromDate:(logMessage->_timestamp)];
    NSString *logMsg = logMessage->_message;
    
    return [NSString stringWithFormat:@"%@ | %@ | %@ | %@ | %@ | %@ | line:%@ | %@", logLevel, dateAndTime, [SLogUtil getAPPVersion], [SLogUtil getAPPBuildVersion], logMessage->_fileName, logMessage->_function, @(logMessage->_line), logMsg];
}

- (void)didAddToLogger:(id<DDLogger>)logger
{
    _loggerCount++;
    NSAssert(_loggerCount <= 1, @"This logger isn't thread-safe");
}

- (void)willRemoveFromLogger:(id<DDLogger>)logger
{
    _loggerCount--;
}

- (NSDateFormatter *)threadUnsafeDateFormatter
{
    if (_threadUnsafeDateFormatter == nil) {
        _threadUnsafeDateFormatter = [[NSDateFormatter alloc] init];
        [_threadUnsafeDateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss:SSS"];
    }
    
    return _threadUnsafeDateFormatter;
}

@end
