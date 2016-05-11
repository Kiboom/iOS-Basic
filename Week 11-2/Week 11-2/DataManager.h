//
//  DataManager.h
//  Week 11-2
//
//  Created by 김기범 on 2016. 5. 11..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface DataManager : NSObject

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedInstance;

- (NSUInteger)numberOfStudents;
- (void)addStudentWithID:(NSString *)ID Name:(NSString *)name Gender:(BOOL)isFemale Grade:(NSUInteger)grade;
- (NSDictionary *)studentAtIndex:(NSUInteger)index;

@end
