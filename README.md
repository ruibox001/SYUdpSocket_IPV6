# SFHttp

[![Build Status](https://travis-ci.org/robbiehanson/CocoaHTTPServer.svg)](https://travis-ci.org/robbiehanson/CocoaHTTPServer)

一、SFHttp 是基于AFNetworking的封装的网络请求类，主要扩展如下功能：<br>
1、请求采用链试调用<br>
2、网络请求内置YYModel的解析模型<br>
3、自动解析传入的模型并返回<br>
4、网络变化监听<br>

</p>

---

二、请求代码示例<br>
1、get请求调用：<br>

            get
            .url(@"http://www.weather.com.cn/data/sk/101110101.html").addPara(@{@"userId":@"111"})
            .addPara(@{@"userName":@"222"}).resolve(@"weatherinfo",@"MyModel",^(id model){
                if ([model isKindOfClass:[MyModel class]]) {
                    NSLog(@"\n解析返回：%@",model);
                }
                else if ([model isKindOfClass:[NSArray class]]){
                    for (MyModel *p in model) {
                        NSLog(@"\n数组解析返回：%@",p);
                    }
                }
            }).start();           

2、post请求调用：<br>

            post
            .url(@"http://www.weather.com.cn/data/sk/101110101.html")
            .addPara(@{@"userId":@"111"})
            .addPara(@{@"userName":@"222"})
            .resolve(@"weatherinfo",@"MyModel",^(id model){
                if ([model isKindOfClass:[MyModel class]]) {
                    NSLog(@"\n解析返回：%@",model);
                }
                else if ([model isKindOfClass:[NSArray class]]){
                    for (MyModel *p in model) {
                        NSLog(@"\n数组解析返回：%@",p);
                    }
                }
            })
            .start();

三、请求返回信息<br>
              
            请求信息:
            URL: http://www.weather.com.cn/data/sk/101110101.html
            参数: {
                userId = 111;
                userName = 222;
            }
            JSON: {
                "weatherinfo" : {
                    "temp" : "20",
                    "time" : "17:00",
                    "WD" : "西南风",
                    "qy" : "970",
                    "isRadar" : "1",
                    "cityid" : "101110101",
                    "city" : "西安",
                    "WS" : "1级",
                    "WSE" : "1",
                    "Radar" : "JC_RADAR_AZ9290_JB",
                    "njd" : "暂无实况",
                    "SD" : "14%",
                    "rain" : "0"
                }
            }
            
            
解析返回：

            17:00 - 西南风 - 西安 - 暂无实况 - 20

# 安装

###  CocoaPods

        1. 在 `Podfile` 中添加 `pod 'SFHttp'` <br>
        2. 执行 `pod install` 或 `pod update`

### 手动安装

        1. 下载`SFHttp`文件夹内的所有内容。
        2. 将`SFHttp`内的源文件添加(拖放)到你的工程。
        

