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
@property UIView *mainView;
@property float viewWidthSize;
@property float viewHeightSize;
@property float screenW;
@property float screenH;
@property CGRect screenSizeRect;
//animationのためのimageView
@property UIImageView *imageViewAnims1;
@property UIImageView *imageViewAnims2;
@property UIImageView *imageViewAnims3;
//usually viewsのscrollview
@property UIScrollView *scrollView;
//belt vews
@property UIView *beltView;
@property UIView *touchToUsualView;
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
    self.screenSizeRect = CGRectMake(0, 0, self.screenH, self.screenW);
    //LOG
    NSLog(@"viewWillAppear%@", NSStringFromCGRect(self.screenSizeRect));
    
//    self.mainView = [[UIView alloc]initWithFrame:self.screenSizeRect];
//    [self.view addSubview:self.mainView];


}
    

#pragma mark -usual views

- (void)makeScrollView{
    
    // UIScrollViewのインスタンス化
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.screenSizeRect];
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
    
    //UIScrollViewのdelegateメソッドを呼ぶ
    self.scrollView.delegate = self;
}

#pragma mark -usual views ivent

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

#pragma mark -morph sequence ivent

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
    NSLog(@"scrollView: %@", NSStringFromCGRect(self.scrollView.frame));
    
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
    self.touchToUsualView = [[UIView alloc]initWithFrame:box];
//    self.touchToUsualView.backgroundColor = [UIColor blackColor];
    [self.beltView addSubview:self.touchToUsualView];
    NSLog(@"add touchToUsualView on beltView");
    NSLog(@"box rect size: %@", NSStringFromCGRect(box));
    
    NSLog(@"beltView's subview: %@", self.beltView);
    NSLog(@"touchToUsualView's superview: %@", self.touchToUsualView.superview);


    // beltVIewのインスタンスをビューに追加
    [self.view addSubview:self.beltView];
    NSLog(@"visible veltView");
    
    [self prepareTouchToUsualViewAction];
}

#pragma mark -belt mode ivent
-(void)prepareTouchToUsualViewAction{
    UISwipeGestureRecognizer *touchToUsualViewAction = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(touchToUsualViewAction:)];
    touchToUsualViewAction.direction = UISwipeGestureRecognizerDirectionRight;
    [self.touchToUsualView addGestureRecognizer: touchToUsualViewAction];
}

- (void)touchToUsualViewAction:(UISwipeGestureRecognizer *)sender {
    NSLog(@"swipe right");
    
    [UIView animateWithDuration:.5f
                          delay:0.0f
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^(void)
     {
         self.beltView.alpha = .0f;
         NSLog(@"kill beltView");
     }
                     completion:^(BOOL finished)
     {
         self.beltView = [[UIView alloc]init];
         self.scrollView = [[UIView alloc]init];
         [self makeScrollView];
         [self prepareMakeMovie];
         
     }
     ];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end