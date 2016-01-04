//
//  FirstViewController.m
//  Logoff
//
//  Created by Ben Wang on 7/6/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//

#import "SecondViewController.h"
//#import <CoreLocation/CoreLocation.h>

@interface SecondViewController ()

@end
@implementation SecondViewController{
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
        lbl1.frame = CGRectMake((float)20/320 * screenWidth, screenHeight * .5, screenWidth, screenHeight * .25 + (float)50/568 * screenHeight + statusbarheight);
        lbl1.backgroundColor=[UIColor clearColor];
        lbl1.textColor=[UIColor blackColor];
        lbl1.userInteractionEnabled=NO;
        lbl1.text= @"Your Profile";
        lbl1.font=[lbl1.font fontWithSize:15];
        [lbl1 setFont:[UIFont boldSystemFontOfSize:15]];
        [self.view addSubview:lbl1];
        
        UILabel *lbl2 = [[UILabel alloc]init];
        lbl2.textColor = [UIColor blackColor];
        lbl2.frame = CGRectMake((float)20/320 * screenWidth, screenHeight - (screenHeight*.35 + (float)50/568 * screenHeight + statusbarheight) + (float)15/568 * screenHeight, screenWidth, screenHeight * .25 + (float)50/568 * screenHeight + statusbarheight);
        lbl2.backgroundColor=[UIColor clearColor];
        lbl2.textColor=[UIColor blackColor];
        lbl2.userInteractionEnabled=NO;
        lbl2.text= @"Username: Jennifer";
        lbl2.font=[lbl2.font fontWithSize:12];
        [self.view addSubview:lbl2];
        
        UILabel *lbl3 = [[UILabel alloc]init];
        lbl3.textColor = [UIColor blackColor];
        lbl3.frame = CGRectMake((float)20/320 * screenWidth, screenHeight - (screenHeight*.35 + (float)50/568 * screenHeight + statusbarheight) + (float)25/568 * screenHeight, screenWidth, screenHeight * .25 + (float)50/568 * screenHeight + statusbarheight);
        lbl3.backgroundColor=[UIColor clearColor];
        lbl3.textColor=[UIColor blackColor];
        lbl3.userInteractionEnabled=NO;
        lbl3.text= @"Email: Jen.Doe@gmail.com";
        lbl3.font=[lbl3.font fontWithSize:12];
        [self.view addSubview:lbl3];
        
        UILabel *lbl4 = [[UILabel alloc]init];
        lbl4.textColor = [UIColor blackColor];
        lbl4.frame = CGRectMake((float)20/320 * screenWidth, screenHeight - (screenHeight*.35 + (float)50/568 * screenHeight + statusbarheight) + (float)45/568 * screenHeight, screenWidth, screenHeight * .25 + (float)50/568 * screenHeight + statusbarheight);
        lbl4.backgroundColor=[UIColor clearColor];
        lbl4.textColor=[UIColor blackColor];
        lbl4.userInteractionEnabled=NO;
        lbl4.text= @"Preferred Payment Method: Visa Card ending in 8716";
        lbl4.font=[lbl4.font fontWithSize:12];
        [self.view addSubview:lbl4];
        
        UILabel *lbl5 = [[UILabel alloc]init];
        lbl5.textColor = [UIColor blackColor];
        lbl5.frame = CGRectMake((float)20/320 * screenWidth, screenHeight - (screenHeight*.35 + (float)50/568 * screenHeight + statusbarheight) + (float)55/568 * screenHeight, screenWidth, screenHeight * .25 + (float)50/568 * screenHeight + statusbarheight);
        lbl5.backgroundColor=[UIColor clearColor];
        lbl5.textColor=[UIColor blackColor];
        lbl5.userInteractionEnabled=NO;
        lbl5.text= @"Add a card";
        lbl5.font=[lbl5.font fontWithSize:12];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Add a card"];
        [attributeString addAttribute:NSUnderlineStyleAttributeName
                                value:[NSNumber numberWithInt:1]
                                range:(NSRange){0,[attributeString length]}];
        
        lbl5.attributedText = [attributeString copy];
        [self.view addSubview:lbl5];
        
        UILabel *lbl6 = [[UILabel alloc]init];
        lbl6.textColor = [UIColor blackColor];
        lbl6.frame = CGRectMake((float)20/320 * screenWidth, screenHeight - (screenHeight*.35 + (float)50/568 * screenHeight + statusbarheight) + (float)75/568 * screenHeight, screenWidth, screenHeight * .25 + (float)50/568 * screenHeight + statusbarheight);
        lbl6.backgroundColor=[UIColor clearColor];
        lbl6.textColor=[UIColor blackColor];
        lbl6.userInteractionEnabled=NO;
        lbl6.text= @"Addition profile detail would go here";
        lbl6.font=[lbl6.font fontWithSize:12];
        [self.view addSubview:lbl6];
        
        UILabel *lbl7 = [[UILabel alloc]init];
        lbl7.textColor = [UIColor blackColor];
        lbl7.frame = CGRectMake((float)20/320 * screenWidth, screenHeight - (screenHeight*.35 + (float)50/568 * screenHeight + statusbarheight) + (float)95/568 * screenHeight, screenWidth, screenHeight * .25 + (float)50/568 * screenHeight + statusbarheight);
        lbl7.backgroundColor=[UIColor clearColor];
        lbl7.textColor=[UIColor blackColor];
        lbl7.userInteractionEnabled=NO;
        lbl7.text= @"And Here";
        lbl7.font=[lbl7.font fontWithSize:12];
        [self.view addSubview:lbl7];
        
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
            mapView_.frame = CGRectMake(0, statusbarheight + 50/568 * screenHeight, screenRect.size.width, 0);
        }completion:^(BOOL finished) {mapView_.frame = CGRectMake(0, 0, 0, 0);}];
    }
    else
    {
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
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
