//
//  beltViewController.m
//  morph_blass
//
//  Created by ゆかいなおじさん.com on 13/02/20.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "beltViewController.h"

@interface beltViewController ()

@end

@implementation beltViewController

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
    
    NSMutableArray *braceToBeltAnimation01 = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 59; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"anims1_%03d.png",i]];
        [braceToBeltAnimation01 addObject:img];
    }
    self.braceToBeltAnimationView.animationImages = braceToBeltAnimation01;
    self.braceToBeltAnimationView.animationRepeatCount = 1;
    
    NSMutableArray *braceToBeltAnimation02 = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 14; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"anims2_%03d.png",i]];
        
        NSLog(@"%@", NSStringFromCGSize(img.size));
        
        [braceToBeltAnimation02 addObject:img];
    }
    self.braceToBeltAnimationView02.animationImages = braceToBeltAnimation02;
    self.braceToBeltAnimationView02.animationRepeatCount = 0;

    
    NSMutableArray *beltToBraceAnimation = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 29; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"anims3_%03d.png",i]];
        
        NSLog(@"%@", NSStringFromCGSize(img.size));
        
        [beltToBraceAnimation addObject:img];
    }
    self.beltToBraceAnimationView.animationImages = beltToBraceAnimation;
    self.beltToBraceAnimationView.animationRepeatCount = 0;

    
//    [UIView animateWithDuration:.0f
//                     animations:^(void){
//                         self.braceToBeltAnimationView02.alpha = 0.f;
//                         [self.braceToBeltAnimationView startAnimating];
//                     }
//                     completion:^(BOOL finished){
//                         self.braceToBeltAnimationView02.alpha = 1.f;
//                         [self.braceToBeltAnimationView02 startAnimating];
//                     }
//     ];
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewwillappear");
      // アニメーションを開始したい時に呼ぶ

}


- (IBAction)toBeltButton:(id)sender {
}

- (IBAction)toBraceButton:(id)sender {
    [self performSegueWithIdentifier:@"beltToBraceSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
