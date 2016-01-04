//
//  Screen5.m
//  Tripydi
//
//  Created by Ben Wang on 9/11/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//

#import "Screen8.h"
#import "MyCustomSegue.h"

@implementation Screen8
{
    
    CGFloat screenWidth;
    CGFloat screenHeight;
    
}

-(void) viewDidLoad
{
    screenWidth = [[UIScreen mainScreen] bounds].size.width;
    screenHeight =  [[UIScreen mainScreen] bounds].size.height;
    //myBox1.layer.borderWidth = 2.0f;
    UIImageView *myBox1 = [[UIImageView alloc] initWithFrame:CGRectMake((float)0/320 * screenWidth, (float)0/568 * screenHeight, (float)320/320 * screenWidth, (float)568/568 * screenHeight)];
    UIImage *background1 = [[UIImage alloc]init];
    myBox1.contentMode = UIViewContentModeScaleAspectFit;
    background1 = [UIImage imageNamed:@"time.png"];
    //myBox1.layer.borderColor = [UIColor blackColor].CGColor;
    //myBox1.layer.borderWidth = 2.0f;
    myBox1.image = background1;
    [self.view addSubview:myBox1];
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedSegue:)];
    // if labelView is not set userInteractionEnabled, you must do so
    [myBox1 setUserInteractionEnabled:YES];
    [myBox1 addGestureRecognizer:gesture];
    
}

- (void)userTappedSegue:(UIGestureRecognizer*)gestureRecognizer
{
    UIViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Screen9"];
    MyCustomSegue *segue = [[MyCustomSegue alloc] initWithIdentifier:@"" source:self destination:toViewController];
    [self prepareForSegue:segue sender:self];
    [segue perform];
}
@end
