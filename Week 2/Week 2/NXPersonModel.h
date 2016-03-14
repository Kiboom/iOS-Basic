//
//  NXPersonModel.h
//  Week2
//
//  Created by 김기범 on 2016. 3. 9..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXPersonModel : NSObject

@property NSMutableArray * persons;
@property NSMutableDictionary * person;

/* person을 Dictionary로 만드는게 아니라, 아예 객체로 만들어보자! */
/* person 객체 만들 때 isEqual 메서드도 구현하기! */


- (id)initWithDataPath:(NSString*)path;
- (NSString *)personNameAtIndex:(int)index;
- (NSNumber *)personNumberAtIndex:(int)index;
- (BOOL)isMaleAtIndex:(int)index;
- (NSNumber *)personTeamAtIndex:(int)index;
- (NSDictionary *)getPersonObjectAtIndex:(int)index;

- (NSString*) findPersonNameByNumber:(NSNumber*)number;
- (NSNumber*) findPersonNumberByName:(NSString*)name;

- (NSArray*) sortedByName;
- (NSArray*) sortedByNumber;
- (NSArray*) sortedByTeam;
- (NSString *) getNamesWithSort;

- (NSArray*) filterByTeam:(NSNumber*)team;
- (NSArray*) filterByGender:(BOOL)isMale;
- (NSArray*) filterDistinctByLastName;

@end
