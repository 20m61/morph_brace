//
//  beltViewController.h
//  morph_blass
//
//  Created by ゆかいなおじさん.com on 13/02/25.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface beltViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *toBraceSegueButton;
- (IBAction)beltTouchDown:(id)sender;
- (IBAction)beltTouchUpOutside:(id)sender;
@end
