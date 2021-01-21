//
//  UIResponder+ZBWUISignal.h
//  ZBWUIKit
//
//  Created by 朱博文 on 16/8/29.
//  Copyright © 2016年 朱博文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBWUISignal.h"

@interface UIResponder (ZBWUISignal_ZBWViewModel)

@property (nonatomic) id        zbw_viewModel;

@end


@interface NSObject (ZBWUISignal_ZBWViewModel)

@property (nonatomic) UIResponder   *zbw_responder;

@end
