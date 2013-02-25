//
//  beltViewController.m
//  morph_blass
//
//  Created by ゆかいなおじさん.com on 13/02/25.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "beltViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface beltViewController (){
    AVAudioPlayer *braceToBeltSound02;
    AVAudioPlayer *braceToBeltSound03;
    AVAudioPlayer *beltToBraceSound;
}
@property UIImageView *braceImageView;

@end

@implementation beltViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //status barを非表示
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
    
    [self initBraceImageView];
    
    self.toBraceSegueButton.alpha = .0f;
    
    [self initSounds];
}


//braceImageVIewを初期化
- (void)initBraceImageView{
    self.braceImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.height, self.view.bounds.size.width+20)];
    self.braceImageView.image = [UIImage imageNamed:@"UIbelt.png"];
    [self.view addSubview:self.braceImageView];
}

//braceToBeltSegueから呼ぶアニメーション
- (void)braceToBeltAnimate{
    
}

//音源を初期化
- (void)initSounds{
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


- (IBAction)beltTouchDown:(id)sender {
    [braceToBeltSound02 stop];
    [braceToBeltSound03 play];

}

//ボタンを指定領域外で離すと実行
- (IBAction)beltTouchUpOutside:(id)sender {
    
    //beltToBraceSoundを再生
    [beltToBraceSound play];
    
    //beltToBraceSegueをcall
    [self performSegueWithIdentifier:@"beltToBraceSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}@end
