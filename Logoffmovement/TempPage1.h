//
//  TempPage1.h
//  AptLis
//
//  Created by Ben Wang on 8/30/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import <GLKit/GLKit.h>

@interface TempPage1 : GLKViewController<iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, strong) UINavigationItem *navItem;
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, strong) NSMutableArray *items;

@end
