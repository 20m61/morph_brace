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

@interface ViewController()
//画面サイズを合わせるためのプロパティ
@property float screenW;
@property float screenH;
@property CGRect screenSizeRect;
//usualのscrollview
@property UIScrollView *usualScrollView;
//belt
@property UIView *beltView;
@property UIView *beltTouchView;
//mophingのためのimageView
@property UIImageView *imageViewAnims1;
@property UIImageView *imageViewAnims2;
@property UIImageView *imageViewAnims3;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self viewWillAppear:YES]; //prepare
    [self usualView]; //usual
    [self prepareMophingUsualToBelt]; //mophing
}

#pragma mark -prepare



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //スクリーンのサイズを取得
    self.screenW = [[UIScreen mainScreen] applicationFrame].size.width;  //幅
    self.screenH = [[UIScreen mainScreen] applicationFrame].size.height; //高さ
    self.screenSizeRect = CGRectMake(0, 0, self.screenH, self.screenW);
    //LOG
    NSLog(@"viewWillAppear%@", NSStringFromCGRect(self.screenSizeRect));
}

#pragma mark -usual views

- (void)usualView{
    
    // UIScrollViewのインスタンス化--------------------------------------------------
    self.usualScrollView = [[UIScrollView alloc]initWithFrame:self.screenSizeRect];
    //LOG
    NSLog(@"scrollView: %@", NSStringFromCGRect(self.usualScrollView.frame));
    // UIScrollViewのオプション設定
    self.usualScrollView.bounces = YES;
    self.usualScrollView.showsHorizontalScrollIndicator = NO;
    self.usualScrollView.pagingEnabled = YES;
    
    // UIImageView(scrollViewにのるimageView)のインスタンス化-------------------------
    CGRect usualImageViewSizeRect = CGRectMake(0, 0, self.screenH/2*3, self.screenW);
    UIImageView *usualImageView = [[UIImageView alloc]initWithFrame:usualImageViewSizeRect];
    //LOG
    NSLog(@"imageView: %@", NSStringFromCGRect(usualImageView.frame));
    // 画像を設定
    usualImageView.image = [UIImage imageNamed:@"UI.png"];
    
    // scrollViewにimageViewを追加-------------------------------------------------
    [self.usualScrollView addSubview:usualImageView];
    // scrollViewのコンテンツサイズをimageViewに合わせる
    self.usualScrollView.contentSize = usualImageView.bounds.size;
    
    // scrollViewをviewに追加------------------------------------------------------
    [self.view addSubview:self.usualScrollView];
    
    // scrollViewのdelegateメソッドを呼ぶ--------------------------------------------
    self.usualScrollView.delegate = self;
}

#pragma mark -usual views ivents

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
        [self morphUsualToBelt];
        [self hideScrollView];
        
    }
}

//scrollViewを透明に
- (void)hideScrollView{
    [UIView animateWithDuration:0.1f animations:^(void)
     {
         self.usualScrollView.alpha = .0f;
     }
     ];
}

#pragma mark -morphing

//変身シークエンスの実行
- (void)morphUsualToBelt
{
    [self makeMovie];
    NSLog(@"morph!");
    //    [self.player play];
}

//animateを表示する準備
- (void)prepareMophingUsualToBelt{
    //anims1をanimateするviewをインスタンス化
    self.imageViewAnims1 = [[UIImageView alloc]initWithFrame:self.screenSizeRect];
    NSMutableArray *anims1 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 59; i++) {
        UIImage *tempImgAnims1 = [UIImage imageNamed:[NSString stringWithFormat:@"anims1_%03d.png",i]];
        [anims1 addObject:tempImgAnims1];
    }
    self.imageViewAnims1.animationImages = anims1;
    [self.view addSubview:self.imageViewAnims1];
    NSLog(@"anims1-00->%@", [self.imageViewAnims1.animationImages objectAtIndex:0]);
    
    //anims2をanimateするviewをインスタンス化
    self.imageViewAnims2 = [[UIImageView alloc]initWithFrame:self.screenSizeRect];
    NSMutableArray *anims2 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 14; i++) {
        UIImage *tempImgAnims2 = [UIImage imageNamed:[NSString stringWithFormat:@"anims2_%03d.png",i]];
        [anims2 addObject:tempImgAnims2];
    }
    self.imageViewAnims2.animationImages = anims2;
    [self.view addSubview:self.imageViewAnims2];
    NSLog(@"anims2-00->%@", [self.imageViewAnims2.animationImages objectAtIndex:0]);
    
    //anims3をanimateするviewをインスタンス化
    self.imageViewAnims3 = [[UIImageView alloc]initWithFrame:self.screenSizeRect];
    NSMutableArray *anims3 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 30; i++) {
        UIImage *tempImgAnims3 = [UIImage imageNamed:[NSString stringWithFormat:@"anims3_%03d.png",i]];
        [anims3 addObject:tempImgAnims3];
    }
    self.imageViewAnims3.animationImages = anims3;
    [self.view addSubview:self.imageViewAnims3];
    NSLog(@"anims3-00->%@", [self.imageViewAnims3.animationImages objectAtIndex:0]);

    
    
}

//animateを実行
- (void)makeMovie{
    //anims1の設定
    self.imageViewAnims1.animationDuration = 0;
    self.imageViewAnims1.animationRepeatCount = 1;
    
    //anims2の設定
    self.imageViewAnims2.animationDuration = 0;
    self.imageViewAnims2.animationRepeatCount = 0;
    
    //anims3の設定
    self.imageViewAnims3.animationDuration = 0;
    self.imageViewAnims3.animationRepeatCount = 1;
    
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

#pragma mark -morphing ivents

//viewがタッチされ続けたときに実行（storyboad参照）
- (IBAction)beltTouchPoint:(id)sender {
    NSLog(@"belt touch!");
    [UIView animateWithDuration:.5f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void)
     {
         self.imageViewAnims2.alpha = .0f;
         [self.imageViewAnims3 startAnimating];
         NSLog(@"anims2");
     }
                     completion:^(BOOL finished)
    {
        [self.imageViewAnims2 stopAnimating];
        self.imageViewAnims1 = [[UIImageView alloc]init];
        self.imageViewAnims2 = [[UIImageView alloc]init];
        [self prepareBeltView];
        
    }
     ];
    
}

- (IBAction)beltTouchPointToUsualView:(id)sender {
    NSLog(@"swipe in beltView");
}

#pragma mark -belt mode views
- (void)prepareBeltView{
    //veltViewをインスタンス化
    self.beltView = [[UIView alloc]initWithFrame:self.screenSizeRect];
    //LOG
    NSLog(@"scrollView: %@", NSStringFromCGRect(self.usualScrollView.frame));
    
    UIImageView *imageViewBelt = [[UIImageView alloc]initWithFrame:self.screenSizeRect];
    //LOG
    NSLog(@"imageViewBelt: %@", NSStringFromCGRect(imageViewBelt.frame));
    // 画像を設定
    imageViewBelt.image = [UIImage imageNamed:@"UIBelt.png"];
    //beltViewに追加
    [self.beltView addSubview:imageViewBelt];
    NSLog(@"add pic on beltView");
    
    //タッチエリアを作成しbeltViewにのせる
    int H = self.screenH;
    CGRect box = CGRectMake((H-100), 0, 100, 100);
//    CGRect box = CGRectMake(0, 0, 200, 200);
    self.beltTouchView = [[UIView alloc]initWithFrame:box];
//    self.touchToUsualView.backgroundColor = [UIColor blackColor];
    [self.beltView addSubview:self.beltTouchView];
    NSLog(@"add touchToUsualView on beltView");
    NSLog(@"box rect size: %@", NSStringFromCGRect(box));
    
    NSLog(@"beltView's subview: %@", self.beltView);
    NSLog(@"touchToUsualView's superview: %@", self.beltTouchView.superview);


    // beltVIewのインスタンスをビューに追加
    [self.view addSubview:self.beltView];
    NSLog(@"visible veltView");
    
    [self prepareTouchToUsualViewAction];
}

#pragma mark -belt mode ivents
-(void)prepareTouchToUsualViewAction{
    UISwipeGestureRecognizer *touchToUsualViewAction = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(touchToUsualViewAction:)];
    touchToUsualViewAction.direction = UISwipeGestureRecognizerDirectionRight;
    [self.beltTouchView addGestureRecognizer: touchToUsualViewAction];
}

- (void)touchBeltToUsualViewAction:(UISwipeGestureRecognizer *)sender {
    NSLog(@"swipe right");
    
//    [UIView animateWithDuration:.5f
//                          delay:0.0f
//                        options:UIViewAnimationOptionAllowUserInteraction
//                     animations:^(void)
//     {
//         self.beltView.alpha = .0f;
//     }
//                     completion:^(BOOL finished)
//     {
    
    [self usualView];
    [self prepareMophingUsualToBelt];
    
//    [self.beltView removeFromSuperview];
    //    CGRect viewsize = CGRectMake(50, 50, 100, 100);
    //    self.view = [[UIView alloc]initWithFrame:self.screenSizeRect];
    //    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
//    NSLog(@"kill beltView");
//    NSLog(@"beltView: %@", NSStringFromCGRect(self.beltView.frame));
//     }
//     ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end