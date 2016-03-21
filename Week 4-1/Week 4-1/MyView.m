//
//  MyView.m
//  Week 4-1
//
//  Created by 김기범 on 2016. 3. 21..
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

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGGradientRef gradient = [self gradient];
    CGPoint startPoint = CGPointMake(CGRectGetMidX(self.bounds), 0.0);
    CGPoint endPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds));
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    [self drawRandomLines];
    [self drawRandomArcs];
}

- (CGGradientRef)gradient {
    UIColor *startColor = [UIColor colorWithRed:0.8 green:0.3 blue:0.5 alpha:1.0];
    UIColor *endColor = [UIColor colorWithRed:0.3 green:0.5 blue:0.8 alpha:1.0];
    CGFloat locations[2] = {0.0, 1.0};
    CFArrayRef colors = (__bridge CFArrayRef) [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil]; // CFArrayRef는 기본적으로 NSArray와 같다고 보면 됨. C구조체인듯? 그래서 변환해주는 작업이 필요. 당연 NSArray처럼 안에 객체를 넣을 수 없음.
    CGColorSpaceRef colorSpc = CGColorSpaceCreateDeviceRGB();
    return CGGradientCreateWithColors(colorSpc, colors, locations);;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setNeedsDisplay];
    NSLog(@"touched");
}

- (void)drawRandomText {
}

- (void)drawRandomLines {
    [self setRandomPointsOfLine];
    for(int i=0 ; i<20 ; i+=2){
        UIBezierPath *path = [UIBezierPath bezierPath];
        NSValue *startVal = [self.randomPoints objectAtIndex:i];
        NSValue *endVal = [self.randomPoints objectAtIndex:i+1];
        [path moveToPoint:[startVal CGPointValue]];
        [path addLineToPoint:[endVal CGPointValue]];
        [path setLineWidth:1.0];
        [path stroke];
    }
}

- (void)drawRandomArcs {
    [self setRandomPointsOfArc];
    for(int i=0 ; i<10 ; i++){
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:[[self.randomCenters objectAtIndex:i] CGPointValue]
                                                             radius:[[self.randomRadius objectAtIndex:i] floatValue]
                                                         startAngle:0.0
                                                           endAngle:((M_PI*360.0)/180.0)
                                                          clockwise:YES];
        [path setLineWidth:3.0];
        [path stroke];
        [self setRandomArcColor:path];
    }
}

- (void)setRandomArcColor:(UIBezierPath *)path {
    CGFloat red = [[NSNumber numberWithFloat:((float)rand()/RAND_MAX)] floatValue];
    CGFloat green = [[NSNumber numberWithFloat:((float)rand()/RAND_MAX)] floatValue];
    CGFloat blue = [[NSNumber numberWithFloat:((float)rand()/RAND_MAX)] floatValue];
    [[UIColor colorWithRed:red green:green blue:blue alpha:1.0] setFill];
    [path fill];
}


- (void)setRandomPointsOfLine {
    self.randomPoints = [NSMutableArray array];
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    for (int i=0 ; i<20 ; i++){
        CGFloat randomX = [[NSNumber numberWithFloat:((float)rand()/RAND_MAX*width)] floatValue];
        CGFloat randomY = [[NSNumber numberWithFloat:((float)rand()/RAND_MAX*height)] floatValue];
        [self.randomPoints addObject:[NSValue valueWithCGPoint:CGPointMake(randomX, randomY)]];
    }
}

- (void)setRandomPointsOfArc {
    self.randomCenters = [NSMutableArray array];
    self.randomRadius = [NSMutableArray array];
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    for (int i=0 ; i<10 ; i++){
        CGFloat randomX = [[NSNumber numberWithFloat:((float)rand()/RAND_MAX*width)] floatValue];
        CGFloat randomY = [[NSNumber numberWithFloat:((float)rand()/RAND_MAX*height)] floatValue];
        [self.randomCenters addObject:[NSValue valueWithCGPoint:CGPointMake(randomX, randomY)]];
    }
    for (int i=0 ; i<10 ; i++){
        [self.randomRadius addObject:[NSNumber numberWithFloat:((float)rand()/RAND_MAX*77)]];
    }
}

@end
