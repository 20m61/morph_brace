//
//  beltViewController.h
//  morph_blass
//
//  Created by ゆかいなおじさん.com on 13/02/20.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface beltViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *beltMainView;
@property (strong, nonatomic) IBOutlet UIImageView *beltViewMainImageView;
- (IBAction)toBeltButton:(id)sender;
- (IBAction)toBraceButton:(id)sender;

@end
