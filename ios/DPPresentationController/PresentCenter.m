//
//  PresentCenter.m
//  PresentationController
//
//  Created by kencai on 2018/4/9.
//  Copyright © 2018年 DragonPass. All rights reserved.
//

#import "PresentCenter.h"
#import "PresentationPop.h"
#import "RCTRootView.h"
@interface PresentCenter ()

@property (nonatomic, assign) CGSize    controllerSize;
@property (nonatomic, strong) UIView    *blackView;

@property (nonatomic, assign) CGRect    orginRect;

@end

@implementation PresentCenter

-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
  self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
  if (self) {
    
    if (presentedViewController.view) {
      CGSize size = [presentedViewController.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
      if ([presentedViewController.view isKindOfClass:[RCTRootView class]]) {
        size = presentedViewController.view.reactViewSize;
      }
      self.controllerSize = size;
      self.orginRect = CGRectMake(([UIScreen mainScreen].bounds.size.width - self.controllerSize.width)/2, ([UIScreen mainScreen].bounds.size.height - self.controllerSize.height)/2, self.controllerSize.width, self.controllerSize.height);
    } else {
      self.controllerSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
    }
  }
  return self;
}

-(CGRect)frameOfPresentedViewInContainerView
{
    return self.orginRect;
}

-(void)presentationTransitionWillBegin
{
    self.presentedView.hidden = YES;
    self.blackView.hidden = YES;
    [self.containerView insertSubview:self.blackView atIndex:0];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.presentedView.hidden = NO;
        self.blackView.hidden = NO;
        
        self.presentedView.transform = CGAffineTransformMakeScale(0,0);
        [UIView animateWithDuration:0.2 animations:^{
            self.presentedView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                self.presentedView.transform = CGAffineTransformIdentity;
            }];
        }];
    });
}

//避免动画冲突 自定义的动画写在转场结束的方法里

//出来的太慢了 可以直接在presentationTransitionWillBegin 写延时
-(void)presentationTransitionDidEnd:(BOOL)completed
{
//    self.presentedView.hidden = NO;
//    self.blackView.hidden = NO;
//
//    self.presentedView.transform = CGAffineTransformMakeScale(0,0);
//    [UIView animateWithDuration:0.2 animations:^{
//        self.presentedView.transform = CGAffineTransformMakeScale(1.2, 1.2);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.2 animations:^{
//            self.presentedView.transform = CGAffineTransformIdentity;
//        }];
//    }];
}

-(void)dismissalTransitionWillBegin
{
    
}

-(void)dismissalTransitionDidEnd:(BOOL)completed
{
    
}

//-(void)containerViewWillLayoutSubviews
//{
//    [super containerViewWillLayoutSubviews];
//    [self.containerView insertSubview:self.blackView atIndex:0];//加在最底下
//}

-(void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];

}

-(UIView *)blackView
{
    if (!_blackView) {
        _blackView = [UIView new];
        if (!CGRectIsNull(self.containerView.bounds)) {
            _blackView.frame = self.containerView.bounds;
        }
        _blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
      [_blackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismiss:)]];
    }
    return _blackView;
}

-(void)tapToDismiss:(UIGestureRecognizer *)sender
{
  if (sender.state == UIGestureRecognizerStateEnded) {
    [self.presentedViewController dismiss];
  }
}

@end
