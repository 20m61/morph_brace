//
//  braceViewController.m
//  morph_blass
//
//  Created by ゆかいなおじさん.com on 13/02/25.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "braceViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface braceViewController (){
    AVAudioPlayer *braceToBeleSound01;
    AVAudioPlayer *braceToBeltSound02;
    AVAudioPlayer *braceToBeltSound03;
    AVAudioPlayer *beltToBraceSound;
}
@property UIScrollView *braceScrollView;
@property UIImageView *braceScrollImageView;
@end

@implementation braceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    //status barを表示
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
    
    //スクロールバー初期化メソッドを実行
    [self initBraceScrollVIew];
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    if(interfaceOrientation == UIInterfaceOrientationPortrait){
        NSLog(@"縦(ホームボタン下)");
    }
    else if(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        NSLog(@"縦(ホームボタン上)");
    }
    else if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft){
        NSLog(@"縦(ホームボタン右)");
        [braceToBeltSound02 play];
        braceToBeltSound02.numberOfLoops = -1;
    }
    else if(interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        NSLog(@"縦(ホームボタン左)");
        [braceToBeltSound02 play];
        braceToBeltSound02.numberOfLoops = -1;
    }
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
    //braceScrollVIewがページの端でピタっとなるように
    self.braceScrollView.pagingEnabled = YES;
    //デリゲートを設定
    self.braceScrollView.delegate = self;
    //braceScrollVIewをviewに追加
    [self.view addSubview:self.braceScrollView];
    
    //braceScrollImageVIew初期化メソッドを実行
    [self initBraceScrollImageView];
    
    //sound初期化メソッドを実行
    [self initSounds];
}

//braceScrollImageVIewのインスタンスを生成してbraceScrollVIewへ追加
- (void)initBraceScrollImageView{
    //braceScrollImageVIewを初期化
    self.braceScrollImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.height/2*3, self.view.bounds.size.width)];
    //UIbrace.pngをbraceScrollImageViewにのせる
    self.braceScrollImageView.image = [UIImage imageNamed:@"UIbrace.png"];
    
    //braceScrollViewに追加
    [self.braceScrollView addSubview:self.braceScrollImageView];
}

//音源を初期化
- (void)initSounds{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"braceToBelt01" ofType:@"wav"];
    NSURL *braceToBeleSound01URL = [NSURL fileURLWithPath:path];
    braceToBeleSound01 = [[AVAudioPlayer alloc] initWithContentsOfURL:braceToBeleSound01URL error:nil];
    
    NSString *braceToBeltSound02Path = [[NSBundle mainBundle] pathForResource:@"braceToBelt02" ofType:@"wav"];
    NSURL *braceToBeltSound02URL = [NSURL fileURLWithPath:braceToBeltSound02Path];
    braceToBeltSound02 = [[AVAudioPlayer alloc] initWithContentsOfURL:braceToBeltSound02URL error:nil];
    
    
    NSString *braceToBeltSound03Path = [[NSBundle mainBundle] pathForResource:@"braceToBelt03" ofType:@"mp3"];
    NSURL *braceToBeltSound03URL = [NSURL fileURLWithPath:braceToBeltSound03Path];
    braceToBeltSound03 = [[AVAudioPlayer alloc] initWithContentsOfURL:braceToBeltSound03URL error:nil];
    
    NSString *beltToBraceSounPath = [[NSBundle mainBundle] pathForResource:@"beltToBrace" ofType:@"wav"];
    NSURL *beltToBraceSoundURL = [NSURL fileURLWithPath:beltToBraceSounPath];
    beltToBraceSound = [[AVAudioPlayer alloc] initWithContentsOfURL:beltToBraceSoundURL error:nil];
}

//スクロールされきったときに実行
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.braceScrollView.contentOffset.x > self.view.bounds.size.height/2) {
        
        //braceToBeleSound01を実行
        [braceToBeleSound01 play];
        
        //braceToBeltSegueをcall
        [self performSegueWithIdentifier:@"braceToBeltSegue" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
