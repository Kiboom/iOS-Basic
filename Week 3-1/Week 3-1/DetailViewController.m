//
//  DetailViewController.m
//  Week 3-1
//
//  Created by 김기범 on 2016. 3. 14..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    /* pushViewController에 대응하는 메서드. 모달로 떠있는 창을 내림. */
//     [self dismissViewControllerAnimated:YES completion:nil];
    /* presentViewController에 대응하는 메서드. 모달로 떠있는 창을 내림. */
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
