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
             }         }
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
             NSLog( @"%@", dictionary);
         }
     }];
}
@end
