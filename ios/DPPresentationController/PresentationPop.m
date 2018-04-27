//
//  PresentationPop.m
//  PresentationController
//
//  Created by kencai on 2018/4/11.
//  Copyright © 2018年 DragonPass. All rights reserved.
//

#import "PresentationPop.h"
#import "RCTRootView.h"
#import "AppDelegate.h"

@implementation PresentationPop

RCT_EXPORT_MODULE();

/*{
 name:"",
 size:{width:"", height:""}
 style:PresentStyle
}*/
RCT_EXPORT_METHOD(presentReactView:(id)data
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject){
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    NSInteger style = [data objectForKey:@"style"] ? [[data objectForKey:@"style"] integerValue] : 0;
    
    if ([data[@"name"] isKindOfClass:[NSString class]]) {
      
      if (NSClassFromString(data[@"name"])) {
        UIView *view = [NSClassFromString(data[@"name"]) new];
        [PresentationPop presentView:view style:style];
      } else {
        RCTBridge *bridge = [(AppDelegate *)[[UIApplication sharedApplication] delegate] bridge];
        UIView *view = [[RCTRootView alloc] initWithBridge:bridge moduleName:[data objectForKey:@"name"] initialProperties:nil];
        view.reactViewSize = CGSizeMake([[data objectForKey:@"size"][@"width"] floatValue], [[data objectForKey:@"size"][@"height"] floatValue]);
        [PresentationPop presentView:view style:style];
      }
      
    }
    
  });
}

+(void)presentView:(UIView *)view style:(PresentStyle)style
{
    if ([view isKindOfClass:[UIView class]]) {
        UIViewController *vc = [UIViewController new];
        vc.modalPresentationStyle = UIModalPresentationCustom;
        switch (style) {
            case PresentStyleBottom:
                vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                vc.style = PresentStyleBottom;
                break;
            case PresentStyleCenter:
                vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                vc.style = PresentStyleCenter;
                break;
            default:
                break;
        }
        vc.transitioningDelegate = (id<UIViewControllerTransitioningDelegate>)vc;
        vc.view = view;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    }
}

+(void)dismiss:(UIView *)view
{
    [view.viewController dismiss];
}

@end


