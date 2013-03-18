//
//  braceViewController.m
//  morphing
//
//  Created by ゆかいなおじさん.com on 13/03/07.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "braceViewController.h"

@interface braceViewController ()
@property UIScrollView *braceScrollView;
@property UIImageView *braceScrollImageView;
@end

@implementation braceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //status barを表示
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
    
    //スクロールバー初期化メソッドを実行
    [self initBraceScrollVIew];
}

//braceScrollVIewのインスタンスを生成してviewへ追加
- (void)initBraceScrollVIew{
    //braceScrollVIewを初期化
    self.braceScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.height, self.view.bounds.size.width)];
    //braceScrollVIewのサイズを設定
    self.braceScrollView.contentSize = CGSizeMake(self.view.bounds.size.height/2*3, self.view.bounds.size.width);
    //braceScrollVIewをバウンスするように指定
    self.braceScrollView.bounces = YES;
    //水平方向のスクロールバーを非表示
    self.braceScrollView.showsHorizontalScrollIndicator = NO;
    //スクロールの開始位置
    self.braceScrollView.contentOffset = CGPointMake(self.view.bounds.origin.x + self.view.bounds.size.height/2, self.view.bounds.origin.y);
    //braceScrollVIewがページの端でピタっとなるように
    self.braceScrollView.pagingEnabled = YES;
    //デリゲートを設定
    self.braceScrollView.delegate = self;
    //braceScrollVIewをviewに追加
    [self.view addSubview:self.braceScrollView];
    
    //braceScrollImageVIew初期化メソッドを実行
    [self initBraceScrollImageView];
}

//braceScrollImageVIewのインスタンスを生成してbraceScrollVIewへ追加
- (void)initBraceScrollImageView{
    //braceScrollImageVIewを初期化
    self.braceScrollImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.height/2*3, self.view.bounds.size.width)];
    //UIbrace.pngをbraceScrollImageViewにのせる
    self.braceScrollImageView.image = [UIImage imageNamed:@"UIBrace.png"];
    
    //braceScrollViewに追加
    [self.braceScrollView addSubview:self.braceScrollImageView];
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    //Segueの特定
//    if ( [[segue identifier] isEqualToString:@"braceToBeltSegue01"] ) {
//        beltViewController *nextViewController = [segue destinationViewController];
//        //ここで遷移先ビューのクラスの変数receiveStringに値を渡している
//        nextViewController.segueDiscrimination = 1;
//    }
//}

//スクロールされきったときに実行
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%f", self.braceScrollView.contentOffset.x);
    if (self.braceScrollView.contentOffset.x == 0) {
    [self performSegueWithIdentifier:@"braceToBeltSegue01" sender:self];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
