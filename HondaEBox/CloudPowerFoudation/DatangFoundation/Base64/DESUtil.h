//
//  DESUtil.h
//  eBox
//
//  Created by HsiehWangKuei on 14-3-25.
//  Copyright (c) 2014年 谢旺贵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DESUtil : NSObject

// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;

@end
