//
//  SLog.m
//  Pods
//
//  Created by sunbeam on 16/7/28.
//
//

#import "SLog.h"
#import "SLogManager.h"
#import "SLogUtil.h"

static SLogManager* sLogManager;

@interface SLog()

@end

@implementation SLog

+ (BOOL) initSLogService
{
    if (sLogManager == nil) {
        sLogManager = [[SLogManager alloc] initSLogManager:[SLogUtil getAPPLogOn]];
        
#ifdef DEBUG
        NSLog(@"\n======================\nSunbeamLogService(https://github.com/sunbeamChen/SunbeamLogService) version is %@\n======================", SLOG_VERSION);
#endif
    }
    
    if (sLogManager) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *) getLogFilePath
{
    if (sLogManager.fileLogManager.logFileInfo) {
        return sLogManager.fileLogManager.logFileInfo.filePath;
    }
    
    return nil;
}

@end
