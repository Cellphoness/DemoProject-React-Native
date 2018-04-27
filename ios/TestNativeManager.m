//
//  RCTViewManager+ActionHelper.m
//  DemoProject
//
//  Created by kencai on 2018/3/6.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "TestNativeManager.h"
#import "RCTViewManager.h"
#import "RCTRootView.h"
#import "RCTUIManager.h"

@implementation TestNativeManager

RCT_EXPORT_MODULE();

/// 拿到当前View
- (UIView *) getViewWithTag:(NSNumber *)tag {
  NSLog(@"%@", [NSThread currentThread]);
  UIView *view = [self.bridge.uiManager viewForReactTag:tag];
  return [view isKindOfClass:[UIView class]] ? view : nil;
}

//保存到本地 @"movie_list":data
RCT_EXPORT_METHOD(testFunction:(id)data
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject){
  
//  UIView *myView = [self getViewWithTag:reactTag];
  NSLog(@"data:%@", data);
  NSLog(@"%@", [NSThread currentThread]);
  
  if ([data isKindOfClass:[NSDictionary class]]) {
    
    //存数据
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"movie_list"];
    
    
  }else {
    reject(@"1002", @"获取数值出错", [NSError errorWithDomain:@"获取数值出错" code:1002 userInfo:nil]);
  }
}

RCT_EXPORT_METHOD(getMovieData:(id)total
                  resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject){
  
  //  UIView *myView = [self getViewWithTag:reactTag];
  NSLog(@"total:%@", total);
  NSLog(@"%@", [NSThread currentThread]);
  
  NSDictionary *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"movie_list"];
  
  if (resolve && data) {
    
    resolve(data);
    
    
  } else {
    reject(@"1002", @"获取数值出错", [NSError errorWithDomain:@"获取数值出错" code:1002 userInfo:nil]);
  }
}


@end
