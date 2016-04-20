//
//  DetailViewController.m
//  MidTerm
//
//  Created by 김기범 on 2016. 4. 11..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "KBDetailViewController.h"

@interface KBDetailViewController ()

@end

@implementation KBDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    NSDictionary *data = (NSDictionary *)_detailItem;
    self.titleLabel.text = [data objectForKey:@"title"];
    self.dateLabel.text = [data objectForKey:@"date"];
    self.imageView.image = [self getImageFromServer:[data objectForKey:@"image"]];
}

- (UIImage *)getImageFromServer:(NSString *)imageName {
    NSString *urlString = [[NSString alloc] initWithFormat:@"http://125.209.194.123/demo/%@",imageName];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    return [[UIImage alloc] initWithData:data];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
