//
//  TempPage1.m
//  AptLis
//
//  Created by Ben Wang on 8/30/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//

#import "TempPage1.h"
#import <QuartzCore/QuartzCore.h>

#import "PanoramaView.h"

@implementation TempPage1
{
    CGFloat screenWidth;
    CGFloat screenHeight;
    PanoramaView *panoramaView;
    int currentitemindex;
}

-(void) viewDidLoad
{
    currentitemindex = 0;
    screenWidth = [[UIScreen mainScreen] bounds].size.width;
    screenHeight =  [[UIScreen mainScreen] bounds].size.height;
    panoramaView = [[PanoramaView alloc] init];
    [panoramaView setOrientToDevice:YES];
    [panoramaView setTouchToPan:NO];
    [panoramaView setPinchToZoom:YES];
    [panoramaView setShowTouches:NO];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.numberOfTapsRequired = 2;
    [panoramaView addGestureRecognizer:tapGesture];
    
    [self.view addSubview:[self createRecommend:currentitemindex]];
}
-(UIView*) createRecommend: (NSInteger) index
{
    UIView* recommendview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    
    UIImageView *myBox = [[UIImageView alloc] initWithFrame:CGRectMake(0,333,screenWidth, screenHeight-333)];
    UIImage *background = [[UIImage alloc]init];
    background = [UIImage imageNamed:@"bottomshow.png"];
    myBox.image = background;
    [recommendview addSubview:myBox];
    
    UIView *myBox0 = [[UIView alloc] initWithFrame:CGRectMake((float)0/320 * screenWidth, (float)0/568 * screenHeight, (float)320/320 * screenWidth, (float)333/568 * screenHeight)];
    myBox0.backgroundColor = [UIColor whiteColor];
    [recommendview addSubview:myBox0];
    //myBox0.layer.borderColor = [UIColor blackColor].CGColor;
    //myBox0.layer.borderWidth = 2.0f;
    
    //UIView *myBox1 = [[UIView alloc] initWithFrame:CGRectMake((float)112/320 * screenWidth, (float)34/568 * screenHeight, (float)85/320 * screenWidth, (float)36/568 * screenHeight)];
    //[self.view addSubview:myBox1];
    //myBox1.layer.borderColor = [UIColor blackColor].CGColor;
    //myBox1.layer.borderWidth = 2.0f;
    UIImageView *myBox1 = [[UIImageView alloc] initWithFrame:CGRectMake((float)0/320 * screenWidth, (float)35/568 * screenHeight, (float)320/320 * screenWidth, (float)60/568 * screenHeight)];
    UIImage *background1 = [[UIImage alloc]init];
    myBox1.contentMode = UIViewContentModeScaleAspectFit;
    background1 = [UIImage imageNamed:@"LogoWords.png"];
    //myBox1.layer.borderColor = [UIColor blackColor].CGColor;
    //myBox1.layer.borderWidth = 2.0f;
    myBox1.image = background1;
    [recommendview addSubview:myBox1];
    
    UIView *myBox2 = [[UIView alloc] initWithFrame:CGRectMake((float)2/320 * screenWidth, (float)357/568 * screenHeight, (float)315/320 * screenWidth, (float)19/568 * screenHeight)];
    [recommendview addSubview:myBox2];
    //myBox2.layer.borderColor = [UIColor blackColor].CGColor;
    //myBox2.layer.borderWidth = 2.0f;
    
    UIView *myBox3 = [[UIView alloc] initWithFrame:CGRectMake((float)190/320 * screenWidth, (float)397/568 * screenHeight, (float)122/320 * screenWidth, (float)15/568 * screenHeight)];
    [recommendview addSubview:myBox3];
    //myBox3.layer.borderColor = [UIColor blackColor].CGColor;
    //myBox3.layer.borderWidth = 2.0f;
    
    UIView *myBox4 = [[UIView alloc] initWithFrame:CGRectMake((float)49/320 * screenWidth, (float)396/568 * screenHeight, (float)17/320 * screenWidth, (float)13/568 * screenHeight)];
    [recommendview addSubview:myBox4];
    //myBox4.layer.borderColor = [UIColor blackColor].CGColor;
    //myBox4.layer.borderWidth = 2.0f;
    
    UIView *myBox5 = [[UIView alloc] initWithFrame:CGRectMake((float)19/320 * screenWidth, (float)395/568 * screenHeight, (float)19/320 * screenWidth, (float)14/568 * screenHeight)];
    [recommendview addSubview:myBox5];
    //myBox5.layer.borderColor = [UIColor blackColor].CGColor;
    //myBox5.layer.borderWidth = 2.0f;
    
    UIView *myBox6 = [[UIView alloc] initWithFrame:CGRectMake((float)38/320 * screenWidth, (float)434/568 * screenHeight, (float)63/320 * screenWidth, (float)63/568 * screenHeight)];
    [recommendview addSubview:myBox6];
    //myBox6.layer.borderColor = [UIColor blackColor].CGColor;
    //myBox6.layer.borderWidth = 2.0f;
    
    UIView *myBox7 = [[UIView alloc] initWithFrame:CGRectMake((float)141/320 * screenWidth, (float)448/568 * screenHeight, (float)30/320 * screenWidth, (float)34/568 * screenHeight)];
    [recommendview addSubview:myBox7];
    //myBox7.layer.borderColor = [UIColor blackColor].CGColor;
    //myBox7.layer.borderWidth = 2.0f;
    
    UIView *myBox8 = [[UIView alloc] initWithFrame:CGRectMake((float)209/320 * screenWidth, (float)435/568 * screenHeight, (float)66/320 * screenWidth, (float)58/568 * screenHeight)];
    [recommendview addSubview:myBox8];
    //myBox8.layer.borderColor = [UIColor blackColor].CGColor;
    //myBox8.layer.borderWidth = 2.0f;
    
    UIView *myBox9 = [[UIView alloc] initWithFrame:CGRectMake((float)4/320 * screenWidth, (float)526/568 * screenHeight, (float)312/320 * screenWidth, (float)37/568 * screenHeight)];
    [recommendview addSubview:myBox9];
    //myBox9.layer.borderColor = [UIColor blackColor].CGColor;
    //myBox9.layer.borderWidth = 2.0f;
    
    [recommendview addSubview:[self createCarousel:index]];
    
    return recommendview;
}
-(UIView*) createCarousel: (NSInteger) index
{
    UIView* carol = [[UIView alloc] initWithFrame:CGRectMake((float)0/320 * screenWidth, (float)0/568 * screenHeight, (float)320/320 * screenWidth, (float)380/568 * screenHeight)];
    
    //create carousel
    _carousel = [[iCarousel alloc] initWithFrame:CGRectMake((float)0/320 * screenWidth, (float)0/568 * screenHeight, (float)320/320 * screenWidth, (float)380/568 * screenHeight)];
    _carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _carousel.type = iCarouselTypeCoverFlow;
    _carousel.delegate = self;
    _carousel.dataSource = self;
    [_carousel scrollToItemAtIndex:index animated:NO];
    //add carousel to view
    [carol addSubview:_carousel];
    return carol;
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if(index == carousel.currentItemIndex){
        currentitemindex = carousel.currentItemIndex;
        //go to panorama here
        NSString* panimgpath = [NSString stringWithFormat:@"pan%ld.jpg", (long)index];
        [panoramaView setImage:panimgpath];
        
        [self setView:panoramaView];
    }
}
- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        // handling code
        [self setView:[self createRecommend: currentitemindex]];
    }
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    //update words
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
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake((float)0/320 * screenWidth, (float)68/568 * screenHeight, (float)320/320 * screenWidth, (float)265/568 * screenHeight)];
    
    UIImageView* imgview = [[UIImageView alloc] initWithFrame:CGRectMake((float)43/320 * screenWidth, (float)40/568 * screenHeight, (float)232/320 * screenWidth, (float)234/568 * screenHeight)];
    imgview.layer.cornerRadius = 5.0;
    imgview.layer.borderColor = [[UIColor whiteColor] CGColor];
    imgview.layer.borderWidth = 4.0;
    imgview.layer.masksToBounds = YES;
    
    [view1 addSubview:imgview];
    
    //UIView *viewborder = [[UIView alloc] initWithFrame:CGRectMake((float)43/320 * screenWidth, (float)40/568 * screenHeight, (float)232/320 * screenWidth, (float)234/568 * screenHeight)];
    //viewborder.layer.borderColor = [[UIColor blackColor] CGColor];
    //viewborder.layer.borderWidth = 1.0;
    //viewborder.layer.masksToBounds = YES;
    //[view1 addSubview:viewborder];
    
    if(index == 0)
    {
        imgview.image = [UIImage imageNamed:@"h1.png"];

        return view1;
    }
    else if(index == 1)
    {
        imgview.image = [UIImage imageNamed:@"h2.png"];

        return view1;
    }
    else if(index == 2)
    {
        imgview.image = [UIImage imageNamed:@"h3.png"];

        return view1;
    }
    else if(index == 3)
    {
        imgview.image = [UIImage imageNamed:@"h4.png"];

        return view1;
    }
    else{
        return nil;
    }
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
-(void) glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [panoramaView draw];
}
@end
