//
//  SLogUtil.h
//  Pods
//
//  Created by sunbeam on 2016/12/28.
//
//

#import <Foundation/Foundation.h>

@interface SLogUtil : NSObject

+ (NSString *) getAppName;

+ (NSString *) getAPPVersion;

+ (NSString *) getAPPBuildVersion;

+ (BOOL) getAPPLogOn;

@end
