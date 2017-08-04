//
//  GlobalQueueOperation.h
//  Sinllia_iPhone2.0
//
//  Created by 王声远 on 15/6/15.
//  Copyright (c) 2015年 Daisy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GlobalQueueBlock)(dispatch_block_t block);

@interface GlobalQueueOperation : NSObject

/**
 *  全局队列：异步、并发、没有顺序、速度快
 *
 *  @param block 代码块
 */
void doInDisPatchWithConcurrent(dispatch_block_t block);

/**
 *  全局队列：异步、串行、顺序执行、速度慢
 *
 *  @param block 代码块
 */
void doInDispatchSerialWith(dispatch_block_t block);

/**
 *  主线程执行
 *
 *  @param block 代码块
 */
void doInMain(dispatch_block_t block);

//获取串行异步线程
dispatch_queue_t getSerialThread();

//获取并发异步线程
dispatch_queue_t getConCurrentThread();

@end
