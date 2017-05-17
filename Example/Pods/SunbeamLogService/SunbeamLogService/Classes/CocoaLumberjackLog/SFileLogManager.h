//
//  SFileLogManager.h
//  Pods
//
//  Created by sunbeam on 2016/12/28.
//
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

@interface SFileLogManager : NSObject

@property (nonatomic, strong) DDLogFileInfo* logFileInfo;

- (instancetype) initSFileLogManager:(DDLogLevel) logLevel logFileDirectory:(NSString *) logFileDirectory rollingFrequency:(NSTimeInterval) rollingFrequency;

@end
