//
//  ZBWUIUpwardSignal.m
//  ZBWUIKit
//
//  Created by 朱博文 on 16/8/29.
//  Copyright © 2016年 朱博文. All rights reserved.
//

#import "ZBWUIUpwardSignal.h"
#import "UIResponder+ZBWUISignal.h"

@implementation ZBWUIUpwardSignal

+ (instancetype)signalWithName:(NSString *)name
                        object:(id)object
                      userInfo:(NSDictionary *)dic
                          from:(id)from
{
//    if (![from isKindOfClass:[UIResponder class]]) {
//        return nil;
//    }
    ZBWUIUpwardSignal *signal = [[ZBWUIUpwardSignal alloc] initWithName:name object:object userInfo:dic from:from];
    return signal;
}

- (id)nextReceiver:(id)from {
    if (!from) {
        return nil;
    }
    id nextReceiver = nil;
    
    if ([from isKindOfClass:[UIResponder class]]) {
        UIResponder *r = (UIResponder *)from;
        nextReceiver = r.zbw_viewModel ? : r.nextResponder;
    } else {
        if (![from respondsToSelector:@selector(zbw_responder)]) {
            return nil;
        }
        nextReceiver = [(NSObject *)from zbw_responder].nextResponder;
    }
    return nextReceiver;
}

@end
