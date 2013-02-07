//
//  ViewController.m
//  morph_blass
//
//  Created by ゆかいなおじさん.com on 13/02/05.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property float viewWidthSize;
@property float viewHeightSize;
@property float screenW;
@property float screenH;
//@property UIScrollView *scrollView;
@property UIImageView *imageViewAnims1;
@property UIImageView *imageViewAnims2;
//@property NSTimer *timerAnims1;
//@property NSTimer *timerAnims2;
//@property AVPlayer *player;
//@property AVPlayerLayer *playLayer;
@property AVPlayerLayer *videoPlayerLayer;
@property AVPlayerItem *playerItem;
@property AVPlayer *videoPlayer;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self viewWillAppear:YES];
    [self makeScrollView];
    
    [self prepareMakeMovie];
}

- (void)prepareMakeMovie{
    //anims1をanimateするviewをインスタンス化
    CGRect rect = CGRectMake(0, 0, self.screenH, self.screenW);
    self.imageViewAnims1 = [[UIImageView alloc]initWithFrame:rect];
    NSMutableArray *anims1 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 59; i++) {
        UIImage *tempImgAnims1 = [UIImage imageNamed:[NSString stringWithFormat:@"anims1_%03d.png",i]];
        [anims1 addObject:tempImgAnims1];
    }
    self.imageViewAnims1.animationImages = anims1;
    [self.view addSubview:self.imageViewAnims1];
    NSLog(@"%@", [self.imageViewAnims1.animationImages objectAtIndex:0]);
    
    //anims2をanimateするviewをインスタンス化
    self.imageViewAnims2 = [[UIImageView alloc]initWithFrame:rect];
    NSMutableArray *anims2 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 14; i++) {
        UIImage *tempImgAnims2 = [UIImage imageNamed:[NSString stringWithFormat:@"anims2_%03d.png",i]];
        [anims2 addObject:tempImgAnims2];
    }
    self.imageViewAnims2.animationImages = anims2;
    [self.view addSubview:self.imageViewAnims2];
    NSLog(@"%@", [self.imageViewAnims2.animationImages objectAtIndex:0]);
}

- (void)makeMovie{

    self.imageViewAnims1.animationDuration = 0;
    self.imageViewAnims1.animationRepeatCount = 1;
    
    self.imageViewAnims2.animationDuration = 0;
    self.imageViewAnims2.animationRepeatCount = 0;
    
    [UIView animateWithDuration:3.0f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void)
    {
        NSLog(@"startAnimation");
        [self.imageViewAnims1 startAnimating];
        NSLog(@"anims1");
    }
                     completion:^(BOOL finished)
        {
            NSLog(@"anims finish");
            [UIView animateWithDuration:3.0f
                                  delay:4.0f
                                options:UIViewAnimationOptionAllowUserInteraction
                             animations:^(void)
             {
                 [self.imageViewAnims2 startAnimating];
                 NSLog(@"anims2");
             }
                             completion:^(BOOL finished){}
             ];
        }
     ];
    
//    self.playerItem = [[[AVPlayerItem alloc] initWithURL:self.videoUrl] autorelease];
//    [self.playerItem addObserver:self
//                      forKeyPath:kStatusKey
//                         options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
//                         context:AVPlayerViewControllerStatusObservationContext];
//    
//    // 終了通知
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(playerDidPlayToEndTime:)
//                                                 name:AVPlayerItemDidPlayToEndTimeNotification
//                                               object:self.playerItem];
//    
//    self.videoPlayer = [[[AVPlayer alloc] initWithPlayerItem:self.playerItem] autorelease];
//    
//    AVPlayerLayer* layer = ( AVPlayerLayer* )self.videoPlayerView.layer;
//    layer.videoGravity = AVLayerVideoGravityResizeAspect;
//    layer.player       = self.videoPlayer;
    
//    NSString *URL = [[NSBundle mainBundle] pathForResource:@"001" ofType:@"mov"];
//    self.player = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:URL]];
//    
//    self.playLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    self.playLayer.frame = self.view.frame;
//    [self.view.layer addSublayer:self.playLayer];
//    [self.playLayer addObserver:self forKeyPath:@"readyForDisplay" options:NSKeyValueObservingOptionNew context:NULL];

//    CGRect rect = CGRectMake(0, 0, self.screenH, self.screenW);
//    self.player.view.frame = rect;
//    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
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
    NSLog(@"scrolled: %f, %f", x, y);
    
    
    if (x == 240) {
        [self mophSequence];
    }

}

- (void)mophSequence
{
    [self makeMovie];
    NSLog(@"morph!");
//    [self.player play];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end