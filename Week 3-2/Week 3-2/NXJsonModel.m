//
//  NXJsonModel.m
//  Week 3-2
//
//  Created by 김기범 on 2016. 3. 16..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "NXJsonModel.h"

@implementation NXJsonModel

-(id)init{
    self = [super init];
    if(self){
        [self initializeJsonData];
    }
    return self;
}

- (void)initializeJsonData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"imageJson" ofType:@"txt"];
    NSString * jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    self.jsonArray = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:NULL];
}


- (NSDictionary *)itemAtIndex:(int)index{
    return self.jsonArray[index];
}

@end
