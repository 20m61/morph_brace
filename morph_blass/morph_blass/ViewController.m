//
//  ViewController.m
//  morph_blass
//
//  Created by ゆかいなおじさん.com on 13/02/05.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()
@property float viewWidthSize;
@property float viewHeightSize;
@property float screenW;
@property float screenH;
@property UIScrollView *scrollView;
@property UIImageView *imageView;
@property MPMoviePlayerController *moviePlayer;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self viewWillAppear:YES];
    [self makeScrollView];
    
    [self makeMovie];
    
    
}

- (void)makeMovie{
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[self localMovieURL]];
    self.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    CGRect rect = CGRectMake(0, 0, self.screenH, self.screenW);
    self.moviePlayer.view.frame = rect;
    self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
}

-(NSURL *)localMovieURL
{
    NSURL *theMovieURL = nil;
    NSBundle *bundle = [NSBundle mainBundle];
    if (bundle)
    {
        NSString *moviePath = [bundle pathForResource:@"001" ofType:@"mov"];
        if (moviePath)theMovieURL = [NSURL fileURLWithPath:moviePath];
    }
    return theMovieURL;
}

-(void)viewWillAppear:(BOOL)animated{
    //スクリーンのサイズを取得
    self.screenW = [[UIScreen mainScreen] applicationFrame].size.width;  //幅
    self.screenH = [[UIScreen mainScreen] applicationFrame].size.height; //高さ
    //LOG
    NSLog(@"viewWillAppear%f / %f",self.screenW, self.screenH);
}

- (void)makeScrollView{
    // UIScrollViewのインスタンス化
    CGRect rect = CGRectMake(0, 0, self.screenH, self.screenW);
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:rect];
    //LOG
    NSLog(@"scrollView: %@", NSStringFromCGRect(scrollView.frame));
    
    // UIScrollViewのオプション設定
    scrollView.bounces = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    
    // UIImageViewのインスタンス化
    // サンプルとして画面に収まりきらないサイズ
    CGRect rect2 = CGRectMake(0, 0, self.screenH/2*3, self.screenW);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect2];
    //LOG
    NSLog(@"imageView: %@", NSStringFromCGRect(imageView.frame));
    
    // 画像を設定
    imageView.image = [UIImage imageNamed:@"UI.png"];
    
    // UIScrollViewのインスタンスに画像を貼付ける
    [scrollView addSubview:imageView];
    
    // UIScrollViewのコンテンツサイズを画像のサイズに合わせる
    scrollView.contentSize = imageView.bounds.size;
    
    // UIScrollViewのインスタンスをビューに追加
    [self.view addSubview:scrollView];
    
    //UIScrollViewのdeligateメソッドを呼ぶ
    scrollView.delegate = self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float x = scrollView.contentOffset.x;
    float y = scrollView.contentOffset.y;
    NSLog(@"scrolling: %f, %f", x, y);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float x = scrollView.contentOffset.x;
    float y = scrollView.contentOffset.y;
    if (x == 240) {
        [self mophSequence];
    }
    NSLog(@"scrolled: %f, %f", x, y);
}

- (void)mophSequence
{
    [self.view addSubview:self.moviePlayer.view];
    [self.moviePlayer play];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end