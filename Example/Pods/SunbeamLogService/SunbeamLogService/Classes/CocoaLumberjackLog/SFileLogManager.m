//
//  SFileLogManager.m
//  Pods
//
//  Created by sunbeam on 2016/12/28.
//
//

#import "SFileLogManager.h"
#import "SFileLogFormatter.h"
#import "SFileLogManagerDefault.h"

#define NUMBER_OF_LOG_FILES 1

#define MAXMUM_FILE_SIZE 0

@interface SFileLogManager()

@property (nonatomic, strong) DDFileLogger* fileLogger;

@property (nonatomic, strong) SFileLogManagerDefault* fileLogManager;

@end

/**
 * Log File Rolling:
 *
 * maximumFileSize:
 *   The approximate maximum size to allow log files to grow.
 *   If a log file is larger than this value after a log statement is appended,
 *   then the log file is rolled.
 *
 * rollingFrequency
 *   How often to roll the log file.
 *   The frequency is given as an NSTimeInterval, which is a double that specifies the interval in seconds.
 *   Once the log file gets to be this old, it is rolled.
 *
 * Both the maximumFileSize and the rollingFrequency are used to manage rolling.
 * Whichever occurs first will cause the log file to be rolled.
 *
 * For example:
 * The rollingFrequency is 24 hours,
 * but the log file surpasses the maximumFileSize after only 20 hours.
 * The log file will be rolled at that 20 hour mark.
 * A new log file will be created, and the 24 hour timer will be restarted.
 *
 * You may optionally disable rolling due to filesize by setting maximumFileSize to zero.
 * If you do so, rolling is based solely on rollingFrequency.
 *
 * You may optionally disable rolling due to time by setting rollingFrequency to zero (or any non-positive number).
 * If you do so, rolling is based solely on maximumFileSize.
 *
 * If you disable both maximumFileSize and rollingFrequency, then the log file won't ever be rolled.
 * This is strongly discouraged.
 **/

@implementation SFileLogManager

- (instancetype)initSFileLogManager:(DDLogLevel)logLevel logFileDirectory:(NSString *)logFileDirectory rollingFrequency:(NSTimeInterval)rollingFrequency
{
    if (self = [super init]) {
        // fileManager default and property set
        _fileLogManager = [[SFileLogManagerDefault alloc] initWithLogsDirectory:logFileDirectory];
        
        [_fileLogManager setMaximumNumberOfLogFiles:NUMBER_OF_LOG_FILES];
        
        // file logger set
        _fileLogger = [[DDFileLogger alloc] initWithLogFileManager:_fileLogManager];
        
        [_fileLogger setLogFormatter:[[SFileLogFormatter alloc] init]];
        
        [_fileLogger setMaximumFileSize:MAXMUM_FILE_SIZE];
        
        [_fileLogger setRollingFrequency:rollingFrequency];
        
        // add into DDLog
        [DDLog addLogger:_fileLogger withLevel:logLevel];
    }
    
    return self;
}

- (DDLogFileInfo *)logFileInfo
{
    if (_fileLogger) {
        return [_fileLogger currentLogFileInfo];
    }
    
    return nil;
}

@end
