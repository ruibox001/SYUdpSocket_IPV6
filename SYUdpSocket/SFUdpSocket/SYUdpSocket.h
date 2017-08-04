//
//  UdpSocket.m
//  SYUdpSocket
//
//  Created by 王声远 on 2017/6/2.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>

//公用日志打印LOG
#ifdef DEBUG
#define HYString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define SLOG(...) printf("%s 第%d行: %s\n", [HYString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
#define SLOG(...)
#endif

@class SYUdpSocket;

@protocol SYUdpSocketDelegate <NSObject>
@optional

- (void)udpSocket:(SYUdpSocket *)udpSocket receverData:(NSData *)data remote:(NSString *)address;

@end

@interface SYUdpSocket : NSObject

@property (nonatomic,assign) id <SYUdpSocketDelegate> delegate;

- (instancetype)initUdpSocketWithMyPort:(int)port;
- (void)closeUdp;
- (void)udpSendDatas:(NSData *)datas ip:(NSString *)ip port:(int)port;

@end
