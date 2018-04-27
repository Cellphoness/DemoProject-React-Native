//
//  RCTViewManager+FindViewHelper.m
//  DemoProject
//
//  Created by kencai on 2018/3/19.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "RCTViewManager+FindViewHelper.h"
#import "RCTBridge.h"
#import "RCTBorderStyle.h"
#import "RCTConvert.h"
#import "RCTEventDispatcher.h"
#import "RCTLog.h"
#import "RCTShadowView.h"
#import "RCTUIManager.h"
#import "RCTUtils.h"
#import "RCTView.h"
#import "UIView+React.h"

@implementation RCTViewManager (FindViewHelper)

/// 拿到当前View
- (UIView *) getViewWithTag:(NSNumber *)tag {
  NSLog(@"%@", [NSThread currentThread]);
  UIView *view = [self.bridge.uiManager viewForReactTag:tag];
  return [view isKindOfClass:[UIView class]] ? view : nil;
}

RCT_EXPORT_METHOD(viewWithReactTag:(id)data
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject){
  __block UIView *view = nil;
  RCTExecuteOnMainQueue(^{
    view = [self getViewWithTag:data];
    
    if (view) {
      resolve([NSString stringWithFormat:@"view:frame:%@", NSStringFromCGRect(view.frame)
               ]);
    } else {
      reject(@"1003", @"获取ViewId出错", [NSError errorWithDomain:@"获取ViewId出错" code:1003 userInfo:nil]);
    }
  });
}


@end
