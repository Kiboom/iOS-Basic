//
//  MasterViewController.h
//  MidTerm
//
//  Created by 김기범 on 2016. 4. 11..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "KBDataModel.h"
#import "KBTableViewCell.h"

@class KBDetailViewController;

@interface KBAlbumViewController : UITableViewController

@property (strong, nonatomic) KBDetailViewController *detailViewController;
@property KBDataModel *model;
@property NSNotificationCenter *notiCenter;

@end

