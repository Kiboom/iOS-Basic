//
//  MainView.m
//  Week 10-2
//
//  Created by 김기범 on 2016. 5. 4..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "MainView.h"

@implementation MainView


- (void)awakeFromNib {
    _points = [[NSMutableArray alloc] init];
    [self recognizerInit];
}


- (void)recognizerInit {
    Number1GestureRecognizer *recognizer1 = [[Number1GestureRecognizer alloc] initWithTarget:self action:@selector(respondsToGesture:)];
    recognizer1.delaysTouchesBegan = NO;
    recognizer1.delaysTouchesEnded = NO;
    
    Number2GestureRecognizer *recognizer2 = [[Number2GestureRecognizer alloc] initWithTarget:self action:@selector(respondsToGesture:)];
    [recognizer2 requireGestureRecognizerToFail:recognizer1];
    recognizer2.delaysTouchesBegan = NO;
    recognizer2.delaysTouchesEnded = NO;
    
    Number3GestureRecognizer *recognizer3 = [[Number3GestureRecognizer alloc] initWithTarget:self action:@selector(respondsToGesture:)];
    [recognizer3 requireGestureRecognizerToFail:recognizer2];
    recognizer3.delaysTouchesBegan = NO;
    recognizer3.delaysTouchesEnded = NO;
    
    [self addGestureRecognizer:recognizer1];
    [self addGestureRecognizer:recognizer2];
    [self addGestureRecognizer:recognizer3];
}


- (void)drawRect:(CGRect)rect {
    [self drawNumber];
}



- (void)drawNumber {
    UIBezierPath *path = [UIBezierPath bezierPath];
    for(int i=1 ; i<_points.count ; i++) {
        CGPoint point = [_points[i-1] CGPointValue];
        [path moveToPoint:point];
        [path addLineToPoint:point];
        CGPoint point2 = [_points[i] CGPointValue];
        [path moveToPoint:point2];
        [path addLineToPoint:point];
        [path setLineWidth:10];
        [path stroke];
    }
}


- (void)eraseNumber {
    
}


- (void)respondsToGesture:(NSNumber *)number {
    NSLog(@"%@",number);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_points removeAllObjects];
    [self eraseNumber];
    
    CGPoint touchPoint = [[touches anyObject] locationInView:nil];
    [_points addObject:[NSValue valueWithCGPoint:touchPoint]];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint prevTouchPoint = [[touches anyObject] previousLocationInView:nil];
    CGPoint curTouchPoint = [[touches anyObject] locationInView:nil];
    [_points addObject:[NSValue valueWithCGPoint:prevTouchPoint]];
    [_points addObject:[NSValue valueWithCGPoint:curTouchPoint]];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
