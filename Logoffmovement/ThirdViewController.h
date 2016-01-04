//
//  FirstViewController.h
//  Logoff
//
//  Created by Ben Wang on 7/6/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
@import GoogleMaps;

@interface ThirdViewController : UIViewController<CLLocationManagerDelegate, UIWebViewDelegate, GMSMapViewDelegate>

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

