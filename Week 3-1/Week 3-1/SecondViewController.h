//
//  SecondViewController.h
//  Week 3-1
//
//  Created by 김기범 on 2016. 3. 14..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NXPersonModel.h"

@interface SecondViewController : UIViewController

@property NXPersonModel * pm;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UILabel *result;

@end

