//
//  SolitaireDeck.m
//  Week 5
//
//  Created by 김기범 on 2016. 3. 30..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "SolitaireDeck.h"

@implementation SolitaireDeck

- (id)init{
    self = [super init];
    if(self){
        [self initializeDecks];
        self.cards = [[NSMutableArray alloc] init];
        for(int i=1 ; i<=52 ; i++){
            [self.cards addObject:[[NSNumber alloc] initWithInt:i]];
        }
        self.mutableCards = [self.cards mutableCopy];
    }
    return self;
}


- (void)initializeDecks {
    self.decks = [[NSMutableArray alloc] init];
    [self.decks addObject:[[NSMutableArray alloc] init]];
    for(int i=0 ; i<24 ; i++){
        [self.decks[0] addObject:[NSNull null]];
    }
    for(int i=1 ; i<8 ; i++){
        [self.decks addObject:[[NSMutableArray alloc] init]];
        for(int j=0 ; j<i ; j++){
            [self.decks[i] addObject:[NSNull null]];
        }
    }
}


- (NSNumber *)pickNumber{
    int random = arc4random_uniform((unsigned)[self.mutableCards count]);
    NSNumber *number = [self.mutableCards objectAtIndex:random];
    [self.mutableCards removeObjectAtIndex:random];
    if([self.mutableCards count]==0){
        [self.mutableCards release];
        self.mutableCards = [self.cards mutableCopy];
    }
    return number;
}


- (NSArray *)shuffleCards {
    for(int i=0 ; i<24 ; i++) {
        [self.decks[0] replaceObjectAtIndex:i withObject:[self pickNumber]];
    }
    for(int i=1 ; i<8 ; i++){
        NSMutableArray *deck = self.decks[i];
        for(int j=0 ; j<i ; j++){
            [deck replaceObjectAtIndex:j withObject:[self pickNumber]];
        }
    }
    return self.decks;
}


- (void)displayCards {
    for(int i=1 ; i<8 ; i++){
        NSLog(@"%@", self.decks[i]);
    }
    NSLog(@"%@", self.decks[0]);
}


@end
