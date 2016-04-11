//
//  KBDataModel.m
//  MidTerm
//
//  Created by 김기범 on 2016. 4. 11..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "KBDataModel.h"

@implementation KBDataModel

- (id)init {
    self = [super init];
    if(self){
    }
    return self;
}

- (void)initializeData {
    char *data = "[{\"title\":\"초록\",\"image\":\"01.jpg\",\"date\":\"20150116\"},\{\"title\":\"장미\",\"image\":\"02.jpg\",\"date\":\"20160505\"},\{\"title\":\"낙엽\",\"image\":\"03.jpg\",\"date\":\"20141212\"},\{\"title\":\"계단\",\"image\":\"04.jpg\",\"date\":\"20140301\"},\{\"title\":\"벽돌\",\"image\":\"05.jpg\",\"date\":\"20150101\"},\{\"title\":\"바다\",\"image\":\"06.jpg\",\"date\":\"20150707\"},\{\"title\":\"벌레\",\"image\":\"07.jpg\",\"date\":\"20140815\"},\{\"title\":\"나무\",\"image\":\"08.jpg\",\"date\":\"20161231\"},\{\"title\":\"흑백\",\"image\":\"09.jpg\",\"date\":\"20150102\"},\{\"title\":\"나비\",\"image\":\"10.jpg\",\"date\":\"20141225\"}]";
    self.jsonData = [NSData dataWithBytes:data length:strlen(data)];
    self.datas = [NSJSONSerialization JSONObjectWithData:self.jsonData options:kNilOptions error:nil];
    NSLog(@"%@",self.datas);
    [self loadNotify];
}

- (void)loadNotify {
    self.notiCenter = [NSNotificationCenter defaultCenter];
    [self.notiCenter postNotificationName:@"modelInitialized" object:nil];
}

- (void)sort {
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    self.datas = [self.datas sortedArrayUsingDescriptors:sortDescriptors];
    [self.notiCenter postNotificationName:@"sorted" object:nil];
}

- (NSArray *)getYearArray {
    self.years = [[NSMutableArray alloc] init];
    for(NSMutableDictionary *data in self.datas){
        [self.years addObject:[[data objectForKey:@"date"] substringToIndex:4]];
    }
    self.years = [[[NSSet setWithArray:self.years] allObjects] mutableCopy];
    [self.years sortUsingSelector:@selector(caseInsensitiveCompare:)];
    return self.years;
}

- (int)getNumberElementInYear:(NSString *)year {
    int count = 0;
    for(NSMutableDictionary *data in self.datas){
        if([[[data objectForKey:@"date"] substringToIndex:4] isEqualToString:year]){
            count++;
        };
    }
    return count;
}

@end
