//
//  PresentBottom.m
//  PresentationController
//
//  Created by kencai on 2018/4/9.
//  Copyright © 2018年 DragonPass. All rights reserved.
//

#import "PresentBottom.h"
#import "PresentationPop.h"

@interface PresentBottom ()

@property (nonatomic, assign) CGFloat   controllerHeight;
@property (nonatomic, strong) UIView    *blackView;

@end

@implementation PresentBottom

-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        if (!presentedViewController.view) {
            return self;
        }
        CGSize size = [presentedViewController.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        if ([presentedViewController respondsToSelector:@selector(controllerHeight)]) {
            self.controllerHeight = size.height;
        } else {
            self.controllerHeight = [UIScreen mainScreen].bounds.size.width;
        }
    }
    return self;
}

-(CGRect)frameOfPresentedViewInContainerView
{
    return CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.controllerHeight, [UIScreen mainScreen].bounds.size.width, self.controllerHeight);
}

-(void)presentationTransitionWillBegin
{
    self.blackView.alpha = 0;
    [self.containerView addSubview:self.blackView];
    [UIView animateWithDuration:0.5 animations:^{
        self.blackView.alpha = 1;
    }];
}

-(void)dismissalTransitionWillBegin
{
    [UIView animateWithDuration:0.5 animations:^{
        self.blackView.alpha = 0;
    }];
}

-(void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed) {
        [self.blackView removeFromSuperview];
    }
}

-(void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    //只允许调用一次
//    [self.presentedView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
//    [self.presentedView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
  self.presentedView.frame = (CGRect){CGPointMake(0, [UIScreen mainScreen].bounds.size.height - self.controllerHeight), self.presentedView.bounds.size};
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
