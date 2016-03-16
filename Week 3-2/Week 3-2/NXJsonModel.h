//
//  NXJsonModel.h
//  Week 3-2
//
//  Created by 김기범 on 2016. 3. 16..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NXJsonModel : NSObject

@property NSArray *jsonArray;

- (NSDictionary *)itemAtIndex:(int)index;

@end
