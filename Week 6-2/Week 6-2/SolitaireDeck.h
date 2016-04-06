//
//  SolitaireDeck.h
//  Week 5
//
//  Created by 김기범 on 2016. 3. 30..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SolitaireDeck : NSObject

@property (retain) NSMutableArray *decks;
@property (retain) NSMutableArray *cards;
@property (retain) NSMutableArray *mutableCards;

- (NSArray *)shuffleCards;
- (void)displayCards;

@end
