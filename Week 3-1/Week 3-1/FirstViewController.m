//
//  FirstViewController.m
//  Week 3-1
//
//  Created by 김기범 on 2016. 3. 14..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_button setBackgroundColor:[UIColor redColor]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonTouched:(id)sender {
    DetailViewController * detailVC =
    [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    /* 스토리보드에서 특정 뷰 컨트롤러에 Identifier를 부여할 수 있따.
     우측 바에서 show the identity inspector 탭에 들어가서, 
     use storyboard id 버튼을 체크하고 id를 부여하면 된다. */
    [self.navigationController pushViewController:detailVC animated:YES];
    //[self presentViewController:detailVC animated:YES completion:nil];
    /* 스토리보드에서 세그웨이를 사용할 수도 있지만, 위와 같은 방식들로 코드로도 push를 실행할 수 있다. */
}
@end
