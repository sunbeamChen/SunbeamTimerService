//
//  SLogManager.m
//  Pods
//
//  Created by sunbeam on 2016/12/28.
//
//

#import "SLogManager.h"

#define LOG_FILE_PATH [NSString stringWithFormat:@"%@/log/",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]]

NSTimeInterval const SAPILogFileRollingFrequency = 60 * 60 * 24 * 7;

@interface SLogManager()

@property (nonatomic, assign) DDLogLevel sconsoleLogLevel;

@property (nonatomic, assign) DDLogLevel sfileLogLevel;

@end

@implementation SLogManager

/**
 初始化SLogManager
 */
- (SLogManager *) initSLogManager:(BOOL) logOn
{
    if (self = [super init]) {
        if (logOn) {
            _sconsoleLogLevel = DDLogLevelOff;
#ifdef DEBUG
            _sconsoleLogLevel = DDLogLevelVerbose;
#endif
        } else {
            _sconsoleLogLevel = DDLogLevelOff;
#ifdef DEBUG
            _sconsoleLogLevel = DDLogLevelWarning;
#endif
        }
        _sfileLogLevel = DDLogLevelWarning;
        [self initConsoleLogManager];
        [self initFileLogManager];
    }
    
    return self;
}

- (void) initConsoleLogManager
{
    _consoleLogManager = [[SConsoleLogManager alloc] initSConsoleLogManager:_sconsoleLogLevel];
}

- (void) initFileLogManager
{
    _fileLogManager = [[SFileLogManager alloc] initSFileLogManager:_sfileLogLevel logFileDirectory:LOG_FILE_PATH rollingFrequency:SAPILogFileRollingFrequency];
}

@end
