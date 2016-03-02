//
//  FilePrinter.h
//  Problem 1
//
//  Created by 김기범 on 2016. 3. 2..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilePrinter : NSObject

+(void) NXDisplayAllFilesAtPath:(NSString*)path;
+(void) NXDisplayAllFilesAtPath:(NSString*)path filterByExtension:(NSString*)extension;
+(void) NXDeepSearch:(NSString *)path;

@end
