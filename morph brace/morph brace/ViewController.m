//
//  ViewController.m
//  morph brace
//
//  Created by ゆかいなおじさん.com on 13/01/31.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation ViewController
{
    IBOutlet UIScrollView *scrollView;
}

const CGFloat kScrollObjHeight = 460.0;//(※1)1pageの高さ
const CGFloat kScrollObjWidth  = 320.0;//(※2)1pageの幅
const NSUInteger kNumImages    = 3;    //(※3)総page数

//ScrollViewの設定
- (void)layoutScrollImages
{
    UIImageView *view = nil;
    NSArray *subviews = [scrollView subviews];
    
    CGFloat curXLoc = 0;
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(curXLoc, 0);
            view.frame = frame;
            
            curXLoc += (kScrollObjWidth);
        }
    }
    
    //スクロールの総範囲
    [scrollView setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), kScrollObjHeight)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    NSUInteger i;
    for (i = 1; i <= kNumImages; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"picture01.jpg"];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        CGRect rect = imageView.frame;
        rect.size.height = kScrollObjHeight;
        rect.size.width = kScrollObjWidth;
        imageView.frame = rect;
        imageView.tag = i;
        [scrollView addSubview:imageView];
    }
    
    [self layoutScrollImages];
    
    NSLog(@"prepare");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
