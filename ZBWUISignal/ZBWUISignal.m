//
//  ZBWUISignal.m
//  ZBWUIKit
//
//  Created by 朱博文 on 16/8/29.
//  Copyright © 2016年 朱博文. All rights reserved.
//

#import "ZBWUISignal.h"
#import <objc/runtime.h>

@interface ZBWUISignal ()

@property (nonatomic) NSMutableArray         *mutableRouteList;     // signal的路由路径

@end

@implementation ZBWUISignal

- (id)initWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)dic from:(id)from
{
    if (self = [super init]) {
        // 校验name
        self.name = [name isKindOfClass:[NSString class]] ? name : @"";
        self.userInfo = [dic isKindOfClass:[NSDictionary class]] ? dic : nil;
        self.from = from;
        self.object = object;
        
        // selectors
        NSString *prefix = @"onHandleUpwardSignal";
        if ([self isKindOfClass:NSClassFromString(@"ZBWUIDownwardSignal")]) {
            prefix = @"onHandleDownwardSignal";
        }
        NSString *className = NSStringFromClass(self.from.class);
        NSString *selectStr = [NSString stringWithFormat:@"%@_%@_%@:",prefix, className, self.name];
        SEL sel1 = NSSelectorFromString(selectStr);
        selectStr = [NSString stringWithFormat:@"%@_%@_:",prefix, className];
        SEL sel2 = NSSelectorFromString(selectStr);
        selectStr = [NSString stringWithFormat:@"%@__:",prefix];
        SEL sel3 = NSSelectorFromString(selectStr);
        _selList[0] = sel1;
        _selList[1] = sel2;
        _selList[2] = sel3;
        
        
    }
    return self;
}

- (void)fire
{
    [self route];
    
//    self.callback = nil;
}

- (void)route {
    id receiver = [(id<ZBWUISignalProtocol>)self nextReceiver:self.from];
    
    while (receiver) {
        SEL sel = nil;
        // 有实现处理signal的方法
        for (int i = 0; i < 3 ; i++) {
            if ([receiver respondsToSelector:_selList[i]]) {
                sel = _selList[i];
                break;
            }
        }
        
        if (sel) {
            // 记录路径
            [self.mutableRouteList addObject:receiver];
            // 处理
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [receiver performSelector:sel withObject:self];
#pragma clang diagnostic pop
        }
        
        // 已经到达终点，结束
        if (self.arrived) {
            return;
        }
        
        receiver = [(id<ZBWUISignalProtocol>)self nextReceiver:receiver];
    }

}

#pragma mark- Getter

- (NSArray *)routeList
{
    return self.mutableRouteList.copy;
}

- (NSMutableArray *)mutableRouteList
{
    if (!_mutableRouteList) {
        _mutableRouteList = [NSMutableArray arrayWithCapacity:3];
    }
    return _mutableRouteList;
}

@end
