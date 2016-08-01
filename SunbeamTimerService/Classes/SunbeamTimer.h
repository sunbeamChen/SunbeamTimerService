//
//  SunbeamTimer.h
//  Pods
//
//  Created by sunbeam on 16/8/1.
//
//

#import <Foundation/Foundation.h>

@interface SunbeamTimer : NSObject

// 唯一标识
@property (nonatomic, copy) NSString* identifier;

// 名称
@property (nonatomic, copy) NSString* name;

// 描述
@property (nonatomic, copy) NSString* desc;

// 执行时间
@property (nonatomic, assign) NSTimeInterval timeInterval;

// 是否循环执行
@property (nonatomic, assign) BOOL repeats;

// NSTimer
@property (nonatomic, strong) NSTimer* timer;

@end
