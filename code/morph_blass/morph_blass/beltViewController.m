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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSMutableArray *braceToBeltAnimation01 = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 59; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"anims1_%03d.png",i]];
        [braceToBeltAnimation01 addObject:img];
    }
    self.beltViewMainImageView.animationImages = braceToBeltAnimation01;
    self.beltViewMainImageView.animationRepeatCount = 1;
    
    [self.beltViewMainImageView startAnimating];
    
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewwillappear");

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
