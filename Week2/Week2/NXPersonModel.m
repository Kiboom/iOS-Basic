//
//  NXPersonModel.m
//  Week2
//
//  Created by 김기범 on 2016. 3. 9..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "NXPersonModel.h"

@implementation NXPersonModel

@synthesize persons;
@synthesize person;

- (id)initWithDataPath:(NSString*)path{
    self = [super init];
    if(self){
        [self initializeData:path];
    }
    return self;
}


- (void)initializeData:(NSString*)path{
    NSString * dataString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSArray * separatedData = [dataString componentsSeparatedByString:@"\n"];
    
    person = [[NSMutableDictionary alloc] init];
    persons = [[NSMutableArray alloc] init];
    for (NSString * data in separatedData){
        NSArray * seperatedData = [data componentsSeparatedByString:@","];
        [person setObject:seperatedData[0] forKey:@"이름"];
        [person setObject:seperatedData[1] forKey:@"학번"];
        [person setObject:seperatedData[2] forKey:@"성별"];
        [person setObject:seperatedData[3] forKey:@"팀"];
        NSMutableDictionary * newDict = [[NSMutableDictionary alloc] initWithDictionary:person];
        [persons addObject:newDict];
    }
}



- (NSString *)personNameAtIndex:(int)index{
    NSString * name = [persons[index] objectForKey:@"이름"];
    NSLog(@"%@", name);
    return name;
}
/* valueForKey는 나중에 keyPath를 가지고 쓸 때 사용하는 메서드 */
/* 결과는 같지만 Dictionary에서는 objectForKey 메서드를 사용하자! */

/* NSMutableArray는 NSArray로부터 상속 받은 객체이므로, NSMutableArray는 NSArray로 넘길 수 있지만, */
/* 반대 방향으로는 안된다! NSArray를 Mutable하게 만드려면, 새로 Mutable을 alloc initWithArray를 하거나, mutableCopy라는 메서드를 쓰자!  */

- (NSNumber *)personNumberAtIndex:(int)index{
    NSNumber * number = [persons[index] objectForKey:@"학번"];
    NSLog(@"%@", number);
    return number;
}

- (BOOL)isMaleAtIndex:(int)index{
    NSString * gender = [persons[index] objectForKey:@"성별"];
    if([gender isEqualToString:@"M"]){
        NSLog(@"YES");
        return YES;
    }
    NSLog(@"NO");
    return NO;
}

- (NSNumber *)personTeamAtIndex:(int)index{
    NSNumber * number = [persons[index] objectForKey:@"팀"];
    NSLog(@"%@", number);
    return number;
}

- (NSDictionary *)getPersonObjectAtIndex:(int)index{
    NSLog(@"%@", persons[index]);
    return persons[index];
}


- (NSString*) findPersonNameByNumber:(NSNumber*)number{
    for(NSMutableDictionary * student in persons){
        NSString * stringNumber = [number stringValue] ;
        if([[student objectForKey:@"학번"] isEqualToString:stringNumber]){
            NSLog(@"%@", [student objectForKey:@"이름"]);
            return [student objectForKey:@"이름"];
        }
    }
    NSLog(@"찾는 사람이 없습니다");
    return nil;
}



- (NSNumber*) findPersonNumberByName:(NSString*)name{
    for(NSMutableDictionary* student in persons){
        if([[student objectForKey:@"이름"] isEqualToString:name]){
            NSLog(@"%@", [student objectForKey:@"학번"]);
            return [student objectForKey:@"학번"];
        }
    }
    NSLog(@"찾는 사람이 없습니다");
    return nil;
}


- (NSArray*) sortedByName{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"이름"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [persons sortedArrayUsingDescriptors:sortDescriptors];
    NSLog(@"%@",sortedArray);
    return sortedArray;
}


- (NSArray*) sortedByNumber{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"숫자"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [persons sortedArrayUsingDescriptors:sortDescriptors];
    NSLog(@"%@",sortedArray);
    return sortedArray;
}


- (NSArray*) sortedByTeam{
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"팀"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [persons sortedArrayUsingDescriptors:sortDescriptors];
    NSLog(@"%@",sortedArray);
    return sortedArray;
}

- (NSString *) getNamesWithSort {
    NSArray * sortResult = [self sortedByNumber];
    NSMutableString * nameString = [[NSMutableString alloc] init];
    for(NSDictionary * data in sortResult){
        [nameString appendString:[data objectForKey:@"이름"]];
        [nameString appendString:@", "];
    }
    return [nameString substringToIndex:[nameString length]-2];
}


- (NSArray*) filterByTeam:(NSNumber*)team{
    NSPredicate *predicateString = [NSPredicate predicateWithFormat: @"%K == %@", @"팀", [team stringValue]];
    NSLog(@"%@",[persons filteredArrayUsingPredicate:predicateString]);
    return [persons filteredArrayUsingPredicate:predicateString];
}

- (NSArray*) filterByGender:(BOOL)isMale{
    NSString * gender;
    if(isMale){
        gender = @"M";
    }
    else {
        gender = @"F";
    }
    
    NSPredicate *predicateString = [NSPredicate predicateWithFormat: @"%K == %@", @"성별", gender];
    NSLog(@"%@",[persons filteredArrayUsingPredicate:predicateString]);
    return [persons filteredArrayUsingPredicate:predicateString];
}

- (NSArray*) filterDistinctByLastName{
    NSMutableArray * names = [[NSMutableArray alloc] init];
    for(NSMutableDictionary * data in persons){
        [names addObject:[[data objectForKey:@"이름"] substringToIndex:1]];
    }
    names = [[[NSSet setWithArray:names] allObjects] mutableCopy];
    NSLog(@"%@",names);
    return persons;
}

@end
