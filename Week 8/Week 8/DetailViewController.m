//
//  DetailViewController.m
//  Week 8
//
//  Created by 김기범 on 2016. 4. 20..
//  Copyright © 2016년 김기범. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property NSInputStream *inputStream;
@property NSOutputStream *outputStream;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}




- (void)connect {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (__bridge CFStringRef)@"127.0.0.1", 8000, &readStream, &writeStream);
    
    _inputStream = (__bridge NSInputStream *)readStream;
    [_inputStream setDelegate:self];
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream open];
    
    _outputStream = (__bridge NSOutputStream *)writeStream;
    [_outputStream setDelegate:self];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream open];
}




- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    switch (eventCode) {
        case NSStreamEventHasBytesAvailable: {   // 내가 메모리를 잡아서 커널 영역에 받아진 데이터를 앱 영역으로 읽어와야
                uint8_t dataLenBuf[9];
                unsigned int len = 0;
                len = (unsigned int)[(NSInputStream *)aStream read:dataLenBuf maxLength:8];
//                dataLenBuf[len] = '\0';  // 요렇게 해야 atoi나 atol했을 때 여기까지 변환함.
                if(len) {
                    len = atoi((const char*)dataLenBuf);
                    uint8_t dataBuf[len+1];
                    len = (unsigned int)[(NSInputStream *)aStream read:dataBuf maxLength:len];
//                    dataBuf[len] = '\0';
                    if(len) {
                        self.imageView.image = [[UIImage alloc] initWithData:[NSData dataWithBytes:dataBuf length:len]];
                    } else {
                        NSLog(@"no buffer2!");
                    }
                } else {
                    NSLog(@"no buffer!");
                }
            break;
        }
        case NSStreamEventEndEncountered: {
            [self closeConnection];
            break;
        }
        case NSStreamEventHasSpaceAvailable:        {
            NSString *ackString= @"ACK";
            NSData *ackData = [ackString dataUsingEncoding:NSUTF8StringEncoding];
            uint8_t *readBytes = (uint8_t *)[ackData bytes];
            uint8_t buf[3];
            (void)memcpy(buf, readBytes, 3);
            [(NSOutputStream *)aStream write:(const uint8_t *)buf maxLength:3];
            break;
        }
        default:
            break;
    }
}



- (void)closeConnection {
    [_inputStream close];
    [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _inputStream = nil;
    [_outputStream close];
    [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _outputStream = nil;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self connect];
}




- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self closeConnection];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
