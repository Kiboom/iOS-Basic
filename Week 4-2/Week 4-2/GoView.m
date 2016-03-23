//
//  GoView.m
//  Week 4-2
//
//  Created by 김기범 on 2016. 3. 23..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "GoView.h"

@implementation GoView

// 이미지 객체를 drawRect에서 선언해버리면 매번 draw 할 때마다 객체가 생기니까, awakeFromNib이라는 초기화 메서드에서 선언하기.
- (void)awakeFromNib {
    self.backgroundImg = [UIImage imageNamed:@"oak.png"];
    self.black = [UIImage imageNamed:@"black.png"];
    self.white = [UIImage imageNamed:@"white.png"];
    isBlackTurn = YES;
    [self initializeStonePlace];
}


- (void)initializeStonePlace {
    for(int x=0 ; x<11 ; x++){
        for(int y=0 ; y<11 ; y++){
            stonePlace[x][y] = 0;
        }
    }
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    UITouch *uiTouch = [touches anyObject];
    CGPoint touch = [uiTouch locationInView:uiTouch.view];
    printf("%f, %f\n", touch.x, touch.y);
    [self setStone:touch];
    [self setNeedsDisplay];
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake){
        isBlackTurn = YES;
        [self initializeStonePlace];
        [self setNeedsDisplay];
    }
}


- (void)setStone:(CGPoint)touch {
    int x = floor((touch.x-10)/30 + 0.5);
    int y = floor((touch.y-20)/30 + 0.5);
    
    if(stonePlace[x][y]){
        return;
    }
    
    if(isBlackTurn){
        stonePlace[x][y] = 1;
        isBlackTurn=FALSE;
    }else{
        stonePlace[x][y] = 2;
        isBlackTurn=YES;
    }
}


- (void)drawRect:(CGRect)rect {
    [self.backgroundImg drawInRect:rect];
    [self drawLines];
    [self drawStones];
    [self drawBars];
}


- (void)drawLines {
    UIBezierPath *path = [UIBezierPath bezierPath];
    for(int i=0 ; i<=300 ; i+=30) {
        [path moveToPoint:CGPointMake(10+i, 20)];
        [path addLineToPoint:CGPointMake(10+i, 320)];
        [path moveToPoint:CGPointMake(10, 20+i)];
        [path addLineToPoint:CGPointMake(310, 20+i)];
        [path setLineWidth:1.5];
        [path stroke];
    }
}


- (void)drawStones{
    for(int x=0 ; x<11 ; x++){
        for(int y=0 ; y<11 ; y++){
            CGRect position = CGRectMake(x*30, y*30+10, 20, 20);
            if(stonePlace[x][y]==1){
                [self.black drawInRect:position];
            }
            else if(stonePlace[x][y]==2) {
                [self.white drawInRect:position];
            }
        }
    }
}


- (void)drawBars{
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    for(int x=0 ; x<11 ; x++){
        int black=0, white = 0;
        
        for(int y=0 ; y<11 ; y++){
            if(stonePlace[x][y]==1){
                black++;
            }
            else if(stonePlace[x][y]==2){
                white++;
            }
        }
        
        if(black < white) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x*30, screenHeight-white*5, 20, white*5)];
            [[UIColor whiteColor] setFill];
            [path fill];
        }
        else if (black > white) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(x*30, screenHeight-black*5, 20, black*5)];
            [[UIColor blackColor] setFill];
            [path fill];
        }
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


@end
