//
//  Number3GestureRecognizer.m
//  Week 10-2
//
//  Created by 김기범 on 2016. 5. 4..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "Number3GestureRecognizer.h"

@implementation Number3GestureRecognizer


- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if(self = [super initWithTarget:target action:action]) {
        self.delegate = target;
        self.action = action;
        [self boolInit];
    }
    return self;
}

- (void)boolInit {
    _isError = NO;
    _isStep1 = YES;
    _isStep2 = NO;
    _isStep3 = NO;
    _isStep4 = NO;
    _isStep5 = NO;
    _isStep6 = NO;
    _hasStep1HappendOnce = NO;
    _hasStep2HappendOnce = NO;
    _hasStep3HappendOnce = NO;
    _hasStep4HappendOnce = NO;
    _hasStep5HappendOnce = NO;
    _hasStep6HappendOnce = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint prevTouch = [[touches anyObject] previousLocationInView:nil];
    CGPoint curTouch = [[touches anyObject] locationInView:nil];
    if(_isStep1==YES && _isError==NO) {
        _isError = [self isFailedStep1GestureFrom:prevTouch To:curTouch];
        return;
    }
    if(_isStep2==YES && _isError==NO) {
        _isError = [self isFailedStep2GestureFrom:prevTouch To:curTouch];
        return;
    }
    if(_isStep3==YES && _isError==NO) {
        _isError = [self isFailedStep3GestureFrom:prevTouch To:curTouch];
        return;
    }
    if(_isStep4==YES && _isError==NO) {
        _isError = [self isFailedStep4GestureFrom:prevTouch To:curTouch];
        return;
    }
    if(_isStep5==YES && _isError==NO) {
        _isError = [self isFailedStep5GestureFrom:prevTouch To:curTouch];
        return;
    }
    if(_isStep6==YES && _isError==NO) {
        _isError = [self isFailedStep6GestureFrom:prevTouch To:curTouch];
        return;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSNumber *number = [self recognizeNumber];
    [self.delegate performSelector:_action withObject:number];
    [self boolInit];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


- (BOOL)isFailedStep1GestureFrom:(CGPoint)prevTouch To:(CGPoint)curTouch {
    if((curTouch.y - prevTouch.y <= 0)) {
        _hasStep1HappendOnce = YES;
        return NO;
    }
    // step2에 대한 gesture가 막 일어난 경우
    else if((curTouch.x - prevTouch.x >= 0) && (curTouch.y - prevTouch.y >= 0)){
        _isStep1 = NO;
        _isStep2 = YES;
        return NO;
    }
    else {
        return YES;
    }
}


- (BOOL)isFailedStep2GestureFrom:(CGPoint)prevTouch To:(CGPoint)curTouch {
    if((curTouch.x - prevTouch.x >= 0) && (curTouch.y - prevTouch.y >= 0)) {
        _hasStep2HappendOnce = YES;
        return NO;
    }
    // step3에 대한 gesture가 막 일어난 경우
    else if(_hasStep2HappendOnce && (curTouch.x - prevTouch.x <= 0) && (curTouch.y - prevTouch.y >= 0)){
        _isStep2 = NO;
        _isStep3 = YES;
        return NO;
    }
    else {
        return YES;
    }
}


- (BOOL)isFailedStep3GestureFrom:(CGPoint)prevTouch To:(CGPoint)curTouch {
    if((curTouch.x - prevTouch.x <= 0) && (curTouch.y - prevTouch.y >= 0)) {
        _hasStep3HappendOnce = YES;
        return NO;
    }
    // step4에 대한 gesture가 막 일어난 경우
    else if(_hasStep3HappendOnce && (curTouch.x - prevTouch.x >= 0) && (curTouch.y - prevTouch.y >= 0)){
        _isStep3 = NO;
        _isStep4 = YES;
        return NO;
    }
    else {
        // 가운데 변곡점에 대한 기준 완화 : 너무 뾰족한 부분이라 적당히 얼렁뚱땅 써도 Step3를 만족시킨다고 판정.
        if(fabs(curTouch.x - prevTouch.x) <= 3  && fabs(curTouch.y - prevTouch.y) <= 3) {
            _hasStep3HappendOnce = YES;
            return NO;
        }
        return YES;
    }
}


- (BOOL)isFailedStep4GestureFrom:(CGPoint)prevTouch To:(CGPoint)curTouch {
    if((curTouch.x - prevTouch.x >= 0) && (curTouch.y - prevTouch.y >= 0)) {
        _hasStep4HappendOnce = YES;
        return NO;
    }
    // step3에 대한 gesture가 막 일어난 경우
    else if(_hasStep4HappendOnce && (curTouch.x - prevTouch.x <= 0) && (curTouch.y - prevTouch.y >= 0)){
        _isStep4 = NO;
        _isStep5 = YES;
        return NO;
    }
    else {
        return YES;
    }
}


- (BOOL)isFailedStep5GestureFrom:(CGPoint)prevTouch To:(CGPoint)curTouch {
    if((curTouch.x - prevTouch.x <= 0) && (curTouch.y - prevTouch.y >= 0)) {
        _hasStep5HappendOnce = YES;
        return NO;
    }
    // step4에 대한 gesture가 막 일어난 경우
    else if(_hasStep5HappendOnce && (curTouch.x - prevTouch.x <= 0) && (curTouch.y - prevTouch.y <= 0)){
        _isStep5 = NO;
        _isStep6 = YES;
        return NO;
    }
    else {
        return YES;
    }
}


- (BOOL)isFailedStep6GestureFrom:(CGPoint)prevTouch To:(CGPoint)curTouch {
    if(curTouch.y - prevTouch.y <= 0) {
        _hasStep6HappendOnce = YES;
        return NO;
    }
    else {
        return YES;
    }
}


- (NSNumber *)recognizeNumber {
    if(_isError==NO && _hasStep2HappendOnce==YES && _hasStep3HappendOnce==YES && _hasStep4HappendOnce==YES && _hasStep5HappendOnce==YES) {
        return @3;
    }
    self.state = UIGestureRecognizerStateFailed;
    return nil;
}



@end
