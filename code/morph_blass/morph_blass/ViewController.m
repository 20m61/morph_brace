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

@interface UIView ()
- (NSString *)recursiveDescription;

@end

@interface ViewController()
{
    //画面サイズ
    CGRect screenSizeRect;
}

//usual
@property UIScrollView *usualScrollView;
//belt
@property UIView *beltView;
@property UIButton *beltTouchButton;
//mophing
@property UIImageView *imageViewAnims1;
@property UIImageView *imageViewAnims2;
@property UIImageView *imageViewAnims3;
@property UIImageView *imageViewAnims4;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    screenSizeRect = CGRectMake(0, 0,[[UIScreen mainScreen] applicationFrame].size.height,[[UIScreen mainScreen] applicationFrame].size.width);
    [self viewWillAppear:YES]; //prepare
    [self resetToUsualView];
}

#pragma mark -
#pragma mark === prepare  ===
#pragma mark
- (void)resetToUsualView{
    [self prepareUsualView]; //usual
    [self prepareMophing]; //mophing
    [self prepareBeltView]; //beltView
    [self prepareBeltTouchButton]; //beltTouchView
    [self prepareIvents]; //ivents
    
    self.beltView.alpha = 0.0f; //beltViewを不可視化
    NSLog(@"veltView invisible");
    self.beltTouchButton.alpha = .0f; //beltTouchButtonを不可視化
    NSLog(@"veltTouchButton invisible");
    self.imageViewAnims1.alpha = .0f; //imageViewAnims1を不可視化
    NSLog(@"imageViewAnims1 invisible");
    self.imageViewAnims2.alpha = .0f; //imageViewAnims2を不可視化
    NSLog(@"imageViewAnims2 invisible");
    self.imageViewAnims3.alpha = .0f; //imageViewAnims3を不可視化
    NSLog(@"imageViewAnims3 invisible");
    
    NSLog(@"\n beltView.alpha: %f \n beltTouchButton.alpha: %f", self.beltView.alpha, self.beltTouchButton.alpha);
}

- (void)reset{
    
    self.usualScrollView.alpha = 1.f; //beltViewを不可視化
    NSLog(@"usualScrollView  %@", self.usualScrollView);
    self.beltView.alpha = .0f; //beltViewを不可視化
    NSLog(@"veltView %@", self.beltView);
    self.beltTouchButton.alpha = .0f; //beltTouchButtonを不可視化
    NSLog(@"veltTouchButton %@", self.beltTouchButton);
    self.imageViewAnims1.alpha = .0f; //imageViewAnims1を不可視化
    NSLog(@"imageViewAnims1 %@", self.imageViewAnims1);
    self.imageViewAnims2.alpha = .0f; //imageViewAnims2を不可視化
    NSLog(@"imageViewAnims2 %@", self.imageViewAnims2);
    self.imageViewAnims3.alpha = .0f; //imageViewAnims3を不可視化
    NSLog(@"imageViewAnims3 %@", self.imageViewAnims3);
    self.imageViewAnims4.alpha = .0f; //imageViewAnims3を不可視化
    NSLog(@"imageViewAnims4 %@", self.imageViewAnims4);

    
    NSLog(@"\n beltView.alpha: %f \n beltTouchButton.alpha: %f", self.beltView.alpha, self.beltTouchButton.alpha);
}

#pragma mark -
#pragma mark === usual  ===
#pragma mark
- (void)prepareUsualView{
    // UIScrollViewのインスタンス化--------------------------------------------------
    self.usualScrollView = [[UIScrollView alloc]initWithFrame:screenSizeRect];
    NSLog(@"usualScrollView: %@", NSStringFromCGRect(self.usualScrollView.frame));
    // UIScrollViewのオプション設定
    self.usualScrollView.bounces = YES;
    self.usualScrollView.showsHorizontalScrollIndicator = NO;
    self.usualScrollView.pagingEnabled = YES;
    
    // UIImageView(scrollViewにのるimageView)のインスタンス化-------------------------
    CGRect usualImageViewSizeRect = CGRectMake(0, 0, screenSizeRect.size.width/2*3, screenSizeRect.size.height);
    UIImageView *usualImageView = [[UIImageView alloc]initWithFrame:usualImageViewSizeRect];
    NSLog(@"usualImageView: %@", NSStringFromCGRect(usualImageView.frame));
    // 画像を設定
    usualImageView.image = [UIImage imageNamed:@"UIUsual.png"];
    
    // scrollViewにimageViewを追加-------------------------------------------------
    [self.usualScrollView addSubview:usualImageView];
    NSLog(@"add usualImageView on usualScrollView");
    // scrollViewのコンテンツサイズをimageViewに合わせる
    self.usualScrollView.contentSize = usualImageView.bounds.size;
    
    // scrollViewをviewに追加------------------------------------------------------
    [self.view addSubview:self.usualScrollView];
    NSLog(@"visible usualScrollView");
    
    // scrollViewのdelegateメソッドを呼ぶ--------------------------------------------
    self.usualScrollView.delegate = self;
}

#pragma mark -usual views ivents//->scrollIvents

#pragma mark -
#pragma mark === belt  ===
#pragma mark
- (void)prepareBeltView{
    // UIView(beltView)をインスタンス化----------------------------------------------
    self.beltView = [[UIView alloc]initWithFrame:screenSizeRect];
    NSLog(@"beltView: %@", NSStringFromCGRect(self.beltView.frame));
    
    // UIImageView(beltViewにのるimageView)のインスタンス化---------------------------
    UIImageView *beltImageView = [[UIImageView alloc]initWithFrame:screenSizeRect];
    NSLog(@"beltImageView: %@", NSStringFromCGRect(beltImageView.frame));
    // 画像を設定
    beltImageView.image = [UIImage imageNamed:@"UIBelt.png"];
    
    // UIViewにimageViewを追加------------------------------------------------------
    [self.beltView addSubview:beltImageView];
    NSLog(@"add beltImageView on beltView");
    
    // viewをbeltViewに追加---------------------------------------------------------
    [self.view addSubview:self.beltView];
    NSLog(@"visible veltView");
}

//ベルトモードのON/OFFを操作するタッチエリア
- (void)prepareBeltTouchButton{
    //beltTouchButtonの大きさを定義する四角形
    int H = screenSizeRect.size.width;
    CGRect box = CGRectMake((H-100), 0, 100, 100);
    
    //beltTouchButtonをインスタンス化
    self.beltTouchButton = [[UIButton alloc]initWithFrame:box];
    NSLog(@"beltTouchButton: %@", NSStringFromCGRect(self.beltTouchButton.frame));
    
    //beltTouchButtonが押されたときtouchIventUsualToBelt:を実行する
    [self.beltTouchButton addTarget:self action:@selector(touchIventUsualToBelt:) forControlEvents:UIControlEventTouchDown];
    //beltTouchButtonの範囲外でタッチを解除したときtouchIventBeltToUsual:を実行する
    [self.beltTouchButton addTarget:self action:@selector(touchIventBeltToUsual:) forControlEvents:UIControlEventTouchUpOutside];
    
    //viewへbeltTouchButtonを追加
    [self.view addSubview:self.beltTouchButton];
    NSLog(@"add beltTouchButton on view");
}

#pragma mark -belt mode ivents//->touchIvents

#pragma mark -
#pragma mark === mophing  ===
#pragma mark
//mophingを表示する準備(各imageViewのインスタンスを生成)
- (void)prepareMophing{
    //anims1をanimateするviewをインスタンス化-----------------------------------------
    self.imageViewAnims1 = [[UIImageView alloc]initWithFrame:screenSizeRect];
    NSMutableArray *anims1 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 59; i++) {
        UIImage *tempImgAnims1 = [UIImage imageNamed:[NSString stringWithFormat:@"anims1_%03d.png",i]];
        [anims1 addObject:tempImgAnims1];
    }
    self.imageViewAnims1.animationImages = anims1;
    [self.view addSubview:self.imageViewAnims1];
    NSLog(@"anims1-00->%@", [self.imageViewAnims1.animationImages objectAtIndex:0]);
    //設定
    self.imageViewAnims1.animationDuration = 0;
    self.imageViewAnims1.animationRepeatCount = 1;
    
    //anims2をanimateするviewをインスタンス化-----------------------------------------
    self.imageViewAnims2 = [[UIImageView alloc]initWithFrame:screenSizeRect];
    NSMutableArray *anims2 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 14; i++) {
        UIImage *tempImgAnims2 = [UIImage imageNamed:[NSString stringWithFormat:@"anims2_%03d.png",i]];
        [anims2 addObject:tempImgAnims2];
    }
    self.imageViewAnims2.animationImages = anims2;
    [self.view addSubview:self.imageViewAnims2];
    NSLog(@"anims2-00->%@", [self.imageViewAnims2.animationImages objectAtIndex:0]);
    //設定
    self.imageViewAnims2.animationDuration = 0;
    self.imageViewAnims2.animationRepeatCount = 0;
    
    //anims3をanimateするviewをインスタンス化-----------------------------------------
    self.imageViewAnims3 = [[UIImageView alloc]initWithFrame:screenSizeRect];
    NSMutableArray *anims3 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 30; i++) {
        UIImage *tempImgAnims3 = [UIImage imageNamed:[NSString stringWithFormat:@"anims3_%03d.png",i]];
        [anims3 addObject:tempImgAnims3];
    }
    self.imageViewAnims3.animationImages = anims3;
    [self.view addSubview:self.imageViewAnims3];
    NSLog(@"anims3-00->%@", [self.imageViewAnims3.animationImages objectAtIndex:0]);
    //設定
    self.imageViewAnims3.animationDuration = 0;
    self.imageViewAnims3.animationRepeatCount = 1;
    
    
    //anims4をanimateするviewをインスタンス化-----------------------------------------
    self.imageViewAnims4 = [[UIImageView alloc]initWithFrame:screenSizeRect];
    NSMutableArray *anims4 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 59; i++) {
        UIImage *tempImgAnims4 = [UIImage imageNamed:[NSString stringWithFormat:@"anims1_%03d.png",i]];
        [anims4 addObject:tempImgAnims4];
    }
    self.imageViewAnims4.animationImages = anims4;
    [self.view addSubview:self.imageViewAnims4];
    NSLog(@"anims3-00->%@", [self.imageViewAnims4.animationImages objectAtIndex:0]);
    //設定
    self.imageViewAnims4.animationDuration = 0;
    self.imageViewAnims4.animationRepeatCount = 1;
}

#pragma mark -play & stop methods

//animsの再生・停止メソッド
//anims1を可視化して再生-------------------------------
- (void)playAnims1{
self.imageViewAnims1.alpha = 1.0f;
[self.imageViewAnims1 startAnimating];
NSLog(@"play anims1");
}
//anims1を停止して不可視化
- (void)stopAnims1{
[self.imageViewAnims1 stopAnimating];
self.imageViewAnims1.alpha = .0f;
NSLog(@"stop anims1");
}
//anims2を可視化して再生-------------------------------
- (void)playAnims2{
    self.imageViewAnims2.alpha = 1.0f;
    [self.imageViewAnims2 startAnimating];
    NSLog(@"play anims2");
}
//anims2を停止して不可視化
- (void)stopAnims2{
    [self.imageViewAnims2 stopAnimating];
    self.imageViewAnims2.alpha = .0f;
    NSLog(@"stop anims2");
}
//anims3を可視化して再生-------------------------------
- (void)playAnims3{
    self.imageViewAnims3.alpha = 1.0f;
    [self.imageViewAnims3 startAnimating];
    NSLog(@"play anims3");
}
//anims3を停止して不可視化
- (void)stopAnims3{
    [self.imageViewAnims3 stopAnimating];
    self.imageViewAnims3.alpha = .0f;
    NSLog(@"stop anims3");
}
//anims4を可視化して再生-------------------------------
- (void)playAnims4{
    self.imageViewAnims4.alpha = 1.0f;
    [self.imageViewAnims4 startAnimating];
    NSLog(@"play anims4");
}
//anims4を停止して不可視化
- (void)stopAnims4{
    [self.imageViewAnims4 stopAnimating];
    self.imageViewAnims4.alpha = .0f;
    NSLog(@"stop anims4");
}

#pragma mark -morphing meyhods
//usualからmorphingへ
- (void)morphingUsualToBeltBeforeTouch
{
    //scrollViewを不可視化
    self.usualScrollView.alpha = .0f;
    NSLog(@"usualScrollView invisible");
    
    //animate
    [UIView animateWithDuration:2.f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void)
     {
         //anims1を可視化して再生
         [self playAnims1];
     }
                     completion:^(BOOL finished)
     {
         //anims1を停止して不可視化
         [self stopAnims1];
         
         [UIView animateWithDuration:.0f
                          animations:^(void)
          {
              //anims2を可視化して再生
              [self playAnims2];
              
              self.beltTouchButton.alpha = 1.0;
          }
                          completion:^(BOOL finished){}
          ];
     }
     ];
}

//morphingからbeltへ
- (void)morphingUsualToBeltAfterTouch
{
    //anims2を停止して不可視化
    [self stopAnims2];
    
    //animate
    [UIView animateWithDuration:.5f
                     animations:^(void)
     {
         //anims3を可視化して再生
         [self playAnims3];
     }
                     completion:^(BOOL finished)
     {
         //beltViewを可視化
         self.beltView.alpha = 1.0f;
         NSLog(@"beltView visible");
         
         //anims3を停止して不可視化
         [self stopAnims3];
     }
     ];
}

//beltからusualへ
- (void)morphingBeltToUsual
{
    
    
    //beltViewを不可視化
    self.beltView.alpha = .0f;
    //animate
    [UIView animateWithDuration:2.05f
                     animations:^(void)
     {
         //beltViewを不可視化
         self.beltView.alpha = .0f;

         //anims1を可視化して再生
         [self playAnims4];
     }
                     completion:^(BOOL finished)
     {
         //beltViewを不可視化
         self.beltView.alpha = .0f;
         
        //anims1を停止して不可視化
        [self stopAnims1];
        
        [self reset];
        NSLog(@"resetToUsualView");
    }];
}

#pragma mark -morphing ivents//->touchIvents

#pragma mark -
#pragma mark === ivents  ===
#pragma mark
- (void)prepareIvents{
    [self prepareScrollIvent];
    [self prepareTouchIvents];
}


#pragma mark -scrollIvents
- (void)prepareScrollIvent{
    
}

//scrollViewがスクロールされているときに実行
#if DETECT_SCROLL
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //scrollViewのコンテンツ位置(scrollViewの中央でみている)
    float x = scrollView.contentOffset.x;
    float y = scrollView.contentOffset.y;
    NSLog(@"scrolling: %f, %f", x, y);
}
#endif

//scrollViewがスクロールされ終わったときに実行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //scrollViewのコンテンツ位置(scrollViewのx軸の中央でみている)
    float x = scrollView.contentOffset.x;
    float y = scrollView.contentOffset.y;
    NSLog(@"scrolled: %f, %f", x, y);
    
    //scrollViewのコンテンツ位置が画面の中央に来たときに実行
    if (x == (screenSizeRect.size.width/2)) {
        [self morphingUsualToBeltBeforeTouch];
        NSLog(@"called morphingUsualToBeltBeforeTouch");
    }
}

#pragma mark -touchIvents
- (void)prepareTouchIvents{
    
}

//morphingUsualToBelt実行中にbeltTouchButtonにタッチした瞬間に実行
- (void)touchIventUsualToBelt:(UIButton *)beltTouchButton {
    NSLog(@"belt touch up!");
    [self morphingUsualToBeltAfterTouch];
    NSLog(@"called morphingUsualToBeltAfterTouch");
}

//beltTouchButtonの外でタッチを解除したときに実行
- (void)touchIventBeltToUsual:(UIButton *)beltTouchButton {
    NSLog(@"belt touch down outside!");
    
    [self morphingBeltToUsual];
    NSLog(@"%@", [self.view recursiveDescription]);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end