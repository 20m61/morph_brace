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
@property float w;
@property float h;


@end

@implementation ViewController


- (void)viewWillAppear:(BOOL)animated
{
    self.h = self.view.frame.size.height;
    self.w = self.view.frame.size.width;
    NSLog(@"%f / %f",self.view.frame.size.width, self.view.frame.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self viewWillAppear:YES];
    
    // UIImageViewのインスタンス化
    // サンプルとして画面に収まりきらないサイズ
    CGRect rect = CGRectMake(0, 0, self.h*2, self.w*2);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    NSLog(@"imageView: %@", NSStringFromCGRect(imageView.frame));
    
    // UIScrollViewのインスタンス化
    CGRect rect2 = CGRectMake(0, 0, self.h, self.w);
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:rect2];
//    scrollView.frame = self.view.frame;
    NSLog(@"scrollView: %@", NSStringFromCGRect(scrollView.frame));
    
    // スクロールしたときバウンドさせないようにする
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    
    // 画像を設定
    imageView.image = [UIImage imageNamed:@"UI.png"];
    
    // UIScrollViewのインスタンスに画像を貼付ける
    [scrollView addSubview:imageView];
    
    
    // UIScrollViewのコンテンツサイズを画像のサイズに合わせる
    scrollView.contentSize = imageView.frame.size;
    
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