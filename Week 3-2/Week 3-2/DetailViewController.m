//
//  DetailViewController.m
//  Week 3-2
//
//  Created by 김기범 on 2016. 3. 16..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jsonModel = [[NXJsonModel alloc] init];
    [self setRandomImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setRandomImageView {
    NSDictionary *imageData = [self.jsonModel itemAtIndex:self.random];
    self.imageView.image = [UIImage imageNamed:[imageData objectForKey:@"image"]];
    self.imageTitle.text = [imageData objectForKey:@"title"];
}


@end
