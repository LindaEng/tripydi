//
//  CustomTabBar.m
//  OpenSeatr
//
//  Created by Ben Wang on 7/31/15.
//  Copyright (c) 2015 Ben Wang. All rights reserved.
//

#import "CustomTabBar.h"

@implementation CustomTabBar

-(CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeThatFits = [super sizeThatFits:size];
    sizeThatFits.height = 30;
    
    return sizeThatFits;
}
@end
