//
//  Httpgetpost.h
//  OpenSeatr
//
//  Created by Ben Wang on 8/7/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//
#import <UIKit/UIKit.h>
@import GoogleMaps;

@interface Httpgetpost : NSObject

+ (void) showborder:(UIView *)view;
- (void) httpget:(NSString *)url;
-(void) httppost:(NSString*)postcontent urlstr:(NSString*) url;
-(void) dropmarkers:(NSString*) url mapview:(GMSMapView*) mapView;

@end
