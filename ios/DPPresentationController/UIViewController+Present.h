//
//  UIViewController+Present.h
//  DragonPassCn
//
//  Created by kencai on 2018/4/11.
//  Copyright © 2018年 Ray. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PresentStyleCenter = 0,
    PresentStyleBottom,
} PresentStyle;

@interface UIViewController (Present)

-(void)dismiss;

@end


@interface UIViewController (PresentStyle)

@property (nonatomic, assign) PresentStyle style;

@end


@interface UIView (VC)

@property (nonatomic, readonly) UIViewController *viewController;
@property (nonatomic, assign)   CGSize            reactViewSize;

@end
