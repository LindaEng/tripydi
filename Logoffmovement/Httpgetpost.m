//
//  MyCustomSegue.m
//  NookHub
//
//  Created by Ben Wang on 7/28/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Httpgetpost.h"


@implementation Httpgetpost

+ (void) showborder:(UIView *)view
{
    view.layer.borderColor = [UIColor blackColor].CGColor;
    view.layer.borderWidth = 2.0f;
}
-(void) httppost:(NSString*)postcontent urlstr:(NSString*) url
{
    NSString *post = postcontent;
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:0
                                                                          error:NULL];
             for (id key in dictionary) {
                 NSLog(@"key: %@, value: %@ \n", key, [dictionary objectForKey:key]);
             }
         }
     }];
}

-(void) httpget:(NSString*) url
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:0
                                                                          error:NULL];
             for(id item in dictionary )
             {
                 NSDictionary *dic = (NSDictionary *)item;
                 //NSLog( @"%@", dic);
                 NSLog(@"%@",[dic objectForKey:@"latitude"]);
                 NSLog(@"%@",[dic objectForKey:@"longitude"]);
                 
             }
             //NSLog( @"%@", dictionary);
         }
     }];
}
-(void) dropmarkers:(NSString*) url mapview:(GMSMapView*) mapView
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:0
                                                                          error:NULL];
             for(id item in dictionary ){
                 NSDictionary *dic = (NSDictionary *)item;
                 GMSMarker *marker = [[GMSMarker alloc] init];
                 marker.position = CLLocationCoordinate2DMake([[dic objectForKey:@"latitude"] doubleValue], [[dic objectForKey:@"longitude"] doubleValue]);
                 marker.appearAnimation = kGMSMarkerAnimationPop;
                 marker.userData = item;
                 marker.zIndex = 1;
                 marker.icon = [self image:[UIImage imageNamed:@"MapMarker_Ball_Right_blue"] scaledToSize:CGSizeMake(60.0f, 60.0f)];
                 marker.groundAnchor = CGPointMake(.3, 1);
                 marker.map = mapView;
                 
             }
         }
     }];
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
@end
