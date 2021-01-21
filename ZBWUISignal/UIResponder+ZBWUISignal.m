//
//  UIResponder+ZBWUISignal.m
//  ZBWUIKit
//
//  Created by 朱博文 on 16/8/29.
//  Copyright © 2016年 朱博文. All rights reserved.
//

#import "UIResponder+ZBWUISignal.h"
#import <objc/runtime.h>

const void* UIResponder_ZBWViewModel_Key = &UIResponder_ZBWViewModel_Key;

@implementation UIResponder (ZBWUISignal_ZBWViewModel)

- (id)zbw_viewModel {
    return objc_getAssociatedObject(self, UIResponder_ZBWViewModel_Key);
}

- (void)setZbw_viewModel:(id)zbw_viewModel {
    objc_setAssociatedObject(self, UIResponder_ZBWViewModel_Key, zbw_viewModel, OBJC_ASSOCIATION_RETAIN);
    [zbw_viewModel setZbw_responder:self];
}

@end


@interface ZBWResponderProxy : NSObject

@property (nonatomic, weak) UIResponder     *responder;

@end

@implementation ZBWResponderProxy

@end

const void* NSObject_ZBWViewModel_Key = &NSObject_ZBWViewModel_Key;
@implementation NSObject (ZBWUISignal_ZBWViewModel)

- (UIResponder *)zbw_responder {
    ZBWResponderProxy *proxy = objc_getAssociatedObject(self, NSObject_ZBWViewModel_Key);
    
    return proxy.responder;
}

- (void)setZbw_responder:(UIResponder *)zbw_responder {
    // 这个属性是给ViewModel设置response的，ViewModel不能是UIResponder
    if ([self isKindOfClass:[UIResponder class]]) {
        return;
    }
    
    if (zbw_responder == [self zbw_responder]) {
        return;
    }
    
    if (!zbw_responder && ![zbw_responder isKindOfClass:[UIResponder class]]) {
        return;
    }
    
    ZBWResponderProxy *proxy = [[ZBWResponderProxy alloc] init];
    proxy.responder = zbw_responder;
    
    objc_setAssociatedObject(self, NSObject_ZBWViewModel_Key, proxy, OBJC_ASSOCIATION_RETAIN);
}

@end
