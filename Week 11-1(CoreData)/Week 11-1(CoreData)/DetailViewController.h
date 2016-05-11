//
//  DetailViewController.h
//  Week 11-1(CoreData)
//
//  Created by 김기범 on 2016. 5. 9..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

