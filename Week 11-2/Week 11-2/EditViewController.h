//
//  EditViewController.h
//  Week 11-2
//
//  Created by 김기범 on 2016. 5. 11..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DataManager.h"

@interface EditViewController : UIViewController

@property NSManagedObjectContext *context;

@property NSString *name;
@property NSString *ID;
@property BOOL gender;
@property NSUInteger grade;

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *idField;
@property (strong, nonatomic) IBOutlet UISwitch *genderField;
@property (strong, nonatomic) IBOutlet UITextField *gradeField;

- (IBAction)didNameEdit:(id)sender;
- (IBAction)didIDEdit:(id)sender;
- (IBAction)didGenderEdit:(id)sender;
- (IBAction)didGradeEdit:(id)sender;

- (IBAction)didAddTouch:(id)sender;
@end
