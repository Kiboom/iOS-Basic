//
//  NXPen.m
//  iOS Basic Problem Solving
//
//  Created by 김기범 on 2016. 3. 2..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "NXPen.h"


@implementation NXPen

        // init 생성자의 경우 기본적으로 다음 두가지를 써줘야 함.    self = [super init]; return self;
        // 이렇게 부모 생성자를 호출한 다음에 경우에 따라 하위 객체를 만듬.     if(self){ ~~ }
        //    self = [super init];
        //    if(self){
        //        //
        //    }
        //    return self;

    /* 생성자 */
    -(id)initWithBrand:(NSString *)aBrand {
        self = [super init];        // super에 대한 alloc은 init메서드 호출하기 전에 이미 할당됨.
        if(self){
            _brand = aBrand;
        }
        return self;
    }

    /* Getter Setter */
    -(NSString *)brand {
        return _brand;
    }

    -(NSString *)color {
        return _color;
    }
    -(int)usage{
        return _usage;
    }
    -(void)setBrand:(NSString*)brand{
        _brand = brand;
    }
    -(void)setColor:(NSString*)color{
        _color = color;
    }
    -(void)setUsage:(int)usage{
        _usage = usage;
    }


    /* Display */
    -(void)printDescription{
        NSLog(@"\nPen Description\nbrand : %@, color : %@, usage : %d%%\n\n", _brand, _color, _usage);
    }

@end
