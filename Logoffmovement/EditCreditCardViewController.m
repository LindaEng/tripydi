//
//  FirstViewController.m
//  Logoff
//
//  Created by Ben Wang on 7/6/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//

#import "EditCreditCardViewController.h"

@import GoogleMaps;

@interface EditCreditCardViewController ()

@end
@implementation EditCreditCardViewController{
    }


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *clientTokenURL = [NSURL URLWithString:@"https://salesperch.azurewebsites.net/Payment/GetClientTokenIOS"];
    NSMutableURLRequest *clientTokenRequest = [NSMutableURLRequest requestWithURL:clientTokenURL];
    [clientTokenRequest setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
    
    [NSURLConnection
     sendAsynchronousRequest:clientTokenRequest
     queue:[NSOperationQueue mainQueue]
     completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
         // TODO: Handle errors in [(NSHTTPURLResponse *)response statusCode] and connectionError
         NSString *clientToken = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(clientToken);
         // Initialize `Braintree` once per checkout session
         self.braintree = [Braintree braintreeWithClientToken:clientToken];
         
         // As an example, you may wish to present our Drop-In UI at this point.
         // Continue to the next section to learn more...
         BTDropInViewController *dropInViewController = [self.braintree dropInViewControllerWithDelegate:self];
         // This is where you might want to customize your Drop in. (See below.)
         
         // The way you present your BTDropInViewController instance is up to you.
         // In this example, we wrap it in a new, modally presented navigation controller:
         dropInViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                                               target:self
                                                                                                               action:@selector(userDidCancelPayment)];
         
         UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dropInViewController];
         [self presentViewController:navigationController animated:YES completion:nil];

     }];
}

- (void)userDidCancelPayment {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dropInViewController:(__unused BTDropInViewController *)viewController didSucceedWithPaymentMethod:(BTPaymentMethod *)paymentMethod {
    [self postNonceToServer:paymentMethod.nonce]; // Send payment method nonce to your server
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dropInViewControllerDidCancel:(__unused BTDropInViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)postNonceToServer:(NSString *)paymentMethodNonce {
    // Update URL with your server
    NSURL *paymentURL = [NSURL URLWithString:@"https://salesperch.azurewebsites.net/Payment/CreateTransaction"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:paymentURL];
    NSString* bodyData = [NSString stringWithFormat:@"nonce=%@&price=1.99", paymentMethodNonce];
    NSData* data = [bodyData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if(connectionError != nil){
                                   NSLog(@"error ");
                                   NSLog(@"%@",[connectionError localizedDescription]);
                               }
                               else if (data.length > 0)
                               {
                                   NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                              options:0
                                                                                                error:NULL];
                                   for (id key in dictionary) {
                                       NSLog(@"key: %@, value: %@ \n", key, [dictionary objectForKey:key]);
                                   }
                               }
                               else{
                                   NSLog(@"failed no data");
                               }
                               
                           }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
