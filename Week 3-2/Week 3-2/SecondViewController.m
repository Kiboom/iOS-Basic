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

@end
