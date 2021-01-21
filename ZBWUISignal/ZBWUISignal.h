//
//  ZBWUISignal.h
//  ZBWUIKit
//
//  Created by 朱博文 on 16/8/29.
//  Copyright © 2016年 朱博文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ZBWSignalCallback)(BOOL success, id object, id userInfo);

#define ZBW_Signal_Arrivaled    do{signal.arrived = YES;}while (0);

#define ZBW_Is_Signal(__signalName) ([signal.name isEqualToString:__signalName])

#define ZBW_SendUpSignal(__signalName,__object,__userinfo,__from) \
[[ZBWUIUpwardSignal signalWithName:__signalName object:__object userInfo:__userinfo from:__from] fire];

#define ZBW_SendUpSignalWithCallback(__signalName,__object,__userinfo,__from,__callback) \
do{\
    ZBWUISignal *signal = [ZBWUIUpwardSignal signalWithName:__signalName object:__object userInfo:__userinfo from:__from];\
    signal.callback = __callback;\
    [signal fire];\
}\
while (0);


#define ZBW_SendDownSignal(__signalName,__object,__userinfo,__from) \
[[ZBWUIDownwardSignal signalWithName:__signalName object:__object userInfo:__userinfo from:__from] fire];

#define ZBW_SendDownSignalWithCallback(__signalName,__object,__userinfo,__from,__callback) \
do{\
ZBWUISignal *signal = [ZBWUIDownwardSignal signalWithName:__signalName object:__object userInfo:__userinfo from:__from];\
signal.callback = __callback;\
[signal fire];\
}\
while (0);

#define ZBW_UISignal_Up_Handle(_aClazz, _signalName) \
-(void)onHandleUpwardSignal_##_aClazz##_##_signalName:(ZBWUISignal *)signal

#define ZBW_UISignal_Down_Handle(_aClazz, _signalName) \
-(void)onHandleDownwardSignal_##_aClazz##_##_signalName:(ZBWUISignal *)signal


@protocol ZBWUISignalProtocol <NSObject>

- (id)nextReceiver:(id)from;

@end

@interface ZBWUISignal : NSObject
{
    SEL _selList[3];
}

@property (nonatomic, weak)NSObject      *from;          // 发起signal的View
@property (nonatomic, readonly) NSArray     *routeList;     // signal的路由路径
@property (nonatomic, retain) id                    object;         // signal携带的数据
@property (nonatomic, retain) NSDictionary          *userInfo;      // signal携带的数据
@property (nonatomic, retain) NSString              *name;
@property (nonatomic, copy) ZBWSignalCallback      callback;

@property (nonatomic)           BOOL        arrived;


- (id)initWithName:(NSString *)name
            object:(id)object
          userInfo:(NSDictionary *)dic
              from:(id)from;

- (void)fire;

@end
