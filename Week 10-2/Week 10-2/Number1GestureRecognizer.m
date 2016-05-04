//
//  Number1GestureRecognizer.m
//  Week 10-2
//
//  Created by 김기범 on 2016. 5. 4..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "Number1GestureRecognizer.h"

@implementation Number1GestureRecognizer

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if(self = [super initWithTarget:target action:action]) {
        self.delegate = target;
        self.action = action;
        _isError = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   _startPoint = [[touches anyObject] locationInView:nil];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint prevTouch = [[touches anyObject] previousLocationInView:nil];
    CGPoint curTouch = [[touches anyObject] locationInView:nil];
    if(curTouch.y-prevTouch.y >= 0 && _isError==NO) {    // 한 번이라도 _isError=YES 된 경력이 있으면 아예 못바꾸게.
        return;
    }
    else if(fabs(curTouch.y-prevTouch.y) <= 5) {
        return;
    }
    _isError = YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _endPoint = [[touches anyObject] locationInView:nil];
    NSNumber *number = [self recognizeNumber];
    [self.delegate performSelector:_action withObject:number];
    _isError = NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


- (NSNumber *)recognizeNumber {
    if((_endPoint.x - _startPoint.x < 20) && _isError==NO) {
        return @1;
    }
    self.state = UIGestureRecognizerStateFailed;
    return nil;
}

@end
