//
//  TabBarController.m
//  Logoffmovement
//
//  Created by Ben Wang on 7/7/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//

#import "TabBarController.h"
#import "HomeViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

        HomeViewController *view1 = [[HomeViewController alloc] init];
        
        NSMutableArray *tabViewControllers = [[NSMutableArray alloc] init];
        [tabViewControllers addObject:view1];
        
        [self setViewControllers:tabViewControllers];
        //can't set this until after its added to the tab bar
        view1.tabBarItem =
        [[UITabBarItem alloc] initWithTitle:@"Home"
                                      image:nil
                                        tag:1];
        
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
