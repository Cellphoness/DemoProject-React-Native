/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"

#import "RCTBundleURLProvider.h"
#import "RCTRootView.h"

#import "PresentationPop.h"

@interface AppDelegate () <RCTBridgeDelegate>

@property (nonatomic, strong) NSURL *jsCodeLocation;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//  NSURL *jsCodeLocation;

  self.jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
  self.bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
//  RCTBridge 绑定一个单例属性

//  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
//                                                      moduleName:@"DemoProject"
//                                               initialProperties:nil
//                                                   launchOptions:launchOptions];
//  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view.backgroundColor = [UIColor whiteColor];
  
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [btn setTitle:@"JS View" forState:UIControlStateNormal];
  [btn addTarget:self action:@selector(btnHandler) forControlEvents:UIControlEventTouchUpInside];
  [btn sizeToFit];
  [rootViewController.view addSubview:btn];
  btn.center = rootViewController.view.center;
  
  UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
  [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [btn2 setTitle:@"Pop Cuatom View" forState:UIControlStateNormal];
  [btn2 addTarget:self action:@selector(btnHandler2) forControlEvents:UIControlEventTouchUpInside];
  [btn2 sizeToFit];
  [rootViewController.view addSubview:btn2];
  btn2.frame = (CGRect){
    CGPointMake(([UIScreen mainScreen].bounds.size.width - btn2.bounds.size.width) / 2, CGRectGetMaxY(btn.frame) + 30),
    btn2.bounds.size
  };
  
  UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
  [btn0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [btn0 setTitle:@"Custom View" forState:UIControlStateNormal];
  [btn0 addTarget:self action:@selector(btnHandler0) forControlEvents:UIControlEventTouchUpInside];
  [btn0 sizeToFit];
  [rootViewController.view addSubview:btn0];
  btn0.frame = (CGRect){
    CGPointMake(([UIScreen mainScreen].bounds.size.width - btn0.bounds.size.width) / 2, CGRectGetMinY(btn.frame) - 80),
    btn0.bounds.size
  };
//  rootViewController.view = rootView;
  self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
  [self.window makeKeyAndVisible];
  return YES;
}

-(void)btnHandler0
{
  UIViewController *rootViewController = [UIViewController new];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:self.bridge moduleName:@"CustomView" initialProperties:nil];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  rootViewController.view = rootView;
  [(UINavigationController *)self.window.rootViewController pushViewController:rootViewController animated:YES];
}

-(void)btnHandler
{
  UIViewController *rootViewController = [UIViewController new];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:self.bridge moduleName:@"DemoProject" initialProperties:nil];
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  rootViewController.view = rootView;
  [(UINavigationController *)self.window.rootViewController pushViewController:rootViewController animated:YES];
}

-(void)btnHandler2
{
  [PresentationPop presentView:[[RCTRootView alloc] initWithBridge:self.bridge moduleName:@"CustomView" initialProperties:nil] style:PresentStyleBottom];//PresentStyleCenter计算大小有误 PresentStyleBottom默认size:kWIDTH,kWIDTH
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return self.jsCodeLocation;
}

@end
