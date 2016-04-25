//
//  ViewController.h
//  Week 9
//
//  Created by 김기범 on 2016. 4. 25..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *firstButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buttonTopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buttonLeftConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buttonWidthConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buttonHeightConstraint;
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;

- (IBAction)read:(id)sender;
- (IBAction)touched:(id)sender;
@end

