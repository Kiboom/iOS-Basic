//
//  FirstViewController.h
//  Week 3-2
//
//  Created by 김기범 on 2016. 3. 16..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)buttonClicked:(id)sender;


@end

