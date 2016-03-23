//
//  GoView.h
//  Week 4-2
//
//  Created by 김기범 on 2016. 3. 23..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UITouch.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface GoView : UIView {
    int stonePlace[11][11];
    BOOL isBlackTurn;
}
@property UIImage *backgroundImg;
@property UIImage *black;
@property UIImage *white;
- (void)awakeFromNib;
@end
