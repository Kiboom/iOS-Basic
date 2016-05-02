//
//  MyView.m
//  Week 10-1
//
//  Created by 김기범 on 2016. 5. 2..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "MyView.h"

@implementation MyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _startPoint = [touch locationInView:self];
    if(touch.tapCount == 2) {
        self.layer.backgroundColor = [[UIColor whiteColor]CGColor];
    }
    else if (touch.tapCount == 3) {
        self.layer.backgroundColor = [[UIColor blackColor]CGColor];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _endPoint = [touch locationInView:self];
    [self changeOpacityWithStartPoint:_startPoint EndPoint:_endPoint];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.4 animations:^{
        self.layer.opacity = 1.0;
    }];
    if([[event allTouches] count]>1) {
        self.layer.backgroundColor = [[UIColor colorWithRed:(float)rand()/RAND_MAX green:(float)rand()/RAND_MAX blue:(float)rand()/RAND_MAX alpha:1.0] CGColor];
    }
}


- (void)changeOpacityWithStartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint {
    CGFloat distance = sqrt(pow((_startPoint.x - _endPoint.x), 2) + pow((_startPoint.y - _endPoint.y), 2));
    CGFloat maxDistance = sqrt(pow(self.frame.size.height, 2) + pow(self.frame.size.width, 2));
    self.layer.opacity = 1.0 - (float)distance/(maxDistance/2);
}

@end
