//
//  main.m
//  iOS Basic Problem Solving
//
//  Created by 김기범 on 2016. 3. 2..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NXPen.h"
#import "FilePrinter.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        /* Problem 1 */
        /*
        NXPen *pen1 = [[NXPen alloc] initWithBrand:@"BIC"];
        NXPen *pen2 = [[NXPen alloc] initWithBrand:@"BIC"];
        NXPen *pen3 = [[NXPen alloc] initWithBrand:@"Monami"];
        NXPen *pen4 = [[NXPen alloc] initWithBrand:@"Monami"];
        NXPen *pen5 = [[NXPen alloc] initWithBrand:@"Monami"];
        NXPen *pen6 = [[NXPen alloc] initWithBrand:@"SHARP"];
        NXPen *pen7 = [[NXPen alloc] initWithBrand:@"SHARP"];
        NXPen *pen8 = [[NXPen alloc] initWithBrand:@"HighTech"];
        NXPen *pen9 = [[NXPen alloc] initWithBrand:@"HighTech"];
        NXPen *pen10 = [[NXPen alloc] initWithBrand:@"Mitzbushi"];
        
        [pen1 setColor:@"Red"];
        [pen2 setColor:@"Orange"];
        [pen3 setColor:@"Yellow"];
        [pen4 setColor:@"Lime"];
        [pen5 setColor:@"Green"];
        [pen6 setColor:@"Cyan"];
        [pen7 setColor:@"Blue"];
        [pen8 setColor:@"Cobalt"];
        [pen9 setColor:@"Purple"];
        [pen10 setColor:@"Pink"];
        
        [pen1 setUsage:30];
        [pen2 setUsage:50];
        [pen3 setUsage:60];
        [pen4 setUsage:40];
        [pen5 setUsage:20];
        [pen6 setUsage:70];
        [pen7 setUsage:100];
        [pen8 setUsage:80];
        [pen9 setUsage:90];
        [pen10 setUsage:50];
        
        [pen1 printDescription];
        [pen2 printDescription];
        [pen3 printDescription];
        [pen4 printDescription];
        [pen5 printDescription];
        [pen6 printDescription];
        [pen7 printDescription];
        [pen8 printDescription];
        [pen9 printDescription];
        [pen10 printDescription];
        */

        
        /* Instance Methods */
        /*
        FilePrinter *fp = [[FilePrinter alloc] init];
        [fp NXDisplayAllFilesAtPath:@"/Users/Thomas"];
        [fp NXDisplayAllFilesAtPath:@"/Users/Thomas" filterByExtension:@"png"];
        [fp NXDeepSearch:@"/Users/Thomas/무제 폴더"];
         */
        
        
        /* Class Methods */
        [FilePrinter NXDisplayAllFilesAtPath:@"/Users/Thomas"];
        [FilePrinter NXDisplayAllFilesAtPath:@"/Users/Thomas" filterByExtension:@"png"];
        [FilePrinter NXDeepSearch:@"/Users/Thomas/무제 폴더"];
        
    }
    return 0;
}
