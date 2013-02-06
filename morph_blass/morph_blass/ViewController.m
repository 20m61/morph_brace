//
//  ViewController.m
//  morph_blass
//
//  Created by ゆかいなおじさん.com on 13/02/05.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface ViewController ()
@property float viewWidthSize;
@property float viewHeightSize;
@property float screenW;
@property float screenH;
@property UIScrollView *scrollView;
@property UIImageView *imageView;
@end

@implementation ViewController

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
                                        duration:(NSTimeInterval)duration {
    NSLog(@"rotate");
    [self viewWillAppear:YES];
    int orientasion = self.interfaceOrientation;
    NSLog(@"%d", self.interfaceOrientation);
    if ((orientasion == 1) || (orientasion == 2)) {
        self.screenW = [[UIScreen mainScreen] applicationFrame].size.width;  //幅
        self.screenH = [[UIScreen mainScreen] applicationFrame].size.height; //高さ
    }else{
        self.screenH = [[UIScreen mainScreen] applicationFrame].size.width;  //幅
        self.screenW = [[UIScreen mainScreen] applicationFrame].size.height; //高さ
    }
    
    CGRect rotateFitRect = CGRectMake(0, 0, self.screenW, self.screenH);
    self.scrollView.frame = rotateFitRect;
    // UIScrollViewのインスタンスをビューに追加
    [self.view addSubview:self.scrollView];
    
    NSLog(@"%@", NSStringFromCGRect(self.scrollView.frame));
    NSLog(@"rotate: %f / %f",self.screenW, self.screenH);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self makeScrollView];
}

- (void)makeScrollView{
    // UIScrollViewのインスタンス化
    CGRect rect = CGRectMake(0, 0, 480, 300);
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:rect];
    
    // スクロールしたときバウンドさせないようにする
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    
    
    // UIImageViewのインスタンス化
    // サンプルとして画面に収まりきらないサイズ
    CGRect rect2 = CGRectMake(0, 0, 720, 300);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect2];
    
    // 画像を設定
    imageView.image = [UIImage imageNamed:@"UI.png"];
    
    // UIScrollViewのインスタンスに画像を貼付ける
    [scrollView addSubview:imageView];
    
    
    // UIScrollViewのコンテンツサイズを画像のサイズに合わせる
    scrollView.contentSize = imageView.bounds.size;
    
    // UIScrollViewのインスタンスをビューに追加
    [self.view addSubview:scrollView];
    
    // 表示されたときスクロールバーを点滅
    [scrollView flashScrollIndicators];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end