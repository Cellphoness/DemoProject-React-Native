//
//  PresentationPop.h
//  PresentationController
//
//  Created by kencai on 2018/4/11.
//  Copyright © 2018年 DragonPass. All rights reserved.
//

#import "UIViewController+Present.h"
#import "RCTViewManager.h"

//#import "PresentationPop.h"
//[PresentationPop presentView:[NSClassFromString(@"BottomView") new] style:PresentStyleBottom];
//[PresentationPop presentView:[NSClassFromString(@"CenterView") new] style:PresentStyleCenter];

@interface PresentationPop : NSObject <RCTBridgeModule>

+(void)presentView:(UIView *)view style:(PresentStyle)style;
+(void)dismiss:(UIView *)view;

@end


