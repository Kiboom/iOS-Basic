//
//  DataManager.m
//  Week 11-2
//
//  Created by 김기범 on 2016. 5. 11..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "DataManager.h"


@implementation DataManager

+ (instancetype)sharedInstance {
    static DataManager *sharedDataManager = nil;
    @synchronized (self) {
        if(sharedDataManager==nil)
            sharedDataManager = [[DataManager alloc] init];
    }
    return sharedDataManager;
}


- (NSUInteger)numberOfStudents {
    return 0;
}


- (void)addStudentWithID:(NSString *)ID Name:(NSString *)name Gender:(BOOL)isFemale Grade:(NSUInteger)grade {
    NSManagedObjectContext *context = [[self fetchedResultsController] managedObjectContext];
    NSEntityDescription *entity = [[[self fetchedResultsController] fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    [newManagedObject setValue:ID forKey:@"id"];
    [newManagedObject setValue:name forKey:@"name"];
    [newManagedObject setValue:[NSNumber numberWithBool:isFemale] forKey:@"gender"];
    [newManagedObject setValue:[NSNumber numberWithUnsignedInteger:grade] forKey:@"grade"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


- (NSDictionary *)studentAtIndex:(NSUInteger)index {
    NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSDictionary *student = @{@"id":[object valueForKey:@"id"],
                                @"name":[object valueForKey:@"name"],
                                @"gender":[object valueForKey:@"gender"],
                                @"grade":[object valueForKey:@"grade"]};
    return student;
}



- (NSFetchedResultsController *)fetchedResultsController {
    if(!_managedObjectContext) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        _managedObjectContext = [appDelegate managedObjectContext];
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student"
                                              inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_managedObjectContext sectionNameKeyPath:nil cacheName:@"Student"];
    _fetchedResultsController = fetchedResultsController;
    
    NSError *error = nil;
    if(![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}


@end
