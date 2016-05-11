//
//  ViewController.m
//  Week 11-1
//
//  Created by 김기범 on 2016. 5. 9..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sqlite3 *db;
    
    [self databasePathInit];
    
    BOOL openDatabaseResult = sqlite3_open([_databasePath UTF8String], &db);
    if(openDatabaseResult == SQLITE_OK) {
        fprintf(stderr, "Open database successfully\n");
    } else {
        fprintf(stderr, "Can't open database: %s\n", sqlite3_errmsg(db));
        exit(0);
    }
    
    sqlite3_stmt *statement;
    BOOL selectResult = sqlite3_prepare_v2(db, "SELECT * FROM tbl_songs", -1, &statement, NULL);
    if(selectResult == SQLITE_OK) {
        while (sqlite3_step(statement) <= SQLITE_ROW) {
            int id = sqlite3_column_int(statement, 0);
            if(id == 0) continue;
            NSString *title = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(statement, 1)];
            NSLog(@"%@",title);
        }
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(db);
}


- (void)databasePathInit {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _documentsDirectory = paths[0];
    _databasePath = [_documentsDirectory stringByAppendingPathComponent:@"top25.db"];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:_databasePath]) {
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"top25.db"];
        NSError *error;
        [[NSFileManager defaultManager]  copyItemAtPath:sourcePath toPath:_databasePath error:&error];
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
