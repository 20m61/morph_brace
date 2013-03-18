//
//  braceToBeltViewController.m
//  morphing
//
//  Created by ゆかいなおじさん.com on 13/03/07.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "braceToBeltViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface braceToBeltViewController (){
    AVAudioPlayer *animeSound001;
    NSMutableArray *anime001;
    AVAudioPlayer *animeSound002;
    NSMutableArray *anime002;
    AVAudioPlayer *animeSound003;
    NSMutableArray *anime003;
    AVAudioPlayer *animeSound004;
    NSMutableArray *anime004;
    AVAudioPlayer *animeSound005;
    NSMutableArray *anime005;
    
    int roteteCount;
}
@property UIImageView *imageView001;
@property UIImageView *imageView002;
@end

@implementation braceToBeltViewController

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
    
    //status barを非表示
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
    
    
    [self initImageView];
    [self setAnimates];
    [self setSounds];
    
    //viewcontrollerが表示されたときに再生するアニメ
    self.imageView001.alpha = 1.;
    self.imageView002.alpha = 0.;
    
    [self animation001];
    [UIView animateWithDuration:0.f
                          delay:1.f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^(void){
                         self.imageView001.alpha = 0.;
                         self.imageView002.alpha = 1.;
                     }
                     completion:^(BOOL finished){
                         [self animation002];                     }
     ];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{    
    roteteCount ++;
    if (roteteCount == 1) {
        
        self.imageView001.alpha = 1.;
        self.imageView002.alpha = 0.;
        
        [animeSound002 stop];
        [self.imageView002 stopAnimating];
        
        self.imageView002.animationImages = anime004;
        [self.imageView002 startAnimating];

        //viewcontrollerが表示されたときに再生するアニメ
       
        
        [self animation003];
//        self.imageView002.image = [UIImage imageWithContentsOfFile:@"000_221.pmg"];
        [UIView animateWithDuration:0.2f
                              delay:0.9f
                            options:UIViewAnimationCurveLinear
                         animations:^(void){
                             self.imageView001.alpha = 0.;
                             self.imageView002.alpha = 1.;
                         }
                         completion:^(BOOL finished){
                             [self animation004];
                             [self addButton];

                         }
         ];
    }
}

-(void)setAnimates{
    anime001 = [[NSMutableArray alloc]init];
    for (int i = 107; i <= 113; i++) {
        UIImage *anime001temp = [UIImage imageNamed:[NSString stringWithFormat:@"000_%03d.png",i]];
        [anime001 addObject:anime001temp];
    }
    
    anime002 = [[NSMutableArray alloc]init];
    for (int i = 114; i <= 119; i++) {
        UIImage *anime002temp = [UIImage imageNamed:[NSString stringWithFormat:@"000_%03d.png",i]];
        [anime002 addObject:anime002temp];
    }
    
    anime003 = [[NSMutableArray alloc]init];
    for (int i = 147; i <= 163; i++) {
        UIImage *anime003temp = [UIImage imageNamed:[NSString stringWithFormat:@"000_%03d.png",i]];
        [anime003 addObject:anime003temp];
    }
    
    anime004 = [[NSMutableArray alloc]init];
    for (int i = 190; i <= 221; i++) {
        UIImage *anime004temp = [UIImage imageNamed:[NSString stringWithFormat:@"000_%03d.png",i]];
        [anime004 addObject:anime004temp];
    }
    
    anime005 = [[NSMutableArray alloc]init];
    for (int i = 222; i <= 239; i++) {
        UIImage *anime005temp = [UIImage imageNamed:[NSString stringWithFormat:@"000_%03d.png",i]];
        [anime005 addObject:anime005temp];
    }
}

-(void)setSounds{
    NSString *animeSound001Path = [[NSBundle mainBundle] pathForResource:@"001" ofType:@"wav"];
    NSURL *animeSound001URL = [NSURL fileURLWithPath:animeSound001Path];
    animeSound001 = [[AVAudioPlayer alloc] initWithContentsOfURL:animeSound001URL error:nil];
    animeSound001.numberOfLoops = 0;
    
    NSString *animeSound002Path = [[NSBundle mainBundle] pathForResource:@"002" ofType:@"wav"];
    NSURL *animeSound002URL = [NSURL fileURLWithPath:animeSound002Path];
    animeSound002 = [[AVAudioPlayer alloc] initWithContentsOfURL:animeSound002URL error:nil];
    animeSound002.numberOfLoops = -1;

    
    NSString *animeSound003Path = [[NSBundle mainBundle] pathForResource:@"003" ofType:@"wav"];
    NSURL *animeSound003URL = [NSURL fileURLWithPath:animeSound003Path];
    animeSound003 = [[AVAudioPlayer alloc] initWithContentsOfURL:animeSound003URL error:nil];
    animeSound003.numberOfLoops = 0;
    
    NSString *animeSound004Path = [[NSBundle mainBundle] pathForResource:@"004" ofType:@"wav"];
    NSURL *animeSound004URL = [NSURL fileURLWithPath:animeSound004Path];
    animeSound004 = [[AVAudioPlayer alloc] initWithContentsOfURL:animeSound004URL error:nil];
    animeSound004.numberOfLoops = -1;
    
    
    NSString *animeSound005Path = [[NSBundle mainBundle] pathForResource:@"005" ofType:@"wav"];
    NSURL *animeSound005URL = [NSURL fileURLWithPath:animeSound005Path];
    animeSound005 = [[AVAudioPlayer alloc] initWithContentsOfURL:animeSound005URL error:nil];
    animeSound005.numberOfLoops = 0;

}

//braceImageVIewを初期化
- (void)initImageView{
    self.imageView001 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.height, self.view.bounds.size.width+20)];
    [self.view addSubview:self.imageView001];
    
    self.imageView002 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.height, self.view.bounds.size.width+20)];
    [self.view addSubview:self.imageView002];
}

//buttonを追加
- (void)addButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, self.view.bounds.size.height - 100, 100, 100);
    button.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [button addTarget:self
               action:@selector(toSegue:)
     forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

-(void)toSegue:(UIButton*)buttonn{
    NSLog(@"pushed");
    [self performSegueWithIdentifier:@"braceToBeltSegue02" sender:self];
}

-(void)animation001{
    //animationの設定
    self.imageView001.animationImages = anime001;
    self.imageView001.animationDuration = 1;
    self.imageView001.animationRepeatCount = 1;
    
    //アニメーションと音声を再生
    [self.imageView001 startAnimating];
    [animeSound003 play];
}

-(void)animation002{
    //animationの設定
    self.imageView002.animationImages = anime002;
    self.imageView002.animationDuration = 1/3;
    self.imageView002.animationRepeatCount = 0;
    
    //アニメーションと音声を再生
    [self.imageView002 startAnimating];
    [animeSound002 play];
}

-(void)animation003{
    //animationの設定
    self.imageView001.animationImages = anime003;
    self.imageView001.animationDuration = 1;
    self.imageView001.animationRepeatCount = 1;
    
    //アニメーションと音声を再生
    [self.imageView001 startAnimating];
    [animeSound003 play];
}

-(void)animation004{
    //animationの設定
    self.imageView002.animationImages = anime004;
    self.imageView002.animationDuration = 1;
    self.imageView002.animationRepeatCount = 0;
    
    //アニメーションと音声を再生
    [self.imageView002 startAnimating];
    [animeSound004 play];
}

-(void)animation005{
    //animationの設定
    self.imageView001.animationImages = anime005;
    self.imageView001.animationDuration = 1/3;
    self.imageView001.animationRepeatCount = 1;
    
    //アニメーションと音声を再生
    [self.imageView001 startAnimating];
    [animeSound005 play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
