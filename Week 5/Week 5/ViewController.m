//
//  ViewController.m
//  Week 5
//
//  Created by 김기범 on 2016. 3. 30..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

@synthesize decks;

- (void)viewDidLoad {
    [super viewDidLoad];
    _solitaireDeck = [[SolitaireDeck alloc] init];
    self.notiCenter = [NSNotificationCenter defaultCenter];
    [self.notiCenter addObserver:self
                        selector:@selector(saveArray)
                            name:@"willResign"
                          object:nil];
    [self.notiCenter addObserver:self
                        selector:@selector(loadArray)
                            name:@"didActive"
                          object:nil];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self shuffle:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)saveArray {
    NSLog(@"resign");
    [self.userDefaults setObject:self.decks
                          forKey:@"decks"];
}


-(void)loadArray {
    NSLog(@"active");
    if(self.decks){
        self.decks = [self.userDefaults objectForKey:@"decks"];
        [self drawCards];
    }
}


- (void)drawCards {
    [self eraseAllCardViews];
    for(int i=1 ; i<8 ; i++){
        NSMutableArray *deck = self.decks[i];
        for(int j=0 ; j<i ; j++){
            UIImageView *imageView = [self makeCardImageView:deck :j];
            [imageView setFrame:CGRectMake(26+140*(i-1), 100+40*(j-1), 130, 170)];
            [self.view addSubview:imageView];
        }
    }
    for(int i=0 ; i<24 ; i++) {
        UIImageView *imageView = [self makeCardImageView:self.decks[0] :i];
        [imageView setFrame:CGRectMake(26+24*(i-1), 500, 130, 170)];
        [self.view addSubview:imageView];
    }
}


- (UIImageView *)makeCardImageView:(NSArray *)deck :(int)num {
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", deck[num]] ofType:@"png"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
    return [[UIImageView alloc] initWithImage:image];
}


- (void)eraseAllCardViews {
    NSArray *subViews = [self.view subviews];
    for(UIView *view in subViews) {
        if([view.class isSubclassOfClass:[UIImageView class]]){
            [view removeFromSuperview];
            [[(UIImageView *)view image] release];
            [view release];
        }
    }
}


- (IBAction)shuffle:(id)sender {
    self.decks = [_solitaireDeck shuffleCards];
    [self drawCards];
}


@end
