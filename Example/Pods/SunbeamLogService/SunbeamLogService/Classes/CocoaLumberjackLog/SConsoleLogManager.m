//
//  SConsoleLogManager.m
//  Pods
//
//  Created by sunbeam on 2016/12/28.
//
//

#import "SConsoleLogManager.h"
#import "SConsoleLogFormatter.h"

@implementation SConsoleLogManager

- (instancetype)initSConsoleLogManager:(DDLogLevel)consoleLogLevel
{
    if (self = [super init]) {
        // console logger init and set
        DDTTYLogger* consoleLogger = [DDTTYLogger sharedInstance];
        
        [consoleLogger setColorsEnabled:YES];
        
        [consoleLogger setLogFormatter:[[SConsoleLogFormatter alloc] init]];
        
        // add into DDLog
        [DDLog addLogger:consoleLogger withLevel:consoleLogLevel];
    }
    
    return self;
}

@end
