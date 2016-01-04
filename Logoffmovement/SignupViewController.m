//
//  SignupViewController.m
//  Logoffmovement
//
//  Created by Ben Wang on 7/7/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//

#import "SignupViewController.h"


@interface SignupViewController ()


@end

@implementation SignupViewController
{
    CGFloat screenWidth;
    CGFloat screenHeight;
    CGRect screenRect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    // Do any additional setup after loading the view.
 
    
    
    UIImage *image = [UIImage imageNamed: @"logo_graphic.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((float)(screenWidth - (float)250/320 * screenWidth)/2, (float)130/568 * screenHeight, (float)250/320 * screenWidth, (float)250/568 * screenHeight)];
    [imgView setImage:image];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgView];
    
    UILabel *lbl1 = [[UILabel alloc] init];
    lbl1.textColor = [UIColor blackColor];
    lbl1.frame = CGRectMake((float)0/320 * screenWidth, (float)70/568 * screenHeight, (float)320/320 * screenWidth, (float)40/568 * screenHeight);
    lbl1.backgroundColor=[UIColor clearColor];
    lbl1.textColor=[UIColor blackColor];
    lbl1.userInteractionEnabled=NO;
    lbl1.text= @"Venture";
    lbl1.font=[lbl1.font fontWithSize:45];
    lbl1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl1];
    
    

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([[segue identifier] isEqualToString:@"home"])
    {
        // Get reference to the destination view controller
        //UITabBarController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        //[vc setMyObjectHere:object];
    }
}


@end
