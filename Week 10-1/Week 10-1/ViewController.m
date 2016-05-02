//
//  ViewController.m
//  Week 10-1
//
//  Created by 김기범 on 2016. 5. 2..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _checkRecognizer = [[CheckmarkGestureRecognizer alloc] initWithTarget:self action:@selector(respondsToGesture:)];
    [self.view addGestureRecognizer:_checkRecognizer];
    
    // delays~ 요거 안해주면 색깔 바꾸는 gesture를 인식 못함!
    _checkRecognizer.delaysTouchesBegan = NO;
    _checkRecognizer.delaysTouchesEnded = NO;
}

- (void)respondsToGesture:(CheckmarkGestureRecognizer *)recognizer {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Checkmark"
                                                                   message:@"체크가 감지되었습니다."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
