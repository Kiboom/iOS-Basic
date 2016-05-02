//
//  CheckmarkGestureRecognizer.m
//  Week 10-1
//
//  Created by 김기범 on 2016. 5. 2..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "CheckmarkGestureRecognizer.h"

@implementation CheckmarkGestureRecognizer

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if(self = [super initWithTarget:target action:action]) {
        self.delegate = target;
        self.action = action;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.point1 = [[touches anyObject] locationInView:nil];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:nil];
    CGPoint previousPoint = [touch previousLocationInView:nil];
    CGFloat xDeltaFromPrevious = currentPoint.x-previousPoint.x;
    CGFloat yDeltaFromPrevious = currentPoint.y-previousPoint.y;
    CGFloat xDeltaFromPoint1 = previousPoint.x-_point1.x;
    CGFloat yDeltaFromPoint1 = previousPoint.y-_point1.y;
    if(xDeltaFromPrevious>0 && yDeltaFromPrevious<0 && xDeltaFromPoint1>0 && yDeltaFromPoint1>0 && _readyToGoUp==NO) {
        self.point2 = previousPoint;
        self.readyToGoUp = YES;
    }
    else if(_readyToGoUp && xDeltaFromPrevious>0 && yDeltaFromPrevious<0) {
        self.point3 = currentPoint;
    }
    else {
        self.readyToGoUp = NO;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if(self.readyToGoUp) {
        [self.delegate performSelector:_action withObject:self];
        self.readyToGoUp = NO;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
