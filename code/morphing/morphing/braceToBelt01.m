//
//  braceToBelt01.m
//  morphing
//
//  Created by ゆかいなおじさん.com on 13/03/07.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "braceToBelt01.h"
#import "beltViewController.h"
#import "braceToBeltViewController.h"

@implementation braceToBelt01

- (void)perform{
    [[self sourceViewController] presentModalViewController:[self  destinationViewController] animated:NO];
}


@end
