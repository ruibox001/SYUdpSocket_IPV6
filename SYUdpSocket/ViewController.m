//
//  ViewController.m
//  SYUdpSocket
//
//  Created by 王声远 on 2017/6/2.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "ViewController.h"
#import "SYUdpSocket.h"
#import "IpTool.h"

@interface ViewController ()<SYUdpSocketDelegate>

@property (nonatomic,strong) SYUdpSocket *udpSocket;

@property (weak, nonatomic) IBOutlet UITextView *showMessageTextView;
@property (weak, nonatomic) IBOutlet UITextField *remotePortTextField;
@property (weak, nonatomic) IBOutlet UITextField *remoteIpTextField;
@property (weak, nonatomic) IBOutlet UITextField *sendMsgTextField;
@property (weak, nonatomic) IBOutlet UITextField *localPortTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.showMessageTextView.userInteractionEnabled = NO;
    self.localPortTextField.text = @"5000";
    self.remoteIpTextField.text = @"www.anody.com.cn";
    self.remotePortTextField.text = @"33333";
}

- (IBAction)clearReceverData:(UIButton *)sender {
    self.showMessageTextView.text = @"";
}

- (IBAction)sendMessage:(UIButton *)sender {
    if (self.udpSocket) {
        //获取发送内容
        NSString *msg = self.sendMsgTextField.text;
        NSData *sData = nil;
        if (msg.length == 0) {
            //            [self showAlertWithMessage:@"请先输入发送内容"];
            //            return;
            sData = [self loginServerAgreetMent];
        }
        else {
            sData = [msg dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        //获取对方IP
        NSString *ip = self.remoteIpTextField.text;
        if (ip.length == 0) {
            [self showAlertWithMessage:@"请先输入对方iP"];
            return;
        }
        
        //获取对方端口
        NSString *port = self.remotePortTextField.text;
        if (port.length == 0) {
            [self showAlertWithMessage:@"请先输入对方端口"];
            return;
        }
        int p = [port intValue];
        [self.udpSocket udpSendDatas:sData ip:ip port:p];
        [self.view endEditing:YES];
    }
}

- (IBAction)bindClick:(UIButton *)sender {
    if (!self.udpSocket) {
        NSString *port = self.localPortTextField.text;
        if (port.length == 0) {
            [self showAlertWithMessage:@"请先输入绑定端口"];
            return;
        }
        
        int p = [port intValue];
        self.udpSocket = [[SYUdpSocket alloc] initUdpSocketWithMyPort:p];
        self.udpSocket.delegate = self;
        [self.view endEditing:YES];
        
        NSString *ip = [IpTool getProperIPWithAddress:@"www.anody.com.cn" port:33333];
        SLOG(@"IP: %@",ip);
        self.remoteIpTextField.text = ip;// @"fe80::216:3eff:fe00:2f09";
    }
    else
    {
        [self showAlertWithMessage:@"请先解绑"];
    }
}

- (IBAction)unBindClick:(UIButton *)sender {
    if (self.udpSocket) {
        [self.udpSocket closeUdp];
        self.udpSocket = nil;
    }
    else
    {
        [self showAlertWithMessage:@"已经解绑"];
    }
}

- (void)udpSocket:(SYUdpSocket *)udpSocket receverData:(NSData *)data remote:(NSString *)address {
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *s = [NSString stringWithFormat:@"收到来自：%@ > \n%@ \nlength=%lu",address,msg,(unsigned long)data.length];
    self.showMessageTextView.text = s;
}

//弹出对话框
- (void)showAlertWithMessage:(NSString *)msg
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:alertAction];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

- (NSData *) loginServerAgreetMent {
    
    Byte buf[] = {238, 0,0,0,0,0,0,  0,0,0,0,0,0, 84,0,0,0,  0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,0,0,0,221};
    
    for (int i = 0; i < 6; i++) {
        buf[i + 1] = i;
        buf[i + 7] = i+6;
    }
    return [NSData dataWithBytes:buf length:40];
}

@end
