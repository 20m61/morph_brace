//
//  beltToBraceSegue.m
//  morph_blass
//
//  Created by ゆかいなおじさん.com on 13/02/25.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "beltToBraceSegue.h"
#import "beltViewController.h"
#import "braceViewController.h"

@implementation beltToBraceSegue

- (void)perform{
    [[self sourceViewController] presentModalViewController:[self  destinationViewController] animated:NO];
}

@end
