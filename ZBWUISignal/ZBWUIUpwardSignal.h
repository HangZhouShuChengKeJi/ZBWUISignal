//
//  ZBWUIUpwardSignal.h
//  ZBWUIKit
//
//  Created by 朱博文 on 16/8/29.
//  Copyright © 2016年 朱博文. All rights reserved.
//

#import "ZBWUISignal.h"

@interface ZBWUIUpwardSignal : ZBWUISignal<ZBWUISignalProtocol>

+ (instancetype)signalWithName:(NSString *)name
                        object:(id)object
                      userInfo:(NSDictionary *)dic
                          from:(id)from;

@end
