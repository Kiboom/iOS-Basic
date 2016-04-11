//
//  KBDataModel.h
//  MidTerm
//
//  Created by 김기범 on 2016. 4. 11..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBDataModel : NSObject

@property NSData *jsonData;
@property NSArray *datas;
@property NSMutableArray *years;
@property NSNotificationCenter *notiCenter;

- (void)initializeData;
- (void)sort;
- (NSArray *)getYearList;
- (int)getNumberElementInYear:(NSString *)year;

@end
