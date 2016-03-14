//
//  SecondViewController.m
//  Week 3-1
//
//  Created by 김기범 on 2016. 3. 14..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pm = [[NXPersonModel alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)findId:(id)sender {
    NSString * name = self.textField.text;
    NSString * number = [self.pm findPersonNumberByName:name];
    self.result.text = number;
}
- (IBAction)showNameList:(id)sender {
    NSString * nameList = [self.pm getNamesWithSort];
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"이름 목록" message:nameList preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
