//
//  SFileLogManagerDefault.m
//  Pods
//
//  Created by sunbeam on 2016/12/28.
//
//

#import "SFileLogManagerDefault.h"
#import "SLogUtil.h"

#define LOG_FILE_NAME [NSString stringWithFormat:@"%@.txt", [SLogUtil getAppName]]

#define LOG_FILE_SUFFIX_NAME @".txt"

@implementation SFileLogManagerDefault

- (NSString *)newLogFileName
{
    return LOG_FILE_NAME;
}

- (BOOL)isLogFile:(NSString *)fileName
{
    BOOL hasProperPrefix = [fileName hasPrefix:[SLogUtil getAppName]];
    BOOL hasProperSuffix = [fileName hasSuffix:LOG_FILE_SUFFIX_NAME];
    
    return (hasProperPrefix && hasProperSuffix);
}

@end
