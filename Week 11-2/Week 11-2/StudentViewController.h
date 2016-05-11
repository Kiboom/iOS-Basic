//
//  StudentViewController.h
//  Week 11-2
//
//  Created by 김기범 on 2016. 5. 11..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DataManager.h"

@interface StudentViewController : UITableViewController

@property NSFetchedResultsController *fetchedResultsController;

@end
