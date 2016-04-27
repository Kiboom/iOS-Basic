//
//  ViewController.m
//  Week 9-2
//
//  Created by 김기범 on 2016. 4. 27..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bookfile = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bookfile" ofType:@".txt"] encoding:NSUTF8StringEncoding error:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(NSUInteger)countOfSubstring:(NSString*)substring atContents:(NSString*)contents {
    /* using substringWithRange
    NSUInteger substringCount=0;
    NSString *aString;
    for(int i=0 ; i<contents.length - substring.length ; i++) {
        aString = [contents substringWithRange:NSMakeRange(i, substring.length)];
        if([aString isEqualToString:substring]) {
            substringCount++;
        }
    }
    */
    
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:[NSString stringWithFormat:@"(%@)+", substring] options:0 error:nil];
    NSUInteger substringCount = [regex numberOfMatchesInString:_bookfile options:0 range:NSMakeRange(0, _bookfile.length)];
    return substringCount;
}



- (IBAction)bookCount:(id)sender {
    NSLog(@"%lu", (unsigned long)[self countOfSubstring:@"국부" atContents:_bookfile]);
}



- (void)fetchWords {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://125.209.194.123/wordlist.php"]];
    NSData *wordData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    _words = [NSJSONSerialization JSONObjectWithData:wordData options:kNilOptions error:nil];
}



- (NSDictionary *)getWordCounts {
    NSMutableDictionary *wordCount = [[NSMutableDictionary alloc] init];
    for(NSString *word in _words) {
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            NSUInteger count = [self countOfSubstring:word atContents:_bookfile];
            [wordCount setObject:[NSNumber numberWithLong:count] forKey:word];
        }];
        [operation start];
    }
    [wordCount enumerateKeysAndObjectsUsingBlock:^(NSString *word, NSNumber *count, BOOL *stop) {
        NSLog(@"%@, %@", word, count);
    }];
    return wordCount;
}



- (IBAction)wordCount:(id)sender {
    [self fetchWords];
    NSDictionary *wordCounts = [self getWordCounts];
    
    [[NSBlockOperation blockOperationWithBlock:^{
        [wordCounts enumerateKeysAndObjectsUsingBlock:^(NSString *word, NSNumber *count, BOOL *stop) {
            if(_highestCount == nil || [count compare:_highestCount] == NSOrderedDescending) {
                _highestWord = word;
                _highestCount = count;
            }
        }];
    }] start];
    [[NSBlockOperation blockOperationWithBlock:^{
        [wordCounts enumerateKeysAndObjectsUsingBlock:^(NSString *word, NSNumber *count, BOOL *stop) {
            if(_lowestCount == nil || [count compare:_lowestCount] == NSOrderedAscending) {
                _lowestWord = word;
                _lowestCount = count;
            }
        }];
    }] start];
    NSUInteger wordCountFromWholeText = [self countOfSubstring:@" " atContents:_bookfile] + 1;
    
    [[[UIAlertView alloc] initWithTitle:@"완료" message:[NSString stringWithFormat:@"%@ : %@\n%@ : %@\n전체 단어 수 : %lu", _highestWord, _highestCount, _lowestWord, _lowestCount, wordCountFromWholeText] delegate:self cancelButtonTitle:@"닫기" otherButtonTitles:nil, nil] show];
}
@end
