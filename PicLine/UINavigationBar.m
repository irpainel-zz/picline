//
//  UINavigationBar.m
//  FinalProject
//
//  Created by students on 3/21/13.
//  Copyright (c) 2013 irp. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface UINavigationBar (CustomImage)

-(void) applyDefaultStyle;

@end

//Override For Custom Navigation Bar
@implementation UINavigationBar (CustomImage)


-(void)willMoveToWindow:(UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    [self applyDefaultStyle];
}

- (void)applyDefaultStyle {
    // add the drop shadow
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset = CGSizeMake(0.0, 1);
    self.layer.shadowOpacity = 0.9;
    self.layer.masksToBounds = NO;
    self.layer.shouldRasterize = YES;
}

@end
