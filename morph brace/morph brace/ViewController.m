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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"prepare");
    
    
    // UIself.scrollViewのインスタンスを生成
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    // UIself.scrollViewのDelegateにself（ViewController）を設定
    self.scrollView.delegate = self;
    
    // コンテンツサイズをスクロールビューの表示領域より大きい値に設定する（値は適当）
    self.scrollView.contentSize = CGSizeMake(2000.0f, 2000.0f);
    
    // ズームスケールの最大・最小値を設定
    self.scrollView.maximumZoomScale = 2.0f;
    self.scrollView.minimumZoomScale = 0.5f;
    self.scrollView.maximumZoomScale = 2.0f;
    self.scrollView.minimumZoomScale = 0.5f;
    
    // 背景色にスクロールビューテクスチャを設定した矩形を配置
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2000.0f, 2000.0f)];
    aView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    [self.scrollView addSubview:aView];
    
    // UISwipeGestureRecognizerインスタンスを生成
    // スワイプが実行されたときに- swiped:メソッドを実行する
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(swiped:)];
    
    // 上方向のスワイプを検知する
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    
    // スワイプが失敗するまでパン（ドラッグ）を実行しない！
    [self.scrollView.panGestureRecognizer requireGestureRecognizerToFail:swipeGestureRecognizer];
    
    // スクロールビューにスワイプジェスチャーを登録
    [self.scrollView addGestureRecognizer:swipeGestureRecognizer];
    
    // ２本指でスワイプされたときに動作するようにする
    swipeGestureRecognizer.numberOfTouchesRequired = 2;
    
    // 上方向のスワイプを検知する
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    
    // スクロールビューにスワイプジェスチャーを登録
    [self.scrollView addGestureRecognizer:swipeGestureRecognizer];
    
    // ビューにself.scrollViewを追加
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    // - viewDidLoadメソッドで生成したaViewが返る
    return [[self.scrollView subviews] objectAtIndex:0];
}

// スワイプジェスチャーを検知したときに呼ばれるメソッド
- (void)swiped:(UISwipeGestureRecognizer *)sender
{
    // スワイプされたらログ出力
    NSLog(@"swiped!!");
}


@end
