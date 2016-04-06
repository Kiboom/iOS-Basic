//
//  ViewController.h
//  Week 5
//
//  Created by 김기범 on 2016. 3. 30..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SolitaireDeck.h"

@interface ViewController : UIViewController {
    SolitaireDeck *_solitaireDeck;
}

@property (strong) NSNotificationCenter *notiCenter;
@property (strong) NSArray *decks;
@property (strong) NSUserDefaults *userDefaults;

- (IBAction)shuffle:(id)sender;

@end

