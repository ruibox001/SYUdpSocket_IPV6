# SYUdpSocket

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/ibireme/YYKit/master/LICENSE)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/YYKit.svg?style=flat)](http://cocoadocs.org/docsets/YYKit)&nbsp;
[![Build Status](https://travis-ci.org/ibireme/YYKit.svg?branch=master)](https://travis-ci.org/ibireme/YYKit)

iOS-Udp连接库：<br>

>1、封装Udp连接<br>
>2、IPV6支持<br>
>3、实例导读<br>

</p>

---

封装了Udp请求类，使用方便，源码开放

            @class SYUdpSocket;

            #pragma mark - 代理定义
            @protocol SYUdpSocketDelegate <NSObject>
            @optional

            - (void)udpSocket:(SYUdpSocket *)udpSocket receverData:(NSData *)data remote:(NSString *)address;

            @end

            @interface SYUdpSocket : NSObject
            #pragma mark - 代理类
            @property (nonatomic,assign) id <SYUdpSocketDelegate> delegate;

            #pragma mark - 通过本地端口初始化
            - (instancetype)initUdpSocketWithMyPort:(int)port;

            #pragma mark - 关闭udp
            - (void)closeUdp;

            #pragma mark - udp发送数据
            - (void)udpSendDatas:(NSData *)datas ip:(NSString *)ip port:(int)port;
    
# 安装

### 手动安装

        1. 下载`SYUdpSocket`文件夹内的所有内容。
        2. 将`SYUdpSocket`内的源文件添加(拖放)到你的工程。
