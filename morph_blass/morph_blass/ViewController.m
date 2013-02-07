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
//画面サイズを合わせるためのプロパティ
@property float viewWidthSize;
@property float viewHeightSize;
@property float screenW;
@property float screenH;
@property CGRect rect;
//animationのためのimageView
@property UIImageView *imageViewAnims1;
@property UIImageView *imageViewAnims2;

@property UIScrollView *scrollView;
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

#pragma mark -prepare

-(void)viewWillAppear:(BOOL)animated{
    //スクリーンのサイズを取得
    self.screenW = [[UIScreen mainScreen] applicationFrame].size.width;  //幅
    self.screenH = [[UIScreen mainScreen] applicationFrame].size.height; //高さ
    self.rect = CGRectMake(0, 0, self.screenH, self.screenW);
    //LOG
    NSLog(@"viewWillAppear%@", NSStringFromCGRect(self.rect));
}

#pragma mark -usuary views

- (void)makeScrollView{
    
    // UIScrollViewのインスタンス化
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.rect];
    //LOG
    NSLog(@"scrollView: %@", NSStringFromCGRect(self.scrollView.frame));
    
    // UIScrollViewのオプション設定
    self.scrollView.bounces = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    
    // UIImageViewのインスタンス化
    // サンプルとして画面に収まりきらないサイズ
    CGRect rect2 = CGRectMake(0, 0, self.screenH/2*3, self.screenW);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect2];
    //LOG
    NSLog(@"imageView: %@", NSStringFromCGRect(imageView.frame));
    
    // 画像を設定
    imageView.image = [UIImage imageNamed:@"UI.png"];
    
    // UIScrollViewのインスタンスに画像を貼付ける
    [self.scrollView addSubview:imageView];
    
    // UIScrollViewのコンテンツサイズを画像のサイズに合わせる
    self.scrollView.contentSize = imageView.bounds.size;
    
    // UIScrollViewのインスタンスをビューに追加
    [self.view addSubview:self.scrollView];
    
    //UIScrollViewのdeligateメソッドを呼ぶ
    self.scrollView.delegate = self;
}

#pragma mark -usualy views ivent

//scrollViewがスクロールされているときに実行
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float x = scrollView.contentOffset.x;
    float y = scrollView.contentOffset.y;
    NSLog(@"scrolling: %f, %f", x, y);
}

//scrollViewがスクロールされ終わったときに実行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float x = scrollView.contentOffset.x;
    float y = scrollView.contentOffset.y;
    NSLog(@"scrolled: %f, %f", x, y);
    
    if (x == (self.screenH/2)) {
        [self mophSequence];
        [self hideScrollView];
        
    }
}

//scrollViewを透明に
- (void)hideScrollView{
    [UIView animateWithDuration:0.1f animations:^(void)
     {
         self.scrollView.alpha = .0f;
     }
     ];
}

#pragma mark -morph sequence

//変身シークエンスの実行
- (void)mophSequence
{
    [self makeMovie];
    NSLog(@"morph!");
    //    [self.player play];
}

//animateを表示する準備
- (void)prepareMakeMovie{
    //anims1をanimateするviewをインスタンス化
    self.imageViewAnims1 = [[UIImageView alloc]initWithFrame:self.rect];
    NSMutableArray *anims1 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 59; i++) {
        UIImage *tempImgAnims1 = [UIImage imageNamed:[NSString stringWithFormat:@"anims1_%03d.png",i]];
        [anims1 addObject:tempImgAnims1];
    }
    self.imageViewAnims1.animationImages = anims1;
    [self.view addSubview:self.imageViewAnims1];
    NSLog(@"anims1-00->%@", [self.imageViewAnims1.animationImages objectAtIndex:0]);
    
    //anims2をanimateするviewをインスタンス化
    self.imageViewAnims2 = [[UIImageView alloc]initWithFrame:self.rect];
    NSMutableArray *anims2 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 14; i++) {
        UIImage *tempImgAnims2 = [UIImage imageNamed:[NSString stringWithFormat:@"anims2_%03d.png",i]];
        [anims2 addObject:tempImgAnims2];
    }
    self.imageViewAnims2.animationImages = anims2;
    [self.view addSubview:self.imageViewAnims2];
    NSLog(@"anims2-00->%@", [self.imageViewAnims2.animationImages objectAtIndex:0]);
}

//animateを実行
- (void)makeMovie{
    //anims1の設定
    self.imageViewAnims1.animationDuration = 0;
    self.imageViewAnims1.animationRepeatCount = 1;
    
    //anims2の設定
    self.imageViewAnims2.animationDuration = 0;
    self.imageViewAnims2.animationRepeatCount = 0;
    
    //animateの実行
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
}

#pragma mark -morph sequence ivent
- (IBAction)beltTouchPoint:(id)sender {
    NSLog(@"belt touch!");
    [self.imageViewAnims2 stopAnimating];
}

#pragma mark -belt mode views

#pragma mark -belt mode ivent



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end