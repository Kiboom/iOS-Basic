//
//  FilePrinter.m
//  Problem 1
//
//  Created by 김기범 on 2016. 3. 2..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "FilePrinter.h"


@implementation FilePrinter

// 대부분은 NSFileManager 인스턴스로 가져오기 위해 defaultManger를 써도 됨. 이 경우 싱글톤으로 인스턴스를 반환해줌.
// 하지만!! 멀티 쓰레드로 File Access하는 경우라면 alloc init으로 별도의 인스턴스들을 만들어줘야 함.



// 데이터 구조를 탐색하는 경우에는 두가지 메서드 및 두가지 클래스가 존재함.
// 1. contentsOfDirectoryAtPath : 어레이가 만들어져서 리턴됨. 그런데, 파일이 너무 많은 경우 그만큼 메모리를 많이 차지함. 특히 필터링하는 경우 2번이나 루프를 돌아야함.
      // 내가 찾으려고 하는 파일이 한정되어있고 그 폴더 안에서만 shallow search 할거면 유리함.
// 2. enumeratorAtPath : 어레이가 얼마나 만들어질지 모를 때 쓰면 좋음. 특히 필터링을 하는 경우라면! 게다가 Deep Search 하는 경우 더 유리함.
      // enumeration은 subDirectory까지 뒤지면서 파일 하나하나를 필터링하면서 search할 때 유리함.
// 어떤 기능의 API를 쓸 때는 그 API가 메모리를 얼마나 쓰는지, 탐색을 몇 번이나 하는지 등등 그 특성을 같이 이해하고 있어야함.
// 단순히 돌아간다고 막 가져다 쓰지 말고, 꼭 생각하고 알아보며 쓰기!

static NSFileManager *_fileManager = nil;

+(void)NXDisplayAllFilesAtPath:(NSString *)path{
    _fileManager = [NSFileManager defaultManager];
    NSArray * fileList = [_fileManager contentsOfDirectoryAtPath:path error:NULL];
    NSLog(@"%@", fileList);
}

+(void)NXDisplayAllFilesAtPath:(NSString *)path filterByExtension:(NSString *)extension{
    _fileManager = [NSFileManager defaultManager];
    NSArray * fileList = [_fileManager contentsOfDirectoryAtPath:path error:NULL];
//    NSString * predicate = [NSString stringWithFormat:@"self ENDSWITH '.%@'", extension];
//    NSArray * pngFileList = [fileList filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:predicate]];
//    NSLog(@"%@", pngFileList);
    for(NSString* file in fileList){
        if([[file pathExtension] isEqualToString:extension])
            NSLog(@"%@", file);
    }
}

+(void)NXDeepSearch:(NSString *)path {
    _fileManager = [NSFileManager defaultManager];
    NSString * file;
    NSDirectoryEnumerator * enumerator = [_fileManager enumeratorAtPath:path];
    while(file=[enumerator nextObject]){
        NSLog(@"%@", file);
    }
}

@end
