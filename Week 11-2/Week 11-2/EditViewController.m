//
//  EditViewController.m
//  Week 11-2
//
//  Created by 김기범 on 2016. 5. 11..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _gender = _genderField.on;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Core Data

//- (void)initCoreData {
//    NSError *error;
//    NSString *path = [];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didNameEdit:(id)sender {
    _name = _nameField.text;
    NSLog(@"%@",_name);
}

- (IBAction)didIDEdit:(id)sender {
    _ID = _idField.text;
    NSLog(@"%@",_ID);
}

- (IBAction)didGenderEdit:(id)sender {
    _gender = _genderField.on;
    NSLog(@"%d",_gender);
}

- (IBAction)didGradeEdit:(id)sender {
    _grade = [_gradeField.text intValue];
    NSLog(@"%lu",(unsigned long)_grade);
}

- (IBAction)didAddTouch:(id)sender {
    DataManager *dataManager = [DataManager sharedInstance];
    [dataManager addStudentWithID:_ID Name:_name Gender:_gender Grade:_grade];
}
@end
