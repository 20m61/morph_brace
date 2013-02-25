//
//  braceViewController.m
//  morph_blass
//
//  Created by ゆかいなおじさん.com on 13/02/20.
//  Copyright (c) 2013年 cnghwi. All rights reserved.
//

#import "braceViewController.h"

@interface braceViewController ()

@end

@implementation braceViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //braceScrollViewの位置・サイズを設定
    [self.braceScrollView setFrame:CGRectMake(self.view.bounds.origin.y, self.view.bounds.origin.x, self.view.bounds.size.height, 300)];
    //braceScrollImageViewの位置・サイズを設定
    [self.braceScrollViewImage setFrame:CGRectMake(self.view.bounds.origin.y, self.view.bounds.origin.x, self.view.bounds.size.height, 300)];
    //braceScrollViewのコンテンツサイズを設定
    [self.braceScrollView setContentSize:CGSizeMake(1000,300)];
    //braceScrollViewのスクロールを有効に
    [self.braceScrollView setScrollEnabled:YES];
        
    //デリゲート
    self.braceScrollView.delegate = self;
    
    NSLog(@"%@", NSStringFromCGRect([[UIScreen mainScreen] bounds]));
}

-(void)viewWillAppear:(BOOL)animated{
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)braceScrollView{
    if (self.braceScrollView.contentOffset.x >= self.braceMainView.frame.size.width/2) {
        
        //beltViewへ遷移するセグエを呼び出し
        [self performSegueWithIdentifier:@"braceToBeltSegue" sender:self];
        
    }
}

//遷移先の画面に情報を渡してあげる（propertyで）
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
