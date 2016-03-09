//
//  main.m
//  Week2
//
//  Created by 김기범 on 2016. 3. 9..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPersonModel.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NXPersonModel * pm = [[NXPersonModel alloc] initWithDataPath:@"/Users/Thomas/persons.txt"];
        
        [pm personNameAtIndex:1];
        [pm personNumberAtIndex:1];
        [pm isMaleAtIndex:1];
        [pm personTeamAtIndex:1];
        [pm getPersonObjectAtIndex:1];
        
        [pm findPersonNameByNumber:@141009];
        [pm findPersonNumberByName:@"김기범"];
        
        [pm sortedByName];
        [pm sortedByNumber];
        [pm sortedByTeam];
        
        [pm filterByTeam:@1];
        [pm filterByGender:YES];
        [pm filterDistinctByLastName];
        
    }
    return 0;
}
