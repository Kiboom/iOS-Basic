//
//  ViewController.h
//  Week 9-2
//
//  Created by 김기범 on 2016. 4. 27..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property NSString *bookfile;
@property NSInteger bookLen;
@property NSArray *words;

@property NSString *highestWord;
@property NSNumber *highestCount;
@property NSString *lowestWord;
@property NSNumber *lowestCount;

- (IBAction)bookCount:(id)sender;
- (IBAction)wordCount:(id)sender;

@end

