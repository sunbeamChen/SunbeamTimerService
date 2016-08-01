//
//  SunbeamTimer.m
//  Pods
//
//  Created by sunbeam on 16/8/1.
//
//

#import "SunbeamTimer.h"

@implementation SunbeamTimer

-(NSString *)description
{
    return [NSString stringWithFormat:@"STimer[%@][%@][%@][%f][%@][%@]", self.identifier, self.name, self.desc, self.timeInterval, self.timer.userInfo, self.timer];
}

@end
