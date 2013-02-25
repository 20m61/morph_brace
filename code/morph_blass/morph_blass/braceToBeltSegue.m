//
//  braceToBeltSegue.m
//  morph_blass
//
//  Created by ゆかいなおじさん.com on 13/02/25.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "braceToBeltSegue.h"
#import "braceViewController.h"
#import "beltViewController.h"

@implementation braceToBeltSegue

-(void)perform{   
    [[self sourceViewController] presentModalViewController:[self destinationViewController] animated:NO];
}
@end