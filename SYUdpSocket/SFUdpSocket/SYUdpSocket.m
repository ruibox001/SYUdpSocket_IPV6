//
//  UdpSocket.m
//  SYUdpSocket
//
//  Created by 王声远 on 2017/6/2.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SYUdpSocket.h"
#import "AsyncUdpSocket.h"
#import "IpTool.h"

@interface SYUdpSocket()<AsyncUdpSocketDelegate>

@property (nonatomic,strong) AsyncUdpSocket *mSocket;

@end

@implementation SYUdpSocket

#pragma mark - 初始化网络

- (instancetype)initUdpSocketWithMyPort:(int)port
{
    self = [super init];
    if (self) {
        
        NSError *error = nil;
        
        BOOL isIpv6 = [IpTool isIpv6];
        self.mSocket = [[AsyncUdpSocket alloc] initWithDelegate:self isIpv6:isIpv6];
        
        if (![self.mSocket bindToPort:port error:&error]) {
            SLOG(@"UDP -> Error starting server (bind): %@", error);
            return self;
        }
        if (![self.mSocket enableBroadcast:YES error:&error]) {
            SLOG(@"UDP -> Error enableBroadcast (bind): %@", error);
            return self;
        }
        [self.mSocket receiveWithTimeout:-1 tag:0];
        SLOG(@"UDP初始化成功：本地的端口：%d > ipv6:%d",port,isIpv6);
        
    }
    return self;
}

#pragma mark - 接收到数据的方法
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock
     didReceiveData:(NSData *)data
            withTag:(long)tag
           fromHost:(NSString *)host
               port:(UInt16)port {
    
    SLOG(@"收到数据：host=%@",host);
    
    /*
     Byte *chardata = (Byte *)[data bytes];
     for (int i = 0; i < 40; i ++) {
     LOG(@"%d -> %d",i,chardata[i]);
     }
     */
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(udpSocket:receverData:remote:)]) {
        [self.delegate udpSocket:self receverData:data remote:host];
    }
    [sock receiveWithTimeout:-1 tag:0];
    return YES;
}

#pragma mark - 关闭的代理方法
- (void)onUdpSocketDidClose:(AsyncUdpSocket *)sock
{
    SLOG(@"UDP关闭了: socket=%@ ",sock);
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    SLOG(@"UDP发送成功了: socket=%@ ",sock);
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    SLOG(@"UDP发送失败了: socket=%@ error: %@",sock,error);
}

- (void)closeUdp
{
    if (self.mSocket != nil) {
        [self.mSocket close];
        self.mSocket = nil;
    }
}

#pragma mark - 发送的代理方法
- (void)udpSendDatas:(NSData *)datas ip:(NSString *)ip port:(int)port
{
    dispatch_async(dispatch_get_main_queue(),^{
        if (self.mSocket) {
            SLOG(@"UDP发送开始: ip=%@ port: %d",ip,port);
            [self.mSocket sendData:datas toHost:ip port:port withTimeout:-1 tag:0];
        }
    });
}

@end
