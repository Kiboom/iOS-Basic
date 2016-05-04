//
//  Number2GestureRecognizer.h
//  Week 10-2
//
//  Created by 김기범 on 2016. 5. 4..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Number2GestureRecognizer : UIGestureRecognizer

@property BOOL isStep1;
@property BOOL isStep2;
@property BOOL isStep3;
@property BOOL isStep4;

@property BOOL hasStep1HappendOnce;
@property BOOL hasStep2HappendOnce;
@property BOOL hasStep3HappendOnce;
@property BOOL hasStep4HappendOnce;

@property BOOL isError;

@property SEL action;

@end
