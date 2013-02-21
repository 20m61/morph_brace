//
//  beltToBraceSegue.m
//  morph_blass
//
//  Created by ゆかいなおじさん.com on 13/02/21.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "beltToBraceSegue.h"
#import "beltViewController.h"
#import "braceViewController.h"

@implementation beltToBraceSegue

-(void)perform{
    beltViewController *sourceViewController = (beltViewController *)self.sourceViewController;
    braceViewController *destinationViewController = (braceViewController*)self.destinationViewController;
    
    [sourceViewController presentViewController:destinationViewController animated:YES completion:NULL];
}

@end
