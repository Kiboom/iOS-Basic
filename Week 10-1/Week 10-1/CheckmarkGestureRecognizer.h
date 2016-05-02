//
//  CheckmarkGestureRecognizer.h
//  Week 10-1
//
//  Created by 김기범 on 2016. 5. 2..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface CheckmarkGestureRecognizer : UIGestureRecognizer

@property CGPoint point1;
@property CGPoint point2;
@property CGPoint point3;

@property BOOL readyToGoUp;

@property SEL action;

- (instancetype)initWithTarget:(id)target action:(SEL)action;

@end
