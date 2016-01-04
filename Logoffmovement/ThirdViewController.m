//
//  FirstViewController.m
//  Logoff
//
//  Created by Ben Wang on 7/6/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//

#import "ThirdViewController.h"
//#import <CoreLocation/CoreLocation.h>

@import GoogleMaps;

@interface ThirdViewController ()

@end
@implementation ThirdViewController{
    GMSMapView *mapView_;
    CGRect screenRect;
    CGFloat statusbarheight;
    UITableView* tableView;
    NSMutableArray* yourItemsArray;
    CGFloat screenWidth;
    CGFloat screenHeight;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager startUpdatingLocation];
    /////////////////
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation   *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self.locationManager stopUpdatingLocation];
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        statusbarheight = 20;
        
        UIImage *mapgrey = [UIImage imageNamed: @"maps_grey.png"];
        UIImage *searchgrey = [UIImage imageNamed: @"search_grey.png"];
        
        UIButton *mapbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [mapbutton addTarget:self
                      action:@selector(mapbuttonMethod)
            forControlEvents:UIControlEventTouchUpInside];
        //[mapbutton setTitle:@"Show View" forState:UIControlStateNormal];
        [mapbutton setImage:mapgrey forState:UIControlStateNormal];
        mapbutton.contentMode = UIViewContentModeScaleAspectFit;
        mapbutton.frame = CGRectMake(screenWidth - (float)50/320 * screenWidth, statusbarheight, (float)50/320 * screenWidth, (float)50/568 * screenHeight);
        [self.view addSubview:mapbutton];
        
        UIButton *searchbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [searchbutton addTarget:self
                         action:@selector(searchbuttonMethod:)
               forControlEvents:UIControlEventTouchUpInside];
        //[mapbutton setTitle:@"Show View" forState:UIControlStateNormal];
        [searchbutton setImage:searchgrey forState:UIControlStateNormal];
        searchbutton.contentMode = UIViewContentModeScaleAspectFit;
        searchbutton.frame = CGRectMake(0, statusbarheight, (float)50/320 * screenWidth, (float)50/568 * screenHeight);
        [self.view addSubview:searchbutton];
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude zoom:16];
        mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, statusbarheight, screenWidth, screenHeight * .60) camera:camera];
        mapView_.myLocationEnabled = YES;
        mapView_.delegate = self;
        [self.view addSubview:mapView_];
        
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
        //marker.icon = [UIImage imageNamed:@"MapMarker_Ball_Red"];
        marker.icon = [self image:[UIImage imageNamed:@"MapMarker_Ball_Red"] scaledToSize:CGSizeMake(35.0f, 35.0f)];
        marker.groundAnchor = CGPointMake(.5, .5);
        marker.map = mapView_;
        
        UILabel *lbl1 = [[UILabel alloc]init];
        lbl1.textColor = [UIColor blackColor];
        lbl1.frame = CGRectMake(0, screenHeight - (screenHeight*.35 + (float)50/568 * screenHeight + statusbarheight) - (float)15/568 * screenHeight, screenWidth, screenHeight * .25 + (float)50/568 * screenHeight + statusbarheight);
        lbl1.backgroundColor=[UIColor clearColor];
        lbl1.textColor=[UIColor blackColor];
        lbl1.userInteractionEnabled=NO;
        lbl1.text= @"Help";
        lbl1.font=[lbl1.font fontWithSize:15];
        [lbl1 setFont:[UIFont boldSystemFontOfSize:17]];
        lbl1.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lbl1];
        
        UILabel *lbl2 = [[UILabel alloc]init];
        lbl2.textColor = [UIColor blackColor];
        lbl2.frame = CGRectMake(0, screenHeight - (screenHeight*.35 + (float)50/568 * screenHeight + statusbarheight) +(float)10/568 * screenHeight, screenWidth, screenHeight * .25 + (float)50/568 * screenHeight + statusbarheight);
        lbl2.backgroundColor=[UIColor clearColor];
        lbl2.textColor=[UIColor blackColor];
        lbl2.userInteractionEnabled=NO;
        lbl2.text= @"Using this app";
        lbl2.font=[lbl2.font fontWithSize:17];
        lbl2.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lbl2];
        
        UILabel *lbl3 = [[UILabel alloc]init];
        lbl3.textColor = [UIColor blackColor];
        lbl3.frame = CGRectMake(0, screenHeight - (screenHeight*.35 + (float)50/568 * screenHeight + statusbarheight) + (float)35/568 * screenHeight, screenWidth, screenHeight * .25 + (float)50/568 * screenHeight + statusbarheight);
        lbl3.backgroundColor=[UIColor clearColor];
        lbl3.textColor=[UIColor blackColor];
        lbl3.userInteractionEnabled=NO;
        lbl3.text= @"Privacy policy";
        lbl3.font=[lbl3.font fontWithSize:17];
        lbl3.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lbl3];
        
        UILabel *lbl4 = [[UILabel alloc]init];
        lbl4.textColor = [UIColor blackColor];
        lbl4.frame = CGRectMake(0, screenHeight - (screenHeight*.35 + (float)50/568 * screenHeight + statusbarheight) + (float)60/568 * screenHeight, screenWidth, screenHeight * .25 + (float)50/568 * screenHeight + statusbarheight);
        lbl4.backgroundColor=[UIColor clearColor];
        lbl4.textColor=[UIColor blackColor];
        lbl4.userInteractionEnabled=NO;
        lbl4.text= @"About our partners";
        lbl4.font=[lbl4.font fontWithSize:17];
        lbl4.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lbl4];
        
        UILabel *lbl5 = [[UILabel alloc]init];
        lbl5.textColor = [UIColor blackColor];
        lbl5.frame = CGRectMake(0, screenHeight - (screenHeight*.35 + (float)50/568 * screenHeight + statusbarheight) + (float)85/568 * screenHeight, screenWidth, screenHeight * .25 + (float)50/568 * screenHeight + statusbarheight);
        lbl5.backgroundColor=[UIColor clearColor];
        lbl5.textColor=[UIColor blackColor];
        lbl5.userInteractionEnabled=NO;
        lbl5.text= @"About Us";
        lbl5.font=[lbl5.font fontWithSize:17];
        lbl5.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lbl5];

    }
}
- (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size
{
    //avoid redundant drawing
    if (CGSizeEqualToSize(originalImage.size, size))
    {
        return originalImage;
    }
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //draw
    [originalImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}
- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    // your code
}
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    // your code
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    marker.zIndex = 1;
    //marker.icon = [UIImage imageNamed:@"MapMarker_Ball_Right_Chartreuse"];
    marker.icon = [self image:[UIImage imageNamed:@"MapMarker_Ball_Right_Chartreuse"] scaledToSize:CGSizeMake(35.0f, 35.0f)];
    marker.map = mapView;
}
- (void)mapbuttonMethod {
    if(mapView_.frame.size.height > 0)
    {
        [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            mapView_.frame = CGRectMake(0, statusbarheight + (float)50/568 * screenHeight, screenRect.size.width, 0);
        }completion:^(BOOL finished) {mapView_.frame = CGRectMake(0, 0, 0, 0);}];
    }
    else
    {
        mapView_.frame = CGRectMake(0, statusbarheight + (float)50/568 * screenHeight, screenWidth, 0);
        [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            mapView_.frame = CGRectMake(0, (float)50/568 * screenHeight + statusbarheight, screenWidth, screenHeight * .60);
        }completion:^(BOOL finished) {}];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
