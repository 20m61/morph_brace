//
//  braceToBeltSegue.m
//  morph_blass
//
//  Created by ゆかいなおじさん.com on 13/02/21.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "braceToBeltSegue.h"
#import "beltViewController.h"
#import "braceViewController.h"

@implementation braceToBeltSegue

-(void)perform{
    braceViewController *sourceViewController = (braceViewController *)self.sourceViewController;
    beltViewController *destinationViewController = (beltViewController *)self.destinationViewController;
    
    [sourceViewController presentViewController:destinationViewController animated:YES completion:NULL];
}

@end
