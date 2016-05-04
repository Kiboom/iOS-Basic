//
//  Number1GestureRecognizer.h
//  Week 10-2
//
//  Created by 김기범 on 2016. 5. 4..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface Number1GestureRecognizer : UIGestureRecognizer

@property CGPoint startPoint;
@property CGPoint endPoint;
@property BOOL isError;
@property SEL action;

@end
