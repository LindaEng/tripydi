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
#import "SignalR.h"
#import "TTTAttributedLabel.h"
#import "DropDownListView.h"
#import "iCarousel.h"

@import GoogleMaps;

@interface HomeViewController : UIViewController<CLLocationManagerDelegate, UIWebViewDelegate, UIGestureRecognizerDelegate, TTTAttributedLabelDelegate, UIScrollViewDelegate, GMSMapViewDelegate, SRConnectionDelegate, kDropDownListViewDelegate, iCarouselDataSource, iCarouselDelegate, UIActionSheetDelegate>
{
    NSArray *arryList;
    DropDownListView * Dropobj;
}

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, strong) UINavigationItem *navItem;
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) NSMutableArray *items;

@end

