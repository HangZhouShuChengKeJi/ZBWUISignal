//
//  ZBWUIDownwardSignal.m
//  ZBWUIKit
//
//  Created by 朱博文 on 16/8/29.
//  Copyright © 2016年 朱博文. All rights reserved.
//

#import "ZBWUIDownwardSignal.h"
#import "UIResponder+ZBWUISignal.h"

@implementation ZBWUIDownwardSignal
+ (instancetype)signalWithName:(NSString *)name
                        object:(id)object
                      userInfo:(NSDictionary *)dic
                          from:(id)from
{
    if ([from isKindOfClass:[UIResponder class]]) {
        return nil;
    }
    
    ZBWUIDownwardSignal *signal = [[ZBWUIDownwardSignal alloc] initWithName:name object:object userInfo:dic from:from];
    return signal;
}

- (id)nextReceiver:(id)from {
    if (!from) {
        return nil;
    }
    id nextReceiver = nil;
    
    if ([from isKindOfClass:[UIResponder class]]) {
        
    } else {
        nextReceiver = [(NSObject *)from zbw_responder];
    }
    return nextReceiver;
}

@end
