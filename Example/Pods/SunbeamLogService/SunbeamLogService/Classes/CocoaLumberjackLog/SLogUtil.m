//
//  SLogUtil.m
//  Pods
//
//  Created by sunbeam on 2016/12/28.
//
//

#import "SLogUtil.h"

@implementation SLogUtil

+ (NSString *)getAppName
{
    static NSString *_appName;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
        
        if (!_appName) {
            _appName = [[NSProcessInfo processInfo] processName];
        }
        
        if (!_appName) {
            _appName = @"SunbeamLogService";
        }
    });
    
    return _appName;
    
}

+ (NSString *)getAPPVersion
{
    static NSString* _appVersion;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        
        if (!_appVersion) {
            _appVersion = @"0";
        }
    });
    
    return _appVersion;
}

+ (NSString *)getAPPBuildVersion
{
    static NSString* _appBuildVersion;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _appBuildVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        
        if (!_appBuildVersion) {
            _appBuildVersion = @"0";
        }
    });
    
    return _appBuildVersion;
}

+ (BOOL) getAPPLogOn
{
    static BOOL _appSLogOn;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSNumber* sLogOn = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"SLogOn"];
        if (!sLogOn) {
            _appSLogOn = NO;
        } else {
            if ([sLogOn  isEqual: @(1)]) {
                _appSLogOn = YES;
            } else {
                _appSLogOn = NO;
            }
        }
    });
    
    return _appSLogOn;
}

@end
