//
//  DetailViewController.h
//  Week 8
//
//  Created by 김기범 on 2016. 4. 20..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <NSStreamDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

