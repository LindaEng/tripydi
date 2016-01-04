//
//  MyCustomSegue.m
//  NookHub
//
//  Created by Ben Wang on 7/28/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCustomSegue.h"

@implementation MyCustomSegue
- (void)perform
{
    UIViewController *source = self.sourceViewController;
    UIViewController *destination = self.destinationViewController;
    
    UIWindow *window = source.view.window;
    
    CATransition *transition = [CATransition animation];
    [transition setDuration:1.0];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [transition setType:kCATransitionPush];
    [transition setSubtype:kCATransitionFromRight];
    [transition setFillMode:kCAFillModeForwards];
    [transition setRemovedOnCompletion:YES];
    
    
    [window.layer addAnimation:transition forKey:kCATransition];
    [window setRootViewController:destination];
}
@end
