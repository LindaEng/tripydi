//
//  FirstViewController.m
//  Logoff
//
//  Created by Ben Wang on 7/6/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//

#import "HomeViewController.h"
#import "SignalR.h"
#import "Httpgetpost.h"
#import "CustomTabBar.h"
#import "MyCustomSegue.h"

@import GoogleMaps;

@interface HomeViewController ()

@end
@implementation HomeViewController{
    GMSMapView *mapView_;
    CGRect screenRect;
    CGFloat statusbarheight;
    UITableView* tableView;
    NSMutableArray* yourItemsArray;
    int ticketcounter;
    UILabel *lblcounter;
    CGFloat screenWidth;
    CGFloat screenHeight;
    SRHubProxy *chat;
    bool didaddmap;
    Httpgetpost* usefullib;
    
    NSDictionary *dic;
    
    UILabel *mlbl1;
    UILabel *mlbl2;
    UILabel *mlbl3;
    UILabel *mlbl4;
    UILabel *mlbl5;
    UILabel *mlbl6;
    
    UILabel *lbl1;
    UILabel *lbl2;
    UILabel *lbl3;
    UILabel *lbl4;
    UILabel *lbl5;
    UILabel *lbl6;
    UILabel *lbl7;
    UILabel *lbl8;
    UILabel *lbl9;
    UILabel *lbl10;
    UILabel *lbl11;
    UILabel *lbl12;
    UILabel *lbl13;
    UILabel *lbl14;
    UILabel *lbl15;
    UILabel *lbl16;
    
    UILabel *lbltotalprice;
    
    UILabel *lb1;
    UILabel *lb2;
    UILabel *lb3;
    UILabel *lb4;
    UILabel *lb5;
    UILabel *lb6;
    UILabel *lb7;
    UILabel *lb8;
    UILabel *lb9;
    UILabel *lb10;
    UILabel *lb11;
    UILabel *lb12;
    UILabel *lb13;
    UILabel *lb14;
    UILabel *lb15;
    UILabel *lb16;
    UILabel *lb17;
    UILabel *lb18;
    
    UILabel *lblSelectedCountryNames;
    
    TTTAttributedLabel *TTTlbl1;
    TTTAttributedLabel *TTTlbl2;
    TTTAttributedLabel *TTTlbl3;
    TTTAttributedLabel *TTTlbl4;
    
    
    UITextView *txtv1;
    UITextView *txtv2;
    UITextView *txtv3;
    UITextView *txtv4;
    
    UIImageView *GoButton;
    
    UIImageView *img1;
    UIImageView *img2;
    UIImageView *img3;
    UIImageView *img4;
    UIImageView *img5;
    UIImageView *img6;
    UIImageView *img7;
    UIImageView *img8;
    UIImageView *img9;
    UIImageView *img10;
    
    UIWebView *webviewyelp;
    
    UIScrollView* scrollview1;
    
    UIView *box;
    UIView *box1;
    UIView *box2;
    UIView *box3;
    UIView *box4;
    
    CLLocationCoordinate2D locationclick1;
    
    int categoryselected;
    int subcategoryselected1;
    int screenid;
    int swipecounter;
    
    UIImage *image1;
    UIImage *image2;
    UIImage *image3;
    GMSMarker* currentmarker;
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if(index == 0)
    {
        return [self CreateMoreInfo];
    }
    else if(index == 1)
    {
        return [self CreateUserTappedImg1];
    }
    else if(index == 2)
    {
        return [self CreateYelpView:[dic objectForKey:@"yelpurl"]];
    }
    else if(index == 3)
    {
        return [self CreateStaticMap];
    }
    else{
        return nil;
    }
    /*
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //view = [self CreateMoreInfo];
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [_items[index] stringValue];
    
    return view;*/
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return _wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_items count];
}
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self customInit];
    }
    return self;
}
- (void) customInit
{
    _wrap = YES;
    self.items = [NSMutableArray array];
    for (int i = 0; i < 4; i++)
    {
        [self.items addObject:@(i)];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    ticketcounter = 1;
    screenRect = [[UIScreen mainScreen] bounds];
    
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    statusbarheight = 20;
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager startUpdatingLocation];
    didaddmap = false;

    [self createToolBar];
    [self createSignalR];
    [self allocProperties];
    [self createhomeview];
}
-(void) createCarousel
{
    //create carousel
    _carousel = [[iCarousel alloc] initWithFrame:CGRectMake((float)0/320 * screenWidth, (float)0/568 * screenHeight, (float)320/320 * screenWidth, (float)380/568 * screenHeight)];
    _carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _carousel.type = iCarouselTypeCoverFlow2;
    _carousel.delegate = self;
    _carousel.dataSource = self;
    
    //add carousel to view
    [self.view addSubview:_carousel];
}
-(void) createhomeview
{
    box.frame = CGRectMake((float)0/320 * screenWidth, (float)379/568 * screenHeight, (float)320/320 * screenWidth, (float)10/568 * screenHeight);
    [self.view addSubview:box];
    CALayer *topBorder2 = [CALayer layer];
    topBorder2.frame = CGRectMake(0.0f, 1, box.frame.size.width, 2.0f);
    topBorder2.backgroundColor = [UIColor grayColor].CGColor;
    [box.layer addSublayer:topBorder2];
    
    lbl1.textColor = [UIColor blackColor];
    lbl1.frame = CGRectMake((float)0/320 * screenWidth, (float)420/568 * screenHeight, (float)320/320 * screenWidth, (float)22/568 * screenHeight);
    lbl1.backgroundColor=[UIColor clearColor];
    lbl1.textColor=[UIColor blackColor];
    lbl1.userInteractionEnabled=NO;
    lbl1.font=[lbl1.font fontWithSize:15];
    lbl1.text= @"Hi Jennifer!";
    lbl1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl1];
    
    lbl2.textColor = [UIColor blackColor];
    lbl2.frame = CGRectMake((float)0/320 * screenWidth, (float)440/568 * screenHeight, (float)320/320 * screenWidth, (float)22/568 * screenHeight);
    lbl2.backgroundColor=[UIColor clearColor];
    lbl2.textColor=[UIColor blackColor];
    lbl2.userInteractionEnabled=NO;
    lbl2.text= @"How many people in your group?";
    lbl2.font=[lbl2.font fontWithSize:15];
    lbl2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl2];
    
    lbl3.textColor = [UIColor blackColor];
    lbl3.frame = CGRectMake((float)114/320 * screenWidth, (float)465/568 * screenHeight, (float)40/320 * screenWidth, (float)40/568 * screenHeight);
    lbl3.backgroundColor=[UIColor clearColor];
    lbl3.textColor=[UIColor blackColor];
    lbl3.userInteractionEnabled=YES;
    lbl3.text= @"-";
    lbl3.font=[lbl3.font fontWithSize:15];
    [lbl3 setFont:[UIFont boldSystemFontOfSize:36]];
    lbl3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl3];
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnMinus:)];
    // if labelView is not set userInteractionEnabled, you must do so
    [lbl3 setUserInteractionEnabled:YES];
    [lbl3 addGestureRecognizer:gesture];
    
    NSString* ticketcountstring = [@(ticketcounter) stringValue];
    lblcounter = [[UILabel alloc]init];
    lblcounter.textColor = [UIColor blackColor];
    lblcounter.frame = CGRectMake((float)150/320 * screenWidth, (float)473/568 * screenHeight, (float)20/320 * screenWidth, (float)27/568 * screenHeight);
    lblcounter.backgroundColor=[UIColor clearColor];
    lblcounter.textColor=[UIColor blackColor];
    lblcounter.userInteractionEnabled=NO;
    lblcounter.text= ticketcountstring;
    lblcounter.font=[lblcounter.font fontWithSize:15];
    lblcounter.textAlignment = NSTextAlignmentCenter;
    [lblcounter setFont:[UIFont boldSystemFontOfSize:26]];
    [self.view addSubview:lblcounter];
    
    lbl4.textColor = [UIColor blackColor];
    lbl4.frame = CGRectMake((float)173/320 * screenWidth, (float)465/568 * screenHeight, (float)30/320 * screenWidth, (float)40/568 * screenHeight);
    lbl4.backgroundColor=[UIColor clearColor];
    lbl4.textColor=[UIColor blackColor];
    lbl4.userInteractionEnabled=YES;
    lbl4.text= @"+";
    lbl4.font=[lbl4.font fontWithSize:15];
    lbl4.textAlignment = NSTextAlignmentCenter;
    [lbl4 setFont:[UIFont boldSystemFontOfSize:36]];
    [self.view addSubview:lbl4];
    UITapGestureRecognizer* gesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnPlus:)];
    // if labelView is not set userInteractionEnabled, you must do so
    [lbl4 setUserInteractionEnabled:YES];
    [lbl4 addGestureRecognizer:gesture2];
    
    mapView_.frame = CGRectMake((float)0/320 * screenWidth, (float)0/568 * screenHeight, (float)320/320 * screenWidth, (float)380/568 * screenHeight);
    mapView_.userInteractionEnabled = YES;
    [self.view addSubview:mapView_];

}
-(void) createmenuview
{
    box4.frame = CGRectMake((float)0/320 * screenWidth, (float)20/568 * screenHeight, (float)320/320 * screenWidth, (float)60/568 * screenHeight);
    box4.backgroundColor = [UIColor grayColor];
    [self.view addSubview:box4];
    
    lbl16.frame = CGRectMake((float)0/320 * screenWidth, (float)35/568 * screenHeight, (float)320/320 * screenWidth, (float)35/568 * screenHeight);
    lbl16.text = @"Your Account";
    lbl16.font = [lbl16.font fontWithSize:28];
    lbl16.textAlignment = NSTextAlignmentCenter;
    lbl16.textColor = [UIColor whiteColor];
    [self.view addSubview:lbl16];
    
    mlbl1.frame = CGRectMake((float)0/320 * screenWidth, (float)183/568 * screenHeight, (float)320/320 * screenWidth, (float)28/568 * screenHeight);
    mlbl1.text = @"PROFILE";
    [mlbl1 setFont:[UIFont boldSystemFontOfSize:26]];
    mlbl1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:mlbl1];
    UITapGestureRecognizer* gestureprofile = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnProfile:)];
    [mlbl1 setUserInteractionEnabled:YES];
    [mlbl1 addGestureRecognizer:gestureprofile];
    
    mlbl2.frame = CGRectMake((float)0/320 * screenWidth, (float)220/568 * screenHeight, (float)320/320 * screenWidth, (float)28/568 * screenHeight);
    mlbl2.text = @"HISTORY";
    [mlbl2 setFont:[UIFont boldSystemFontOfSize:26]];
    mlbl2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:mlbl2];
    UITapGestureRecognizer* gesturehistory = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnHistory:)];
    [mlbl2 setUserInteractionEnabled:YES];
    [mlbl2 addGestureRecognizer:gesturehistory];
    
    mlbl3.frame = CGRectMake((float)0/320 * screenWidth, (float)253/568 * screenHeight, (float)320/320 * screenWidth, (float)37/568 * screenHeight);
    mlbl3.text = @"PAYMENTS";
    [mlbl3 setFont:[UIFont boldSystemFontOfSize:26]];
    mlbl3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:mlbl3];
    UITapGestureRecognizer* gesturepayments = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnPayments:)];
    [mlbl3 setUserInteractionEnabled:YES];
    [mlbl3 addGestureRecognizer:gesturepayments];
    
    mlbl4.frame = CGRectMake((float)0/320 * screenWidth, (float)296/568 * screenHeight, (float)320/320 * screenWidth, (float)28/568 * screenHeight);
    mlbl4.text = @"SHARE";
    [mlbl4 setFont:[UIFont boldSystemFontOfSize:26]];
    mlbl4.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:mlbl4];
    UITapGestureRecognizer* gestureshare = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnShare:)];
    [mlbl4 setUserInteractionEnabled:YES];
    [mlbl4 addGestureRecognizer:gestureshare];
    
    mlbl5.frame = CGRectMake((float)0/320 * screenWidth, (float)330/568 * screenHeight, (float)320/320 * screenWidth, (float)38/568 * screenHeight);
    mlbl5.text = @"HELP";
    [mlbl5 setFont:[UIFont boldSystemFontOfSize:26]];
    mlbl5.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:mlbl5];
    UITapGestureRecognizer* gesturehelp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnHelp:)];
    [mlbl5 setUserInteractionEnabled:YES];
    [mlbl5 addGestureRecognizer:gesturehelp];
    
    mlbl6.frame = CGRectMake((float)0/320 * screenWidth, (float)377/568 * screenHeight, (float)320/320 * screenWidth, (float)25/568 * screenHeight);
    mlbl6.text = @"ABOUT";
    [mlbl6 setFont:[UIFont boldSystemFontOfSize:26]];
    mlbl6.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:mlbl6];
    UITapGestureRecognizer* gestureabout = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnAbout:)];
    [mlbl6 setUserInteractionEnabled:YES];
    [mlbl6 addGestureRecognizer:gestureabout];

}
-(void) clearallsubview
{
    [[self.view subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
}
-(void) allocProperties
{
    webviewyelp = [[UIWebView alloc]init];
    lblcounter = [[UILabel alloc]init];
    usefullib = [[Httpgetpost alloc]init];
    
    TTTlbl1 = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
    TTTlbl2 = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
    TTTlbl3 = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
    TTTlbl4 = [[TTTAttributedLabel alloc]initWithFrame:CGRectZero];
    
    lblSelectedCountryNames = [[UILabel alloc]init];
    mlbl1 = [[UILabel alloc]init];
    mlbl2 = [[UILabel alloc]init];
    mlbl3 = [[UILabel alloc]init];
    mlbl4 = [[UILabel alloc]init];
    mlbl5 = [[UILabel alloc]init];
    mlbl6 = [[UILabel alloc]init];

    lbltotalprice = [[UILabel alloc]init];
    
    lbl1 = [[UILabel alloc]init];
    lbl2 = [[UILabel alloc]init];
    lbl3 = [[UILabel alloc]init];
    lbl4 = [[UILabel alloc]init];
    lbl5 = [[UILabel alloc]init];
    lbl6 = [[UILabel alloc]init];
    lbl7 = [[UILabel alloc]init];
    lbl8 = [[UILabel alloc]init];
    lbl9 = [[UILabel alloc]init];
    lbl10 = [[UILabel alloc]init];
    lbl11 = [[UILabel alloc]init];
    lbl12 = [[UILabel alloc]init];
    lbl13 = [[UILabel alloc]init];
    lbl14 = [[UILabel alloc]init];
    lbl15 = [[UILabel alloc]init];
    lbl16 = [[UILabel alloc]init];
    img1 = [[UIImageView alloc]init];
    img2 = [[UIImageView alloc]init];
    img3 = [[UIImageView alloc]init];
    img4 = [[UIImageView alloc]init];
    img5 = [[UIImageView alloc]init];
    img6 = [[UIImageView alloc]init];
    img7 = [[UIImageView alloc]init];
    img8 = [[UIImageView alloc]init];
    img9 = [[UIImageView alloc]init];
    img10 = [[UIImageView alloc]init];
    
    box = [[UIView alloc]init];
    box1 = [[UIView alloc]init];
    box2 = [[UIView alloc]init];
    box3 = [[UIView alloc]init];
    box4 = [[UIView alloc]init];
    
    lb1 = [[UILabel alloc]init];
    lb2 = [[UILabel alloc]init];
    lb3 = [[UILabel alloc]init];
    lb4 = [[UILabel alloc]init];
    lb5 = [[UILabel alloc]init];
    lb6 = [[UILabel alloc]init];
    lb7 = [[UILabel alloc]init];
    lb8 = [[UILabel alloc]init];
    lb9 = [[UILabel alloc]init];
    lb10 = [[UILabel alloc]init];
    lb11 = [[UILabel alloc]init];
    lb12 = [[UILabel alloc]init];
    lb13 = [[UILabel alloc]init];
    lb14 = [[UILabel alloc]init];
    lb15 = [[UILabel alloc]init];
    lb16 = [[UILabel alloc]init];
    lb17 = [[UILabel alloc]init];
    lb18 = [[UILabel alloc]init];
    
    txtv1 = [[UITextView alloc]init];
    txtv2 = [[UITextView alloc]init];
    txtv3 = [[UITextView alloc]init];
    txtv4 = [[UITextView alloc]init];
    
    scrollview1 = [[UIScrollView alloc]init];
    image1 = [[UIImage alloc]init];
    image2 = [[UIImage alloc]init];
    image3 = [[UIImage alloc]init];
}
-(void) createSignalR
{
    SRHubConnection *hubConnection = [SRHubConnection connectionWithURL:@"https://yinit.azurewebsites.net/"];
    // Create a proxy to the chat service
    chat = [hubConnection createHubProxy:@"ChatHub"];
    [chat on:@"addMessage" perform:self selector:@selector(addMessage:)];
    // Start the connection
    [hubConnection start];
    hubConnection.delegate = self;
}
-(void) createToolBar
{
    UIImage *shareBtnIcon = [UIImage imageNamed:@"home_grey_36x30"];
    UIImage *menuIcon = [UIImage imageNamed:@"menu-alt-512_36x30"];
    
    UIBarButtonItem *shareBarBtn = [[UIBarButtonItem alloc] initWithImage:shareBtnIcon style:UIBarButtonItemStylePlain target:self action:@selector(HomeButtonClicked:)];
    
    UIBarButtonItem *menuBarBtn = [[UIBarButtonItem alloc] initWithImage:menuIcon style:UIBarButtonItemStylePlain target:self action:@selector(MenuButtonClicked:)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, self.view.frame.size.height - 30, self.view.frame.size.width, 30);
    [toolbar setItems:[NSArray arrayWithObjects:flexibleSpace, shareBarBtn, flexibleSpace, menuBarBtn, nil]];
    [self.view addSubview:toolbar];

}
-(void) HomeButtonClicked:(UIButton*)sender
{
    NSLog(@"toolbar tapped");
    [self clearallsubview];
    [self createToolBar];
    [self createhomeview];
    [mapView_ clear];
    [self initGMaps];
}
-(void) MenuButtonClicked:(UIButton*)sender
{
    NSLog(@"menu tapped");
    [self clearallsubview];
    [self createToolBar];
    [self createmenuview];
}

-(void)SRConnectionDidOpen:(SRHubConnection*)connection{
    
    NSString *jsonRegister = @"Ben Wang";
    NSString *jsonRegister1 = @"Hi man";

    NSMutableArray *registerInfo = [[NSMutableArray alloc] init];
    [registerInfo addObject:jsonRegister];
    [registerInfo addObject:jsonRegister1];
    
    //[chat invoke:@"Send" withArgs:registerInfo completionHandler:^(id response){
      //  NSLog(@"%@", response);
    //}];
}
- (void)addMessage:(NSString *)message {
    // Print the message when it comes in
    NSLog(message);
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self.locationManager stopUpdatingLocation];
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil && !didaddmap) {
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.locationManager.location.coordinate.latitude longitude:self.locationManager.location.coordinate.longitude zoom:14];
        mapView_ = [GMSMapView mapWithFrame:CGRectMake((float)0/320 * screenWidth, (float)0/568 * screenHeight, (float)320/320 * screenWidth, (float)380/568 * screenHeight) camera:camera];
        
        mapView_.myLocationEnabled = NO;
        mapView_.delegate = self;
        
        [self.view addSubview:mapView_];
        didaddmap = true;
        
        // Creates a marker in the center of the map.
        [self initGMaps];
    }
}
-(void) initGMaps
{
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude);
    //marker.icon = [UIImage imageNamed:@"MapMarker_Ball_Red"];
    marker.icon = [self image:[UIImage imageNamed:@"MapMarker_Star"] scaledToSize:CGSizeMake(100.0f, 100.0f)];
    marker.groundAnchor = CGPointMake(.3, 1);
    marker.map = mapView_;
    
    NSString *lat = [NSString stringWithFormat: @"%f", self.locationManager.location.coordinate.latitude];
    NSString *longi = [NSString stringWithFormat: @"%f", self.locationManager.location.coordinate.longitude];
    NSString *address = [NSString stringWithFormat: @"https://yinit.azurewebsites.net/api/API/VentureMap?lat=%@&longi=%@", lat, longi];
    NSLog(@"%@", address);
    
    [usefullib dropmarkers:address mapview:mapView_];
}
-(void)tapDetected{
    NSLog(@"single Tap on imageview");
    
}
- (void)userTappedOnMinus:(UIGestureRecognizer*)gestureRecognizer
{
    NSString *needle = [lbltotalprice.text componentsSeparatedByString:@"$"][1];
    double baseprice = [needle doubleValue];
    baseprice = baseprice / ticketcounter;
    
    if(ticketcounter > 1)
        ticketcounter--;
    NSString* ticketcountstring = [@(ticketcounter) stringValue];
    lblcounter.text = ticketcountstring;
    
    lbltotalprice.text = [NSString stringWithFormat:@"$%.2f",ticketcounter*baseprice];
    if(ticketcounter < 10)
        [lblcounter setFont:[UIFont boldSystemFontOfSize:26]];
}
- (void)userTappedOnPlus:(UIGestureRecognizer*)gestureRecognizer
{
    NSString *needle = [lbltotalprice.text componentsSeparatedByString:@"$"][1];
    double baseprice = [needle doubleValue];
    baseprice = baseprice / ticketcounter;
    
    ticketcounter++;
    NSString* ticketcountstring = [@(ticketcounter) stringValue];
    lblcounter.text = ticketcountstring;
    
    lbltotalprice.text = [NSString stringWithFormat:@"$%.2f",ticketcounter*baseprice];

    if(ticketcounter > 9)
        [lblcounter setFont:[UIFont boldSystemFontOfSize:17]];
}
- (void)userTappedOnProfile:(UIGestureRecognizer*)gestureRecognizer
{
    NSLog(@"profile");
    arryList=@[@"Jennifer Doe",@"212-555-1766", @"jenniferdoe@gmail.com"];
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"Profile" withOption:arryList xy:CGPointMake(16, 158) size:CGSizeMake(287, 330) isMultiple:NO];
}
- (void)userTappedOnHistory:(UIGestureRecognizer*)gestureRecognizer
{
    NSLog(@"history");
    arryList=@[@"(last 5 purchases)",@"A Midsummers Night Dream - (2) - 8/3/15",@"Forza Bruta - (4) - 7/29/15", @"Chelsea Wine Tasting - (3) - 6/16/15", @"Learn To Rhumba - (2) - 6/3/15", @"Manhattan Helicopter Tour - (4) - 5/31/15", @"(more)"];
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"History" withOption:arryList xy:CGPointMake(16, 158) size:CGSizeMake(287, 330) isMultiple:NO];
}
- (void)userTappedOnPayments:(UIGestureRecognizer*)gestureRecognizer
{
    NSLog(@"payments");
    arryList=@[@"**** **** **** 4144 Visa",@"**** **** **** 4133 Mastercard",@"**** **** **** 4231 AMEX"];
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"Payments" withOption:arryList xy:CGPointMake(16, 158) size:CGSizeMake(287, 330) isMultiple:NO];
}
- (void)userTappedOnShare:(UIGestureRecognizer*)gestureRecognizer
{
    NSLog(@"share");
    arryList=@[@"Facebook",@"Twitter",@"Instagram"];
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"Share" withOption:arryList xy:CGPointMake(16, 158) size:CGSizeMake(287, 330) isMultiple:NO];
}
- (void)userTappedOnHelp:(UIGestureRecognizer*)gestureRecognizer
{
    NSLog(@"help");
    arryList=@[@"benwang.co"];
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"Help" withOption:arryList xy:CGPointMake(16, 158) size:CGSizeMake(287, 330) isMultiple:NO];
}
- (void)userTappedOnAbout:(UIGestureRecognizer*)gestureRecognizer
{
    NSLog(@"about");
    arryList=@[@"Elsa",@"Jim",@"Ben"];
    [Dropobj fadeOut];
    [self showPopUpWithTitle:@"About" withOption:arryList xy:CGPointMake(16, 158) size:CGSizeMake(287, 330) isMultiple:NO];
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
- (void)attributedLabel:(__unused TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    [self userTappedOnMoreInfo:[UIGestureRecognizer alloc]];
    //[[[UIActionSheet alloc] initWithTitle:[url absoluteString] delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Open Link in Safari", nil), nil] showInView:self.view];
}
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    if(currentmarker)
        currentmarker.icon = [self image:[UIImage imageNamed:@"MapMarker_Ball_Right_blue"] scaledToSize:CGSizeMake(60.0f, 60.0f)];
    currentmarker = marker;
    dic = (NSDictionary *)marker.userData;
    NSLog( @"%@", dic);
    
    NSURL *url1 = [NSURL URLWithString:[dic objectForKey:@"pic1"]];
    NSData *imageData = [NSData dataWithContentsOfURL:url1];
    image1 = [UIImage imageWithData:imageData];
    
    url1 = [NSURL URLWithString:[dic objectForKey:@"pic2"]];
    imageData = [NSData dataWithContentsOfURL:url1];
    image2 = [UIImage imageWithData:imageData];
    
    url1 = [NSURL URLWithString:[dic objectForKey:@"pic3"]];
    imageData = [NSData dataWithContentsOfURL:url1];
    image3 = [UIImage imageWithData:imageData];
    
    marker.icon = [self image:[UIImage imageNamed:@"MapMarker_Ball_Right_blue_glow"] scaledToSize:CGSizeMake(80.0f, 80.0f)];
    marker.groundAnchor = CGPointMake(.3, 1);
    marker.map = mapView;
    locationclick1 = marker.position;
    
    [lbl1 removeFromSuperview];
    [lbl2 removeFromSuperview];
    [lbl3 removeFromSuperview];
    [lbl4 removeFromSuperview];
    [lbl5 removeFromSuperview];
    [lbl6 removeFromSuperview];
    [lbl7 removeFromSuperview];
    [lbl8 removeFromSuperview];
    [lbl9 removeFromSuperview];
    [lbl10 removeFromSuperview];
    [lbl11 removeFromSuperview];
    [lbl12 removeFromSuperview];
    [lbl13 removeFromSuperview];
    [lbl14 removeFromSuperview];
    [lbl15 removeFromSuperview];
    [lbl16 removeFromSuperview];
    [lblcounter removeFromSuperview];
    [GoButton removeFromSuperview];
    
    NSMutableString *titlestring = [NSMutableString stringWithString:[dic objectForKey:@"title"]];
    [titlestring appendString:@" (more)"];
    
    TTTlbl1.text= titlestring;
    [TTTlbl1 setFont:[UIFont boldSystemFontOfSize:15]];
    TTTlbl1.frame = CGRectMake((float)0/320 * screenWidth, (float)380/568 * screenHeight, (float)320/320 * screenWidth, (float)20/568 * screenHeight);
    TTTlbl1.textAlignment = NSTextAlignmentCenter;
    NSRange linkRange = NSMakeRange([TTTlbl1.text length] - 6, 6);
    
    [TTTlbl1 setText:TTTlbl1.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [mutableAttributedString addAttribute:(NSString *)kCTUnderlineStyleAttributeName value:[NSNumber numberWithInt:1] range:(NSRange){[mutableAttributedString length] - 6, 6}];
        return mutableAttributedString;
    }];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://en.wikipedia.org/wiki/%@", [TTTlbl1.text substringWithRange:linkRange]]];
    [TTTlbl1 addLinkToURL:url withRange:linkRange];
    TTTlbl1.delegate = self;
    [self.view addSubview:TTTlbl1];
    
    NSString* mustarrive = [NSString stringWithFormat:@"9:00 pm, must arrive by %@", [dic objectForKey:@"mustarrive"]];
    
    lbl5.text= mustarrive;
    lbl5.font=[lbl5.font fontWithSize:13];
    lbl5.textAlignment = NSTextAlignmentLeft;
    lbl5.frame = CGRectMake((float)0/320 * screenWidth, (float)400/568 * screenHeight, (float)320/320 * screenWidth, (float)15/568 * screenHeight);
    lbl5.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl5];
    
    lbl6.text= @"Original cost $45 each, now $25 each";
    lbl6.font=[lbl6.font fontWithSize:13];
    lbl6.textAlignment = NSTextAlignmentLeft;
    lbl6.frame = CGRectMake((float)0/320 * screenWidth, (float)415/568 * screenHeight, (float)320/320 * screenWidth, (float)15/568 * screenHeight);
    lbl6.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl6];

    box1.frame = CGRectMake((float)0/320 * screenWidth, (float)440/568 * screenHeight, (float)320/320 * screenWidth, (float)40/568 * screenHeight);
    [self.view addSubview:box1];
    
    CALayer *bottomBorder2 = [CALayer layer];
    bottomBorder2.frame = CGRectMake(0.0f, box1.frame.size.height - 1, box1.frame.size.width, 1.0f);
    bottomBorder2.backgroundColor = [UIColor blackColor].CGColor;
    [box1.layer addSublayer:bottomBorder2];
    
    CALayer *topBorder2 = [CALayer layer];
    topBorder2.frame = CGRectMake(0.0f, 1, box1.frame.size.width, 1.0f);
    topBorder2.backgroundColor = [UIColor blackColor].CGColor;
    [box1.layer addSublayer:topBorder2];
    
    lbl10.text= @"Quantity";
    lbl10.font=[lbl10.font fontWithSize:12];
    lbl10.textAlignment = NSTextAlignmentCenter;
    lbl10.frame = CGRectMake((float)18/320 * screenWidth, (float)443/568 * screenHeight, (float)55/320 * screenWidth, (float)13/568 * screenHeight);
    [self.view addSubview:lbl10];
    
    lbl11.text= @"Total";
    lbl11.font=[lbl11.font fontWithSize:12];
    lbl11.textAlignment = NSTextAlignmentCenter;
    lbl11.frame = CGRectMake((float)106/320 * screenWidth, (float)443/568 * screenHeight, (float)40/320 * screenWidth, (float)14/568 * screenHeight);
    [self.view addSubview:lbl11];
    
    NSString* ticketcountstring = [@(ticketcounter) stringValue];
    lblcounter.textColor = [UIColor blackColor];
    lblcounter.frame = CGRectMake((float)35/320 * screenWidth, (float)454/568 * screenHeight, (float)21/320 * screenWidth, (float)22/568 * screenHeight);
    lblcounter.backgroundColor=[UIColor clearColor];
    lblcounter.userInteractionEnabled=NO;
    lblcounter.text= ticketcountstring;
    lblcounter.textAlignment = NSTextAlignmentCenter;
    [lblcounter setFont:[UIFont boldSystemFontOfSize:25]];
    [self.view addSubview:lblcounter];
    
    lbl12.textColor = [UIColor blackColor];
    lbl12.frame = CGRectMake((float)16/320 * screenWidth, (float)454/568 * screenHeight, (float)18/320 * screenWidth, (float)22/568 * screenHeight);
    lbl12.backgroundColor=[UIColor clearColor];
    lbl12.userInteractionEnabled=YES;
    lbl12.text= @"-";
    [lbl12 setFont:[UIFont boldSystemFontOfSize:35]];
    lbl12.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl12];
    UITapGestureRecognizer* gestureminus = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnMinus:)];
    [lbl12 setUserInteractionEnabled:YES];
    [lbl12 addGestureRecognizer:gestureminus];
    
    lbl13.textColor = [UIColor blackColor];
    lbl13.frame = CGRectMake((float)57/320 * screenWidth, (float)452/568 * screenHeight, (float)19/320 * screenWidth, (float)22/568 * screenHeight);
    lbl13.backgroundColor=[UIColor clearColor];
    lbl13.userInteractionEnabled=YES;
    lbl13.text= @"+";
    [lbl13 setFont:[UIFont boldSystemFontOfSize:35]];
    lbl13.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl13];
    lbl13.layer.zPosition = 34;
    UITapGestureRecognizer* gestureplus = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnPlus:)];
    [lbl13 setUserInteractionEnabled:YES];
    [lbl13 addGestureRecognizer:gestureplus];
    
    
    lbltotalprice.textColor = [UIColor blackColor];
    lbltotalprice.frame = CGRectMake((float)102/320 * screenWidth, (float)457/568 * screenHeight, (float)64/320 * screenWidth, (float)21/568 * screenHeight);
    lbltotalprice.backgroundColor=[UIColor clearColor];
    
    NSString *price = [NSString stringWithFormat:@"$%@", [dic objectForKey:@"price"]];
    NSString *needle = [price componentsSeparatedByString:@"$"][1];
    double baseprice = [needle doubleValue];
    
    lbltotalprice.text= [NSString stringWithFormat:@"$%.2f",ticketcounter*baseprice];
    lbltotalprice.font=[lbltotalprice.font fontWithSize:15];
    lbltotalprice.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbltotalprice];
    
    img4.frame = CGRectMake((float)185/320 * screenWidth, (float)442/568 * screenHeight, (float)119/320 * screenWidth, (float)37/568 * screenHeight);
    UIImage *image4 = [UIImage imageNamed: @"button_buy"];
    [img4 setImage:image4];
    img4.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:img4];
    
    UITapGestureRecognizer* gesturebuy= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnBuyNow:)];
    [img4 setUserInteractionEnabled:YES];
    [img4 addGestureRecognizer:gesturebuy];
    
    NSString *seatavaliablestring = [NSString stringWithFormat:@"%@ seats avaliable", [dic objectForKey:@"seatsavaliable"]];
    
    TTTlbl2.text= seatavaliablestring;
    TTTlbl2.font=[TTTlbl2.font fontWithSize:15];
    TTTlbl2.textAlignment = NSTextAlignmentLeft;
    TTTlbl2.frame = CGRectMake((float)0/320 * screenWidth, (float)480/568 * screenHeight, (float)320/320 * screenWidth, (float)20/568 * screenHeight);
    TTTlbl2.textAlignment = NSTextAlignmentCenter;
    
    [TTTlbl2 setText:TTTlbl2.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:15];
        
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);

        [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:(NSRange){0,2}];
        
        return mutableAttributedString;
    }];
    
    [self.view addSubview:TTTlbl2];
    
    lbl15.textColor = [UIColor blackColor];
    lbl15.frame = CGRectMake((float)0/320 * screenWidth, (float)498/568 * screenHeight, (float)320/320 * screenWidth, (float)20/568 * screenHeight);
    lbl15.backgroundColor=[UIColor clearColor];
    NSString* expirationtime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"expirationTime"]];
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];
    NSString* salescloses = [NSString stringWithFormat:@"Sales closes in %@", currentTime];
    lbl15.text= salescloses;
    lbl15.font=[lbl15.font fontWithSize:13];
    lbl15.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl15];
    
    lbl8.text= @"18 others are viewing this now";
    lbl8.font=[lbl8.font fontWithSize:13];
    lbl8.textAlignment = NSTextAlignmentLeft;
    lbl8.frame = CGRectMake((float)0/320 * screenWidth, (float)516/568 * screenHeight, (float)320/320 * screenWidth, (float)22/568 * screenHeight);
    lbl8.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl8];
    
    return YES;
}
-(UIView*) CreateMoreInfo
{
    UIView* viewbox = [[UIView alloc]initWithFrame:CGRectMake((float)10/320 * screenWidth, (float)0/568 * screenHeight, (float)300/320 * screenWidth, (float)380/568 * screenHeight)];
    viewbox.backgroundColor = [UIColor whiteColor];
    
    box2.frame = CGRectMake((float)0/320 * screenWidth, (float)0/568 * screenHeight, (float)320/320 * screenWidth, (float)380/568 * screenHeight);
    [viewbox addSubview:box2];
    
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [box2 addGestureRecognizer:swipeleft];
    
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [box2 addGestureRecognizer:swiperight];
    
    box4.frame = CGRectMake((float)0/320 * screenWidth, (float)20/568 * screenHeight, (float)320/320 * screenWidth, (float)35/568 * screenHeight);
    box4.backgroundColor = [UIColor grayColor];
    [viewbox addSubview:box4];
    
    lbl16.frame = CGRectMake((float)0/320 * screenWidth, (float)20/568 * screenHeight, (float)320/320 * screenWidth, (float)35/568 * screenHeight);
    lbl16.text = @"Scroll to read or Swipe see more choices";
    lbl16.font = [lbl16.font fontWithSize:12];
    lbl16.textAlignment = NSTextAlignmentCenter;
    lbl16.textColor = [UIColor whiteColor];
    [viewbox addSubview:lbl16];
    
    txtv1.textColor = [UIColor blackColor];
    txtv1.frame = CGRectMake((float)14/320 * screenWidth, (float)60/568 * screenHeight, (float)151/320 * screenWidth, (float)54/568 * screenHeight);
    txtv1.userInteractionEnabled=NO;
    txtv1.text= [dic objectForKey:@"title"];
    [txtv1 setFont:[UIFont boldSystemFontOfSize:17]];
    txtv1.textAlignment = NSTextAlignmentLeft;
    [viewbox addSubview:txtv1];
    
    lb3.textColor = [UIColor blackColor];
    lb3.frame = CGRectMake((float)19/320 * screenWidth, (float)116/568 * screenHeight, (float)157/320 * screenWidth, (float)14/568 * screenHeight);
    lb3.userInteractionEnabled=NO;
    NSString* author = [NSString stringWithFormat:@"Play by %@", [dic objectForKey:@"author"]];
    lb3.text= author;
    lb3.font=[lb3.font fontWithSize:10];
    lb3.textAlignment = NSTextAlignmentLeft;
    [viewbox addSubview:lb3];
    
    img6.frame = CGRectMake((float)215/320 * screenWidth, statusbarheight + (float)55/568 * screenHeight, (float)85/320 * screenWidth, (float)85/568 * screenHeight);
    
    NSURL* url1 = [NSURL URLWithString:[dic objectForKey:@"pic4"]];
    NSData *imageData = [NSData dataWithContentsOfURL:url1];
    UIImage *image6 = [UIImage imageWithData:imageData];
    
    [img6 setImage:image6];
    img6.contentMode = UIViewContentModeScaleAspectFit;
    UITapGestureRecognizer* tapimg=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userTappedOnimg1:)];
    [img6 addGestureRecognizer:tapimg];
    img6.userInteractionEnabled=YES;
    [viewbox addSubview:img6];
    
    
    txtv2.textColor = [UIColor blackColor];
    txtv2.frame = CGRectMake((float)14/320 * screenWidth, (float)135/568 * screenHeight, (float)191/320 * screenWidth, (float)60/568 * screenHeight);
    txtv2.userInteractionEnabled=YES;
    txtv2.text= [dic objectForKey:@"description"];
    txtv2.font=[txtv2.font fontWithSize:10];
    txtv2.textAlignment = NSTextAlignmentLeft;
    [txtv2 setShowsVerticalScrollIndicator:NO];
    txtv2.editable = NO;
    [viewbox addSubview:txtv2];
    
    lb4.textColor = [UIColor blackColor];
    lb4.frame = CGRectMake((float)19/320 * screenWidth, (float)195/568 * screenHeight, (float)187/320 * screenWidth, (float)18/568 * screenHeight);
    lb4.userInteractionEnabled=NO;
    lb4.text= @"First Performance: January 1, 1605";
    [lb4 setFont:[UIFont boldSystemFontOfSize:10]];
    lb4.textAlignment = NSTextAlignmentLeft;
    [viewbox addSubview:lb4];
    
    lb6.textColor = [UIColor blackColor];
    lb6.frame = CGRectMake((float)19/320 * screenWidth, (float)230/568 * screenHeight, (float)187/320 * screenWidth, (float)16/568 * screenHeight);
    lb6.userInteractionEnabled=NO;
    NSString* pauthor = [NSString stringWithFormat:@"Playwright: %@", [dic objectForKey:@"author"]];
    lb6.text= pauthor;
    [lb6 setFont:[UIFont boldSystemFontOfSize:10]];
    lb6.textAlignment = NSTextAlignmentLeft;
    [viewbox addSubview:lb6];
    
    lb8.textColor = [UIColor blackColor];
    lb8.frame = CGRectMake((float)19/320 * screenWidth, (float)214/568 * screenHeight, (float)181/320 * screenWidth, (float)15/568 * screenHeight);
    lb8.userInteractionEnabled=NO;
    NSString* lauthor = [NSString stringWithFormat:@"Lyricist: %@", [dic objectForKey:@"author"]];
    lb8.text= lauthor;
    [lb8 setFont:[UIFont boldSystemFontOfSize:10]];
    lb8.textAlignment = NSTextAlignmentLeft;
    [viewbox addSubview:lb8];
    
    lb10.textColor = [UIColor blackColor];
    lb10.frame = CGRectMake((float)19/320 * screenWidth, (float)254/568 * screenHeight, (float)72/320 * screenWidth, (float)16/568 * screenHeight);
    lb10.userInteractionEnabled=NO;
    lb10.text= @"Character List:";
    lb10.font=[lb10.font fontWithSize:10];
    lb10.textAlignment = NSTextAlignmentLeft;
    [viewbox addSubview:lb10];
    
    txtv3.textColor = [UIColor blackColor];
    txtv3.frame = CGRectMake((float)14/320 * screenWidth, (float)275/568 * screenHeight, (float)281/320 * screenWidth, (float)67/568 * screenHeight);
    txtv3.userInteractionEnabled=YES;
    NSString* longdesc = [NSString stringWithFormat:@"%@", [dic objectForKey:@"longdesc"]];
    txtv3.text= longdesc;
    txtv3.font=[txtv3.font fontWithSize:10];
    txtv3.textAlignment = NSTextAlignmentLeft;
    [txtv3 setShowsVerticalScrollIndicator:NO];
    txtv3.editable = NO;
    [viewbox addSubview:txtv3];

    return viewbox;
}
- (void)userTappedOnMoreInfo:(UIGestureRecognizer*)gestureRecognizer
{
    swipecounter = 1;
    [scrollview1 removeFromSuperview];
    [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        mapView_.frame = CGRectMake((float)0/320 * screenWidth, (float)0/568 * screenHeight, (float)0/320 * screenWidth, (float)380/568 * screenHeight);
    }completion:^(BOOL finished) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [mapView_ setFrame:CGRectMake(0, 0, 0, 0)];
        });
        
        UIView* moreinfo = [self CreateMoreInfo];
        [self.view addSubview:moreinfo];
        
        [self createCarousel];
        
    }];
}
- (void)userTappedOnBuyNow:(UIGestureRecognizer*)gestureRecognizer
{
    [UIView animateWithDuration:.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        mapView_.frame = CGRectMake(0, 0, 0, screenRect.size.height * .60f);
    }completion:^(BOOL finished) {
        mapView_.frame = CGRectMake(0, 0, 0, 0);
        [[self.view subviews]makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self createToolBar];
        lb1.frame = CGRectMake((float)0/320 * screenWidth, (float)27/568 * screenHeight, (float)320/320 * screenWidth, (float)42/568 * screenHeight);
        lb2.frame = CGRectMake((float)0/320 * screenWidth, (float)82/568 * screenHeight, (float)320/320 * screenWidth, (float)27/568 * screenHeight);
        img1.frame = CGRectMake((float)67/320 * screenWidth, (float)107/568 * screenHeight, (float)62/320 * screenWidth, (float)52/568 * screenHeight);
        lb3.frame = CGRectMake((float)133/320 * screenWidth, (float)109/568 * screenHeight, (float)187/320 * screenWidth, (float)15/568 * screenHeight);
        lb4.frame = CGRectMake((float)133/320 * screenWidth, (float)126/568 * screenHeight, (float)186/320 * screenWidth, (float)15/568 * screenHeight);
        lb5.frame = CGRectMake((float)133/320 * screenWidth, (float)141/568 * screenHeight, (float)186/320 * screenWidth, (float)15/568 * screenHeight);
        lb6.frame = CGRectMake((float)0/320 * screenWidth, (float)175/568 * screenHeight, (float)320/320 * screenWidth, (float)15/568 * screenHeight);
        lb7.frame = CGRectMake((float)0/320 * screenWidth, (float)190/568 * screenHeight, (float)320/320 * screenWidth, (float)15/568 * screenHeight);
        
        lb1.textColor = [UIColor blackColor];
        lb1.userInteractionEnabled=NO;
        lb1.text= @"Complete Your Purchase";
        lb1.font=[lb1.font fontWithSize:23];
        lb1.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lb1];
        
        NSMutableString *titlestring = [NSMutableString stringWithString:@"\""];
        [titlestring appendString:[dic objectForKey:@"title"]];
        [titlestring appendString:@"\""];
        lb2.textColor = [UIColor blackColor];
        lb2.userInteractionEnabled=NO;
        lb2.text= titlestring;
        [lb2 setFont:[UIFont boldSystemFontOfSize:17]];
        lb2.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lb2];
        
        NSURL *url1 = [NSURL URLWithString:[dic objectForKey:@"pic4"]];
        NSData *imageData = [NSData dataWithContentsOfURL:url1];
        UIImage *image1 = [UIImage imageWithData:imageData];

        [img1 setImage:image1];
        img1.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:img1];
        
        lb3.textColor = [UIColor blackColor];
        lb3.userInteractionEnabled=NO;
        lb3.text= [dic objectForKey:@"name"];
        lb3.font=[lb3.font fontWithSize:14];
        lb3.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:lb3];
        
        lb4.text= [dic objectForKey:@"address"];
        lb4.font=[lb4.font fontWithSize:14];
        lbl4.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:lb4];
        
        lb5.text= [dic objectForKey:@"phone"];
        lb5.font=[lb5.font fontWithSize:14];
        lbl5.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:lb5];
        
        lb6.textColor = [UIColor blackColor];
        lb6.backgroundColor=[UIColor clearColor];
        lb6.text= @"Showtime 9:00 pm";
        lb6.font=[lb6.font fontWithSize:14];
        lb6.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lb6];
        
        NSString* mustarrive = [NSString stringWithFormat:@"Must arrive by %@", [dic objectForKey:@"mustarrive"]];
        lb7.textColor = [UIColor blackColor];
        lb7.backgroundColor=[UIColor clearColor];
        lb7.userInteractionEnabled=NO;
        lb7.text= mustarrive;
        lb7.font = [lb7.font fontWithSize:14];
        lb7.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lb7];
        
        box3.frame = CGRectMake((float)77/320 * screenWidth, (float)237/568 * screenHeight, (float)167/320 * screenWidth, (float)46/568 * screenHeight);
        [self.view addSubview:box3];
        
        CALayer *bottomBorder2 = [CALayer layer];
        bottomBorder2.frame = CGRectMake(0.0f, box3.frame.size.height - 1, box3.frame.size.width, 1.0f);
        bottomBorder2.backgroundColor = [UIColor blackColor].CGColor;
        [box3.layer addSublayer:bottomBorder2];
        
        CALayer *topBorder2 = [CALayer layer];
        topBorder2.frame = CGRectMake(0.0f, 0, box3.frame.size.width, 1.0f);
        topBorder2.backgroundColor = [UIColor blackColor].CGColor;
        [box3.layer addSublayer:topBorder2];
        
        lb9.textColor = [UIColor blackColor];
        lb9.frame = CGRectMake((float)86/320 * screenWidth, (float)241/568 * screenHeight, (float)63/320 * screenWidth, (float)15/568 * screenHeight);
        lb9.backgroundColor=[UIColor clearColor];
        lb9.text= @"Quantity";
        lb9.font = [lb9.font fontWithSize:13];
        lb9.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lb9];
        
         lb10.textColor = [UIColor blackColor];
         lb10.frame = CGRectMake((float)193/320 * screenWidth, (float)242/568 * screenHeight, (float)42/320 * screenWidth, (float)13/568 * screenHeight);
         lb10.backgroundColor=[UIColor clearColor];
         lb10.userInteractionEnabled=NO;
         lb10.text= @"Total";
         lb10.font = [lb10.font fontWithSize:13];
         [self.view addSubview:lb10];
        
        lb11.textColor = [UIColor blackColor];
         lb11.frame = CGRectMake((float)74/320 * screenWidth, (float)252/568 * screenHeight, (float)35/320 * screenWidth, (float)24/568 * screenHeight);
         lb11.backgroundColor=[UIColor clearColor];
         lb11.userInteractionEnabled=YES;
         lb11.text= @"-";
         [lb11 setFont:[UIFont boldSystemFontOfSize:35]];
         lb11.textAlignment = NSTextAlignmentCenter;
         [self.view addSubview:lb11];
         UITapGestureRecognizer* gestureminus = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnMinus:)];
         [lb11 setUserInteractionEnabled:YES];
         [lb11 addGestureRecognizer:gestureminus];
         
         NSString* ticketcountstring = [@(ticketcounter) stringValue];
         lblcounter.textColor = [UIColor blackColor];
         lblcounter.frame = CGRectMake((float)107/320 * screenWidth, (float)256/568 * screenHeight, (float)21/320 * screenWidth, (float)23/568 * screenHeight);
         lblcounter.backgroundColor=[UIColor clearColor];
         lblcounter.userInteractionEnabled=NO;
         lblcounter.text= ticketcountstring;
         lblcounter.font = [lblcounter.font fontWithSize:26];
         [self.view addSubview:lblcounter];
         
         lb13.textColor = [UIColor blackColor];
         lb13.frame = CGRectMake((float)132/320 * screenWidth, (float)252/568 * screenHeight, (float)22/320 * screenWidth, (float)24/568 * screenHeight);
         lb13.backgroundColor=[UIColor clearColor];
         lb13.userInteractionEnabled=YES;
         lb13.text= @"+";
         [lb13 setFont:[UIFont boldSystemFontOfSize:35]];
         lb13.textAlignment = NSTextAlignmentCenter;
         [self.view addSubview:lb13];
         lb13.layer.zPosition = 34;
         UITapGestureRecognizer* gestureplus = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnPlus:)];
         [lb13 setUserInteractionEnabled:YES];
         [lb13 addGestureRecognizer:gestureplus];
        
        lbltotalprice.textColor = [UIColor blackColor];
        lbltotalprice.frame = CGRectMake((float)181/320 * screenWidth, (float)256/568 * screenHeight, (float)68/320 * screenWidth, (float)23/568 * screenHeight);
        lbltotalprice.backgroundColor=[UIColor clearColor];
        lbltotalprice.userInteractionEnabled=NO;
        NSString *price = [NSString stringWithFormat:@"$%@", [dic objectForKey:@"price"]];
        NSString *needle = [price componentsSeparatedByString:@"$"][1];
        double baseprice = [needle doubleValue];
        
        lbltotalprice.text= [NSString stringWithFormat:@"$%.2f",ticketcounter*baseprice];
        lbltotalprice.font = [lbltotalprice.font fontWithSize:17];
        [self.view addSubview:lbltotalprice];
        
        lb15.textColor = [UIColor blackColor];
        lb15.frame = CGRectMake((float)0/320 * screenWidth, (float)297/568 * screenHeight, (float)320/320 * screenWidth, (float)17/568 * screenHeight);
        lb15.backgroundColor=[UIColor clearColor];
        lb15.userInteractionEnabled=NO;
        NSString* expirationtime = [NSString stringWithFormat:@"%@", [dic objectForKey:@"expirationTime"]];
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        NSString *currentTime = [dateFormatter stringFromDate:today];
        NSString* salescloses = [NSString stringWithFormat:@"Sales closes in %@", currentTime];
        lb15.text= salescloses;
        lb15.textAlignment = NSTextAlignmentCenter;
        lb15.font = [lb15.font fontWithSize:15];
        [self.view addSubview:lb15];
        
        img2.frame = CGRectMake((float)58/320 * screenWidth, (float)365/568 * screenHeight, (float)37/320 * screenWidth, (float)26/568 * screenHeight);
        UIImage *image2 = [UIImage imageNamed: @"VISA_Logo"];
        [img2 setImage:image2];
        img2.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:img2];
        
        lb16.textColor = [UIColor blackColor];
        lb16.frame = CGRectMake((float)105/320 * screenWidth, (float)369/568 * screenHeight, (float)212/320 * screenWidth, (float)17/568 * screenHeight);
        lb16.backgroundColor=[UIColor clearColor];
        lb16.userInteractionEnabled=NO;
        lb16.text= @"**** **** **** 9872 (change)";
        lb16.font = [lb16.font fontWithSize:15];
        [self.view addSubview:lb16];
        
        lb17.textColor = [UIColor blackColor];
        lb17.frame = CGRectMake((float)0/320 * screenWidth, (float)395/568 * screenHeight, (float)320/320 * screenWidth, (float)16/568 * screenHeight);
        lb17.backgroundColor=[UIColor clearColor];
        lb17.userInteractionEnabled=NO;
        lb17.text= @"will be charged";
        lb17.textAlignment = NSTextAlignmentCenter;
        lb17.font = [lb17.font fontWithSize:15];
        [self.view addSubview:lb17];
        
        lb18.textColor = [UIColor blackColor];
        lb18.frame = CGRectMake((float)0/320 * screenWidth, (float)417/568 * screenHeight, (float)320/320 * screenWidth, (float)16/568 * screenHeight);
        lb18.backgroundColor=[UIColor clearColor];
        lb18.userInteractionEnabled=NO;
        lb18.text= @"once you click \"accept\"";
        lb18.textAlignment = NSTextAlignmentCenter;
        lb18.font = [lb18.font fontWithSize:15];
        [self.view addSubview:lb18];
        
        img5.frame = CGRectMake((float)63/320 * screenWidth, (float)444/568 * screenHeight, (float)206/320 * screenWidth, (float)40/568 * screenHeight);
        UIImage *image5 = [UIImage imageNamed: @"button_accept"];
        [img5 setImage:image5];
        img5.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:img5];
        UITapGestureRecognizer* gestureaccept = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedOnAccept:)];
        [img5 setUserInteractionEnabled:YES];
        [img5 addGestureRecognizer:gestureaccept];
    }];
}
- (void)userTappedOnAccept:(UIGestureRecognizer*)gestureRecognizer
{
    [lb1 removeFromSuperview];
    [lb2 removeFromSuperview];
    [lb3 removeFromSuperview];
    [lb4 removeFromSuperview];
    [lb5 removeFromSuperview];
    [lb6 removeFromSuperview];
    [lb7 removeFromSuperview];
    [lb8 removeFromSuperview];
    [lb9 removeFromSuperview];
    [lb10 removeFromSuperview];
    [lb11 removeFromSuperview];
    [lb12 removeFromSuperview];
    [lb13 removeFromSuperview];
    [lb14 removeFromSuperview];
    [lb15 removeFromSuperview];
    [lb16 removeFromSuperview];
    [lb17 removeFromSuperview];
    [lb18 removeFromSuperview];
    [txtv3 removeFromSuperview];
    [img1 removeFromSuperview];
    [img2 removeFromSuperview];
    [img5 removeFromSuperview];
    [box3 removeFromSuperview];
    [lbltotalprice removeFromSuperview];
    
    lb1.textColor = [UIColor blackColor];
    lb1.frame = CGRectMake(0, statusbarheight + (float)30/568 * screenHeight, screenWidth, (float)30/568 * screenHeight);
    lb1.userInteractionEnabled=NO;
    lb1.text= @"Enjoy!";
    lb1.font=[lb1.font fontWithSize:25];
    lb1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb1];
    
    txtv3.textColor = [UIColor blackColor];
    txtv3.frame = CGRectMake((float)40/320 * screenWidth, statusbarheight + (float)60/568 * screenHeight, (float)260/320 * screenWidth, (float)40/568 * screenHeight);
    txtv3.userInteractionEnabled=NO;
    txtv3.text= @"Show this code at the door upon arrival at the theater.";
    txtv3.font=[txtv3.font fontWithSize:15];
    txtv3.textAlignment = NSTextAlignmentCenter;
    txtv3.textContainerInset = UIEdgeInsetsZero;
    [txtv3 setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:txtv3];
    
    img5.frame = CGRectMake((float)100/320 * screenWidth, statusbarheight + (float)155/568 * screenHeight, (float)130/320 * screenWidth, (float)130/568 * screenHeight);
    UIImage *image5 = [UIImage imageNamed: @"go"];
    [img5 setImage:image5];
    img5.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:img5];
    
    txtv2.textColor = [UIColor blackColor];
    txtv2.frame = CGRectMake((float)40/320 * screenWidth, statusbarheight + (float)102/568 * screenHeight, (float)260/320 * screenWidth, (float)40/568 * screenHeight);
    txtv2.userInteractionEnabled=NO;
    txtv2.text= @"For additional information contact the theater directly.";
    txtv2.font=[txtv2.font fontWithSize:15];
    txtv2.textAlignment = NSTextAlignmentCenter;
    txtv2.textContainerInset = UIEdgeInsetsZero;
    [txtv2 setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:txtv2];
    
    lb3.textColor = [UIColor blackColor];
    lb3.frame = CGRectMake(0, statusbarheight + (float)280/568 * screenHeight, screenWidth, (float)30/568 * screenHeight);
    lb3.userInteractionEnabled=NO;
    lb3.text= @"XL678234GUIA";
    lb3.font=[lb3.font fontWithSize:15];
    lb3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lb3];
    
    lb4.textColor = [UIColor blackColor];
    lb4.frame = CGRectMake((float)4/320 * screenWidth, (float)447/568 * screenHeight, (float)145/320 * screenWidth, (float)12/568 * screenHeight);
    lb4.userInteractionEnabled=NO;
    NSString* mustarrive = [NSString stringWithFormat:@"Must arrive by %@", [dic objectForKey:@"mustarrive"]];
    lb4.text= mustarrive;
    lb4.font=[lb4.font fontWithSize:12];
    lb4.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lb4];
    
    lb5.textColor = [UIColor blackColor];
    lb5.frame = CGRectMake((float)4/320 * screenWidth, (float)435/568 * screenHeight, (float)146/320 * screenWidth, (float)12/568 * screenHeight);
    lb5.userInteractionEnabled=NO;
    lb5.text= @"Showtime 9:00 pm";
    lb5.font=[lb5.font fontWithSize:12];
    lb5.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lb5];
    
    lb6.textColor = [UIColor blackColor];
    lb6.frame = CGRectMake((float)4/320 * screenWidth, (float)392/568 * screenHeight, (float)145/320 * screenWidth, (float)12/568 * screenHeight);
    lb6.userInteractionEnabled=NO;
    lb6.text= [dic objectForKey:@"phone"];
    lb6.font=[lb6.font fontWithSize:12];
    lb6.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lb6];

    
    lb7.textColor = [UIColor blackColor];
    lb7.frame = CGRectMake((float)4/320 * screenWidth, (float)380/568 * screenHeight, (float)145/320 * screenWidth, (float)12/568 * screenHeight);
    lb7.userInteractionEnabled=NO;
    lb7.text= [dic objectForKey:@"address"];
    lb7.font=[lb7.font fontWithSize:12];
    lb7.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lb7];

    
    lb8.textColor = [UIColor blackColor];
    lb8.frame = CGRectMake((float)4/320 * screenWidth, (float)368/568 * screenHeight, (float)145/320 * screenWidth, (float)12/568 * screenHeight);
    lb8.userInteractionEnabled=NO;
    lb8.text= [dic objectForKey:@"name"];
    lb8.font=[lb8.font fontWithSize:12];
    lb8.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:lb8];
        
    txtv1.textColor = [UIColor blackColor];
    txtv1.frame = CGRectMake((float)0/320 * screenWidth, (float)335/568 * screenHeight, (float)96/320 * screenWidth, (float)28/568 * screenHeight);
    txtv1.userInteractionEnabled=NO;
    NSMutableString *titlestring = [NSMutableString stringWithString:@"\""];
    [titlestring appendString:[dic objectForKey:@"title"]];
    [titlestring appendString:@"\""];
    txtv1.text= titlestring;
    [txtv1 setFont:[UIFont boldSystemFontOfSize:11]];
    txtv1.textAlignment = NSTextAlignmentLeft;
    txtv1.textContainerInset = UIEdgeInsetsZero;
    [txtv1 setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:txtv1];
    
    mapView_.frame = CGRectMake((float)149/320 * screenWidth, (float)337/568 * screenHeight, (float)171/320 * screenWidth, (float)187/568 * screenHeight);
    
    mapView_.camera = [GMSCameraPosition cameraWithLatitude:locationclick1.latitude longitude:locationclick1.longitude zoom:15];
    mapView_.userInteractionEnabled = NO;
    [self.view addSubview:mapView_];
    
    
}
-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    NSLog(@"detected");
    if(swipecounter == 1)
    {
        swipecounter = 2;
        [self userTappedOnimg1:gestureRecognizer];
    }
    else if(swipecounter == 2)
    {
        [self createYelp:@"http://www.yelp.com/biz/classic-stage-company-new-york"];
    }
    else if(swipecounter == 3)
    {
        NSLog(@"detected2");
        swipecounter = 4;
        [self staticmap:gestureRecognizer];
    }
}
-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if(swipecounter == 2)
    {
        [self userTappedOnMoreInfo:gestureRecognizer];
    }
    else if(swipecounter == 3)
    {
        [self userTappedOnimg1:gestureRecognizer];
    }
    else if(swipecounter == 4)
    {
        [self createYelp:@"http://www.yelp.com/biz/classic-stage-company-new-york"];
    }
}
-(UIView*) CreateYelpView:(NSString*)url
{
    UIView* viewbox = [[UIView alloc]initWithFrame:CGRectMake((float)0/320 * screenWidth, (float)0/568 * screenHeight, (float)320/320 * screenWidth, (float)380/568 * screenHeight)];
    webviewyelp.frame = CGRectMake((float)20/320 * screenWidth, statusbarheight + (float)50/568 * screenHeight, (float)280/320 * screenWidth, (float)280/568 * screenHeight);
    webviewyelp.delegate = self;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: url] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 50000];
    [webviewyelp loadRequest: request];
    [viewbox addSubview:webviewyelp];
    return viewbox;
}
-(void) createYelp:(NSString*)url
{
    [img10 removeFromSuperview];
    swipecounter = 3;
    UIView* thisview = [self CreateYelpView:url];
    [self.view addSubview:thisview];
}
-(UIView*) CreateStaticMap
{
    UIView* viewbox = [[UIView alloc]initWithFrame:CGRectMake((float)0/320 * screenWidth, (float)0/568 * screenHeight, (float)320/320 * screenWidth, (float)380/568 * screenHeight)];
    
    img10.frame = CGRectMake((float)4/320 * screenWidth, (float)66/568 * screenHeight, (float)312/320 * screenWidth, (float)285/568 * screenHeight);
    UISwipeGestureRecognizer *swipeRecognizerl = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureSwipe:)];
    UISwipeGestureRecognizer *swipeRecognizerr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureSwipe:)];
    swipeRecognizerr.direction = UISwipeGestureRecognizerDirectionRight;
    swipeRecognizerl.direction = UISwipeGestureRecognizerDirectionLeft;
    [img10 addGestureRecognizer:swipeRecognizerl];
    [img10 addGestureRecognizer:swipeRecognizerr];
    [viewbox addSubview:img10];
    
    NSURL *imageURL = [NSURL URLWithString:@"https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Clabel:C%7C40.718217,-73.998284"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            img10.image = [UIImage imageWithData:imageData];
        });
    });

     return viewbox;
}
-(void) staticmap:(UIGestureRecognizer*)gestureRecognizer
{
    swipecounter = 4;
    [scrollview1 removeFromSuperview];
    //[webviewyelp removeFromSuperview];
    UIView* thisview = [self CreateStaticMap];
    [self.view addSubview:thisview];
}
-(UIView*) CreateUserTappedImg1
{
    UIView* viewbox = [[UIView alloc]initWithFrame:CGRectMake((float)0/320 * screenWidth, (float)0/568 * screenHeight, (float)320/320 * screenWidth, (float)380/568 * screenHeight)];
    
    box2.frame = CGRectMake(0, statusbarheight + (float)50/568 * screenHeight, (float)280/320 * screenWidth, (float)280/568 * screenHeight);
    [viewbox addSubview:box2];
    box2.userInteractionEnabled = YES;
    //[webviewyelp removeFromSuperview];
    UISwipeGestureRecognizer *swipeRecognizerl = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureSwipe:)];
    UISwipeGestureRecognizer *swipeRecognizerr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureSwipe:)];
    swipeRecognizerr.direction = UISwipeGestureRecognizerDirectionRight;
    swipeRecognizerl.direction = UISwipeGestureRecognizerDirectionLeft;
    [box2 addGestureRecognizer:swipeRecognizerl];
    [box2 addGestureRecognizer:swipeRecognizerr];
    
    /*[lb3 removeFromSuperview];
    [lb4 removeFromSuperview];
    [lb5 removeFromSuperview];
    [lb6 removeFromSuperview];
    [lb7 removeFromSuperview];
    [lb8 removeFromSuperview];
    [lb9 removeFromSuperview];
    [lb10 removeFromSuperview];
    [txtv1 removeFromSuperview];
    [txtv2 removeFromSuperview];
    [txtv3 removeFromSuperview];
    [txtv4 removeFromSuperview];
    [img6 removeFromSuperview];
    */
    scrollview1.frame = CGRectMake((float)35/320 * screenWidth, (float)55/568 * screenHeight, (float)249/320 * screenWidth, (float)312/568 * screenHeight);
    scrollview1.contentSize = CGSizeMake((float)249/320 * screenWidth, (float)840/568 * screenHeight);
    //scrollview1.delegate = self;
    
    img7.frame = CGRectMake(0, 0, (float)280/320 * screenWidth, (float)280/568 * screenHeight);
    [img7 setImage:image1];
    img7.contentMode = UIViewContentModeScaleAspectFit;
    [scrollview1 addSubview:img7];
    
    img8.frame = CGRectMake(0, (float)280/568 * screenHeight, (float)280/320 * screenWidth, (float)280/568 * screenHeight);
    [img8 setImage:image2];
    img8.contentMode = UIViewContentModeScaleAspectFit;
    [scrollview1 addSubview:img8];
    
    img9.frame = CGRectMake(0, (float)560/568 * screenHeight, (float)280/320 * screenWidth, (float)280/568 * screenHeight);
    [img9 setImage:image3];
    img9.contentMode = UIViewContentModeScaleAspectFit;
    
    [scrollview1 addSubview:img9];
    [scrollview1.panGestureRecognizer requireGestureRecognizerToFail:swipeRecognizerl];
    [scrollview1.panGestureRecognizer requireGestureRecognizerToFail:swipeRecognizerr];
    [scrollview1 setShowsVerticalScrollIndicator:NO];
    [viewbox addSubview:scrollview1];
    scrollview1.delegate = self;
    
    
    return viewbox;
}
- (void)userTappedOnimg1:(UIGestureRecognizer*)gestureRecognizer
{
    swipecounter = 2;
    [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        mapView_.frame = CGRectMake(0, statusbarheight, 0, screenRect.size.height * .60f);
    }completion:^(BOOL finished) {mapView_.frame = CGRectMake(0, 0, 0, 0);
        
        UIView* thisview = [self CreateUserTappedImg1];
        [self.view addSubview:thisview];
        
        [UIView animateWithDuration:.5 animations:^{scrollview1.contentOffset = CGPointMake(0, 0);}];
    }];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // disable timer here
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    
    if(translation.x > 100)
    {
        // react to dragging right
    }
    else if(translation.x < -20)
    {
        // react to dragging left
        swipecounter = 3;
        [scrollview1 removeFromSuperview];
        webviewyelp.frame = CGRectMake((float)10/320 * screenWidth, statusbarheight + (float)60/568 * screenHeight, (float)300/320 * screenWidth, (float)280/568 * screenHeight);
        webviewyelp.delegate = self;
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://www.yelp.com/biz/classic-stage-company-new-york"] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 500];
        [webviewyelp loadRequest: request];
        [self.view addSubview:webviewyelp];
        
        UISwipeGestureRecognizer *swipeRecognizerl = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureSwipe:)];
        UISwipeGestureRecognizer *swipeRecognizerr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureSwipe:)];
        swipeRecognizerr.direction = UISwipeGestureRecognizerDirectionRight;
        swipeRecognizerl.direction = UISwipeGestureRecognizerDirectionLeft;
        [webviewyelp addGestureRecognizer:swipeRecognizerl];
        [webviewyelp addGestureRecognizer:swipeRecognizerr];
        [webviewyelp.scrollView.panGestureRecognizer requireGestureRecognizerToFail:swipeRecognizerl];
        [webviewyelp.scrollView.panGestureRecognizer requireGestureRecognizerToFail:swipeRecognizerr];
        
    }
}
-(void)onGestureSwipe:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if(gestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        [self swipeleft:gestureRecognizer];
    }
    else
    {
        [self swiperight:gestureRecognizer];
    }
}
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    // your code
}
- (void)mapbuttonMethod {
    if(mapView_.frame.size.height > 0)
    {
        [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            mapView_.frame = CGRectMake(0, statusbarheight, screenRect.size.width, 0);
        }completion:^(BOOL finished) {mapView_.frame = CGRectMake(0, 0, 0, 0);}];
    }
    else
    {
        mapView_.frame = CGRectMake(0, statusbarheight, screenWidth, 0);
        [UIView animateWithDuration:.5 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            mapView_.frame = CGRectMake(0, statusbarheight, screenWidth, screenHeight * .60);
        }completion:^(BOOL finished) {}];
    }
}
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown_R:0.0 G:108.0 B:194.0 alpha:0.70];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    lblSelectedCountryNames.text=[arryList objectAtIndex:anIndex];
    
    NSLog(@"%@", lblSelectedCountryNames.text);
    if ([lblSelectedCountryNames.text containsString:@"****"]) {
        UIViewController *toViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"editcreditcard"];
        MyCustomSegue *segue = [[MyCustomSegue alloc] initWithIdentifier:@"" source:self destination:toViewController];
        [self prepareForSegue:segue sender:self];
        [segue perform];
        
    } else {
        NSLog(@"string does not contain **** **** ****");
    }
}
- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
    /*----------------Get Selected Value[Multiple selection]-----------------*/
    if (ArryData.count>0) {
        lblSelectedCountryNames.text=[ArryData componentsJoinedByString:@"\n"];
        CGSize size=[self GetHeightDyanamic:lblSelectedCountryNames];
        lblSelectedCountryNames.frame=CGRectMake(16, 240, 287, size.height);
    }
    else{
        lblSelectedCountryNames.text=@"";
    }
    
}
- (void)DropDownListViewDidCancel{
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIView class]]) {
        [Dropobj fadeOut];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGSize)GetHeightDyanamic:(UILabel*)lbl
{
    NSRange range = NSMakeRange(0, [lbl.text length]);
    CGSize constraint;
    constraint= CGSizeMake(288 ,MAXFLOAT);
    CGSize size;
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)) {
        NSDictionary *attributes = [lbl.attributedText attributesAtIndex:0 effectiveRange:&range];
        CGSize boundingBox = [lbl.text boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    else{
        
        size = [lbl.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    }
    return size;
}


@end
