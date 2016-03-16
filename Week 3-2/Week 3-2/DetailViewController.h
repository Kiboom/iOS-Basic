//
//  DetailViewController.h
//  Week 3-2
//
//  Created by 김기범 on 2016. 3. 16..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NXJsonModel.h"

@interface DetailViewController : UIViewController

@property int random;
@property NXJsonModel *jsonModel;
@property (strong, nonatomic) IBOutlet UILabel *imageTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end