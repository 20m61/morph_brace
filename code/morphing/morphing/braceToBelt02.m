//
//  braceToBelt02.m
//  morphing
//
//  Created by ゆかいなおじさん.com on 13/03/07.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "braceToBelt02.h"
#import "braceToBeltViewController.h"
#import "beltViewController.h"

@implementation braceToBelt02

- (void)perform{
    [[self sourceViewController] presentModalViewController:[self  destinationViewController] animated:NO];
}


@end
