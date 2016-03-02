//
//  NXPen.h
//  iOS Basic Problem Solving
//
//  Created by 김기범 on 2016. 3. 2..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <Foundation/Foundation.h>

    // 인스턴스 변수는 기본적으로 인터페이스 옆에 이렇게 중괄호를 쳐서 선언함.
    // 인스턴스 변수는 기본적으로 언더바를 붙임.
@interface NXPen : NSObject {
    NSString * _brand;
    NSString * _color;
    int _usage;
}

/* 생성자 */
-(id)initWithBrand:(NSString*)aBrand;


    // getter의 경우 메서드 명에 get을 안 붙임.
    // 그리고 인스턴스 변수와는 달리 언더바를 뺌.
/* Getter Setter */
-(NSString *)brand;
-(NSString *)color;
-(int)usage;
-(void)setBrand:(NSString*)brand;
-(void)setColor:(NSString*)color;
-(void)setUsage:(int)usage;


/* Display */
-(void)printDescription;

@end
