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
    //braceToBelt02(ループ再生)
    UIImage *braceToBeltImage02;
    AVAudioPlayer *braceToBeltSound02;
    //braceToBelt03(一度のみ再生)
    UIImage *braceToBeltImage03;
    AVAudioPlayer *braceToBeltSound03;
    //beltToBrace(一度のみ再生)
    UIImage *beltToBraceImage;
    AVAudioPlayer *beltToBraceSound;
}
@property UIImageView *beltImageView;

@end

@implementation beltViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //status barを非表示
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
    
    [self initBraceImageView];
}

- (void)viewWillAppear:(BOOL)animated{
    switch (self.segueDiscrimination) {
        //braceToBelt
        case 1:{
            NSMutableArray *braceToBeltImage02Array = [[NSMutableArray alloc]init];
            for (int i = 0; i < 14; i++) {
                UIImage *braceToBeltImage02temp = [UIImage imageNamed:[NSString stringWithFormat:@"anims2_%03d.png",i]];
                [braceToBeltImage02Array addObject:braceToBeltImage02temp];
            }
            self.beltImageView.animationImages = braceToBeltImage02Array;
            //設定
            self.beltImageView.animationDuration = 0;
            self.beltImageView.animationRepeatCount = 0;
            [self.beltImageView startAnimating];
    
            NSString *braceToBeltSound02Path = [[NSBundle mainBundle] pathForResource:@"braceToBelt02" ofType:@"wav"];
            NSURL *braceToBeltSound02URL = [NSURL fileURLWithPath:braceToBeltSound02Path];
            braceToBeltSound02 = [[AVAudioPlayer alloc] initWithContentsOfURL:braceToBeltSound02URL error:nil];
            braceToBeltSound02.numberOfLoops = -1;
            [braceToBeltSound02 play];
        }
            break;
            
        default:
            break;
    }
}


//braceImageVIewを初期化
- (void)initBraceImageView{
    self.beltImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.height, self.view.bounds.size.width+20)];
    self.beltImageView.image = [UIImage imageNamed:@"UIBelt.png"];
    [self.view addSubview:self.beltImageView];
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

//ベルトのボタンを押したときに実行
- (IBAction)beltTouchDown:(id)sender {
    [braceToBeltSound02 stop];
    [self.beltImageView stopAnimating];
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
