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
//usual
@property UIScrollView *usualScrollView;
//belt
@property UIView *beltView;
@property UIView *beltTouchView;
@property UIButton *beltTouchButton;

//mophing
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
    [self prepareUsualView]; //usual
    [self prepareMophing]; //mophing
    [self prepareBeltView]; //beltView
    [self prepareBeltTouchView]; //beltTouchView
    [self prepareIvents]; //ivents
    self.beltView.alpha = .0f;
}

#pragma mark -
#pragma mark === prepare  ===
#pragma mark
//viewが表示される直前に実行
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //スクリーンのサイズを取得
    self.screenW = [[UIScreen mainScreen] applicationFrame].size.width;  //幅
    self.screenH = [[UIScreen mainScreen] applicationFrame].size.height; //高さ
    self.screenSizeRect = CGRectMake(0, 0, self.screenH, self.screenW);
    //LOG
    NSLog(@"viewWillAppear%@", NSStringFromCGRect(self.screenSizeRect));
}

#pragma mark -
#pragma mark === usual  ===
#pragma mark
- (void)prepareUsualView{
    // UIScrollViewのインスタンス化--------------------------------------------------
    self.usualScrollView = [[UIScrollView alloc]initWithFrame:self.screenSizeRect];
    NSLog(@"scrollView: %@", NSStringFromCGRect(self.usualScrollView.frame));
    // UIScrollViewのオプション設定
    self.usualScrollView.bounces = YES;
    self.usualScrollView.showsHorizontalScrollIndicator = NO;
    self.usualScrollView.pagingEnabled = YES;
    
    // UIImageView(scrollViewにのるimageView)のインスタンス化-------------------------
    CGRect usualImageViewSizeRect = CGRectMake(0, 0, self.screenH/2*3, self.screenW);
    UIImageView *usualImageView = [[UIImageView alloc]initWithFrame:usualImageViewSizeRect];
    NSLog(@"imageView: %@", NSStringFromCGRect(usualImageView.frame));
    // 画像を設定
    usualImageView.image = [UIImage imageNamed:@"UIUsual.png"];
    
    // scrollViewにimageViewを追加-------------------------------------------------
    [self.usualScrollView addSubview:usualImageView];
    NSLog(@"add imageView on usualScrollView");
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
    self.beltView = [[UIView alloc]initWithFrame:self.screenSizeRect];
    NSLog(@"scrollView: %@", NSStringFromCGRect(self.usualScrollView.frame));
    
    // UIImageView(beltViewにのるimageView)のインスタンス化---------------------------
    UIImageView *beltImageView = [[UIImageView alloc]initWithFrame:self.screenSizeRect];
    NSLog(@"imageViewBelt: %@", NSStringFromCGRect(beltImageView.frame));
    // 画像を設定
    beltImageView.image = [UIImage imageNamed:@"UIBelt.png"];
    
    // UIViewにimageViewを追加------------------------------------------------------
    [self.beltView addSubview:beltImageView];
    NSLog(@"add imageView on beltView");
    
    // viewをbeltViewに追加---------------------------------------------------------
    [self.view addSubview:self.beltView];
    NSLog(@"visible veltView");
    
//    [self prepareTouchIventBeltToUsual];
}

//ベルトモードのON/OFFを操作するタッチエリア
- (void)prepareBeltTouchView{
    int H = self.screenH;
    CGRect box = CGRectMake((H-100), 0, 100, 100);
//    self.beltTouchView = [[UIView alloc]initWithFrame:box];
//    self.beltTouchView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.beltTouchView];
//    NSLog(@"add beltTouchView on view");
//    self.beltTouchView.alpha = .0f;
//    NSLog(@"beltTouchView invisible");
    
    self.beltTouchButton = [[UIButton alloc]initWithFrame:box];
    [self.beltTouchButton addTarget:self action:@selector(touchIventUsualToBelt:) forControlEvents:UIControlEventTouchDown];
    
    [self.beltTouchButton addTarget:self action:@selector(touchIventBeltToUsual:) forControlEvents:UIControlEventTouchUpOutside];
    
    [self.view addSubview:self.beltTouchButton];
}

#pragma mark -belt mode ivents//->touchIvent

#pragma mark -
#pragma mark === mophing  ===
#pragma mark
//mophingを表示する準備(各imageViewのインスタンスを生成)
- (void)prepareMophing{
    //anims1をanimateするviewをインスタンス化-----------------------------------------
    self.imageViewAnims1 = [[UIImageView alloc]initWithFrame:self.screenSizeRect];
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
    self.imageViewAnims2 = [[UIImageView alloc]initWithFrame:self.screenSizeRect];
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
    self.imageViewAnims3 = [[UIImageView alloc]initWithFrame:self.screenSizeRect];
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
}

//usualからbeltへ
- (void)morphingUsualToBelt
{
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
         //scrollViewを透明に
         self.usualScrollView.alpha = .0f;
         
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
    
    NSLog(@"morphing!: usual to belt");
}

//beltからusualへ
- (void)morphBeltToUsual
{
    
    NSLog(@"morphing!: belt to usual");
}

#pragma mark -morphing ivents//->touchIvent

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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //scrollViewのコンテンツ位置(scrollViewの中央でみている)
    float x = scrollView.contentOffset.x;
    float y = scrollView.contentOffset.y;
    NSLog(@"scrolling: %f, %f", x, y);
}

//scrollViewがスクロールされ終わったときに実行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //scrollViewのコンテンツ位置(scrollViewの中央でみている)
    float x = scrollView.contentOffset.x;
    float y = scrollView.contentOffset.y;
    NSLog(@"scrolled: %f, %f", x, y);
    
    //scrollViewのコンテンツ位置が画面の中央に来たときに実行
    if (x == (self.screenH/2)) {
        [self morphingUsualToBelt];
        
        //beltTouchViewを可視化
        self.beltTouchView.alpha = 1.0;
        NSLog(@"beltTouchView visible");
        
        //暫定
//        [self prepareTouchIventUsualToBelt];
    }
}

#pragma mark -touchIvents
- (void)prepareTouchIvents{
//    [self prepareTouchIventUsualToBelt];
//    [self prepareTouchIventBeltToUsual];
}

//longTouchをトリガーにしたイベント
//- (void)prepareTouchIventUsualToBelt{
//    UILongPressGestureRecognizer *touchToUsualViewAction = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(touchIventUsualToBelt:)];
//    // 指のズレを許容する範囲 10px
//    touchToUsualViewAction.allowableMovement = 100;
//    
//    // イベントが発生するまでタップする時間 0.8 秒
//    touchToUsualViewAction.minimumPressDuration = 0.5f;
//    // タップする回数 1回の場合は[0] 2回の場合は[1]を指定
//    touchToUsualViewAction.numberOfTapsRequired = 1;
//    // タップする指の数
//    touchToUsualViewAction.numberOfTouchesRequired = 1;
//    [self.beltTouchView addGestureRecognizer: touchToUsualViewAction];
//    NSLog(@"add touchToUsualViewAction on touchBeltToUsualView");
//    
//}

//mophingUsualToBelt
- (void)touchIventUsualToBelt:(UIButton *)beltTouchButton {
    NSLog(@"belt touch!");
    
    //anims2を透明にしてanims3を実行->beltViewの準備
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
         self.imageViewAnims3.alpha = .0f;
         self.beltTouchView.alpha = .0f;
         self.beltView.alpha = 1.0f;
         self.beltTouchView.alpha = 1.0f;
         NSLog(@"beltView visible");
     }
     ];
}


//右スワイプをトリガーにしたイベント
//-(void)prepareTouchIventBeltToUsual{
//    UISwipeGestureRecognizer *touchToUsualViewAction = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(touchIventBeltToUsual:)];
//    touchToUsualViewAction.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.beltTouchView addGestureRecognizer: touchToUsualViewAction];
//}

- (void)touchIventBeltToUsual:(UIButton *)beltTouchButton {
    NSLog(@"swipe right");
    
    //    CGPoint pt = [[touchToUsualViewAction anyObject] locationInView:self.beltView];
    //    if (CGRectContainsPoint(CGRectMake(0,0,100,100),pt)) {
    //        NSLog(@"あたり");
    //    }
    //    [UIView animateWithDuration:.5f
    //                          delay:0.0f
    //                        options:UIViewAnimationOptionAllowUserInteraction
    //                     animations:^(void)
    //     {
    //         self.beltView.alpha = .0f;
    //     }
    //                     completion:^(BOOL finished)
    //     {
    
    //beltVoiewを透明に
    self.beltView.alpha = .0f;
    self.beltTouchView.alpha = .0f;

    [self prepareUsualView];
    [self prepareMophing];
    
    //  [self.beltView removeFromSuperview];
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