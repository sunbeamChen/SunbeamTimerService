//
//  SunbeamTimerViewController.m
//  SunbeamTimerService
//
//  Created by sunbeamChen on 08/01/2016.
//  Copyright (c) 2016 sunbeamChen. All rights reserved.
//

#import "SunbeamTimerViewController.h"

#import <SunbeamTimerService/SunbeamTimerService.h>

@interface SunbeamTimerViewController () <SunbeamTimerExecuteDelegate>

@end

@implementation SunbeamTimerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [SunbeamTimerManager sharedSunbeamTimerManager].delegate = self;
    
    [[SunbeamTimerManager sharedSunbeamTimerManager] addSunbeamTimer:@"5s" name:@"5s" desc:@"5s timer" timeInterval:5.0 userInfo:nil repeats:YES];
    
    [[SunbeamTimerManager sharedSunbeamTimerManager] addSunbeamTimer:@"10s" name:@"10s" desc:@"10s timer" timeInterval:10.0 userInfo:nil repeats:NO];
    
    [[SunbeamTimerManager sharedSunbeamTimerManager] addSunbeamTimer:@"20s" name:@"20s" desc:@"20s timer" timeInterval:20.0 userInfo:nil repeats:NO];
    
}

// STimer执行回调
- (void) SunbeamTimerExecute:(NSString *) identifier userInfo:(NSDictionary *) userInfo
{
    if ([@"5s" isEqualToString:identifier]) {
        NSLog(@"5s执行");
    } else if ([@"10s" isEqualToString:identifier]) {
        NSLog(@"10s执行");
    } else if ([@"20s" isEqualToString:identifier]) {
        NSLog(@"20s执行");
    }
}

// STimer添加回调
- (void) SunbeamTimerAdded:(NSString *) identifier
{
    
}

// STimer销毁回调
- (void) SunbeamTimerDestroy:(NSString *) identifier
{
    
}

// STimer清理回调
- (void) SunbeamTimerClear:(NSMutableDictionary *) clearSTimerList
{
    
}

@end
