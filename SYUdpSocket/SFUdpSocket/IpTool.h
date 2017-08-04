//
//  Network.h
//  SYUdpSocket
//
//  Created by 王声远 on 2017/8/4.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IpTool : NSObject

//判断当前网络是否是IPV6
+ (BOOL)isIpv6;

//自动根据当前IPV4/IPV6网络返回相应IPV4/IPV6的地址
+ (NSString *)getProperIPWithAddress:(NSString *)ipAddr port:(UInt32)port;

@end
