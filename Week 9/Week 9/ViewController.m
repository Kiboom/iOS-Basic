//
//  ViewController.m
//  Week 9
//
//  Created by 김기범 on 2016. 4. 25..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)workingProgress {
    NSString *bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                             pathForResource:@"bookfile" ofType:@".txt"]  encoding:NSUTF8StringEncoding error:nil];
    int length = (int)bookfile.length;
    int spaceCount = 0;
    __block float progress = 0;
    unichar aChar;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    for (int nLoop=0; nLoop<length; nLoop++) {
        aChar = [bookfile characterAtIndex:nLoop];
        if (aChar==' '){
            spaceCount++;
            dispatch_sync(mainQueue, ^{
                progress = (float)nLoop / (float)length;
                _progressBar.progress = progress;
            });
        }
    }
    dispatch_sync(mainQueue, ^{
        [[[UIAlertView alloc] initWithTitle:@"완료"
                                    message:[NSString stringWithFormat:@"찾았다 %d개",spaceCount]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    });
}
      
- (IBAction)read:(id)sender {
    _progressBar.progress = 0;
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(aQueue, ^{
        [self workingProgress];
    });
}

- (IBAction)touched:(id)sender {
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.firstButton.backgroundColor = [UIColor yellowColor];
                         self.buttonTopConstraint.constant = 300;
                         self.buttonLeftConstraint.constant = self.view.frame.size.width-150;
                         self.buttonWidthConstraint.constant = 150;
                         self.buttonHeightConstraint.constant = 70;
                         self.firstButton.titleLabel.text = @"Clicked";
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:1.0
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              self.firstButton.backgroundColor = [UIColor whiteColor];
                                              self.buttonTopConstraint.constant = 50;
                                              self.buttonLeftConstraint.constant = 45;
                                              self.buttonWidthConstraint.constant = 100;
                                              self.buttonHeightConstraint.constant = 100;
                                              self.firstButton.titleLabel.text = @"Clicked";
                                              [self.view layoutIfNeeded];
                                          }
                                          completion:nil];
                     }];
}



@end
