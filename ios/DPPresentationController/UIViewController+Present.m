//
//  UIViewController+Present.m
//  DragonPassCn
//
//  Created by kencai on 2018/4/11.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import "UIViewController+Present.h"


#import <objc/objc.h>
#import <objc/runtime.h>
#define NER_SYNTHESIZE_UINT(getter, setter, ...) \
- (PresentStyle)getter {\
return [objc_getAssociatedObject(self, _cmd) integerValue];\
}\
- (void)setter:(PresentStyle)getter {\
objc_setAssociatedObject(self, @selector(getter), @(getter), OBJC_ASSOCIATION_RETAIN);\
__VA_ARGS__;\
}

#define NER_SYNTHESIZE_STRUCT(getter, setter, type, ...) \
- (type)getter {\
return [objc_getAssociatedObject(self, _cmd) type##Value];\
}\
- (void)setter:(type)getter {\
objc_setAssociatedObject(self, @selector(getter), [NSValue valueWith##type:getter], OBJC_ASSOCIATION_RETAIN);\
__VA_ARGS__;\
}

@implementation UIView (VC)

NER_SYNTHESIZE_STRUCT(reactViewSize, setReactViewSize, CGSize)

- (UIViewController *)viewController {
  for (UIView *view = self; view; view = view.superview) {
    UIResponder *nextResponder = [view nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
      return (UIViewController *)nextResponder;
    }
  }
  return nil;
}

@end

@implementation UIViewController (PresentStyle)

NER_SYNTHESIZE_UINT(style, setStyle)

@end

@implementation UIViewController (Present)

-(void)dismiss
{
    if (self.style == PresentStyleCenter && self.presentationController && [self.presentationController valueForKey:@"blackView"]) {
        UIView *view = [self.presentationController valueForKey:@"blackView"];
        [view removeFromSuperview];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    if (presented.style == PresentStyleCenter) {
        return [[NSClassFromString(@"PresentCenter") alloc] initWithPresentedViewController:presented presentingViewController:source];
    } else if (presented.style == PresentStyleBottom) {
        return [[NSClassFromString(@"PresentBottom") alloc] initWithPresentedViewController:presented presentingViewController:source];
    } else {
        return [[UIPresentationController alloc] initWithPresentedViewController:presented presentingViewController:source];
    }
}

@end
