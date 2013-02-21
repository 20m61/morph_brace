//
//  braceViewController.h
//  morph_blass
//
//  Created by ゆかいなおじさん.com on 13/02/20.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface braceViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *braceMainView;
@property (strong, nonatomic) IBOutlet UIScrollView *braceScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *braceScrollViewImage;

@end
