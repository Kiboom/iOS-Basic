//
//  SecondViewController.m
//  Week 3-2
//
//  Created by 김기범 on 2016. 3. 16..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void) viewDidLoad {
    [super viewDidLoad];
}

 - (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     //세그웨이가 넘어가기 전에 불리는 애.
    if([segue.identifier isEqualToString:@"detailSegue"]){
        // 해당 세그웨이에게 identifier를 부여해서 isEqualToString의 인자값으로 넘기기.
        DetailViewController *detailVC = (DetailViewController*) segue.destinationViewController;
                                            //세그웨이가 가리키는 컨트롤러
        int random = [[[NSNumber alloc] initWithInt:(arc4random()%4)] intValue];
        detailVC.random = random;
    }
}

/* 세그웨이 대신 IBAction으로 구현할 때는 요렇게!
- (IBAction)randomButtonTouched:(id)sender {
    DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    // 여기에 다음 화면에 데이터 전달하는 코드 구현하기
    [self.navigationController pushViewController:detailVC animated:YES];
}
*/

@end
