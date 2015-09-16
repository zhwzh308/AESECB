//
//  MLCrypto.h
//  AESECB
//
//  Created by Wenzhong on 2015-05-05.
//  Copyright (c) 2015 Wenzhong. All rights reserved.
//

static inline char itoh(int i);

#import <Foundation/Foundation.h>

@interface MLCrypto : NSObject

+ (NSData *)keygen128;
NSString *NSDataToHex(NSData *data);
+ (NSData *)cipherData:(NSData *)data key:(NSData *)key;
+ (NSData *)decipherData:(NSData *)data key:(NSData *)key;

@end
