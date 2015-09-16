//
//  MLCrypto.m
//  AESECB
//
//  Created by Wenzhong on 2015-05-05.
//  Copyright (c) 2015 Wenzhong. All rights reserved.
//

#import <CommonCrypto/CommonCryptor.h>
#import "MLCrypto.h"

static inline char itoh(int i) {
    if (i > 9) return 'A' + (i - 10);
    return '0' + i;
}

NSString *NSDataToHex(NSData *data) {
    NSUInteger i, len;
    unsigned char *buf, *bytes;
    
    len = data.length;
    bytes = (unsigned char*)data.bytes;
    buf = malloc(len*2);
    for (i=0; i<len; i++) {
        buf[i*2] = itoh((bytes[i] >> 4) & 0xF);
        buf[i*2+1] = itoh(bytes[i] & 0xF);
    }
    return [[NSString alloc] initWithBytesNoCopy:buf
                                          length:len*2
                                        encoding:NSASCIIStringEncoding
                                    freeWhenDone:YES];
}

@implementation MLCrypto

+ (NSData *)keygen128 {
    NSMutableData *key128 = [NSMutableData data];
    for (int i = 0; i < 4; ++i) {
        u_int32_t randomNumber=(arc4random());
        [key128 appendBytes:&randomNumber length:sizeof(u_int32_t)];
    }
    return key128;
}

+ (NSData *)cipherData:(NSData *)data key:(NSData *)key {
    return [self aesOperation:kCCEncrypt OnData:data key:key];
}

+ (NSData *)decipherData:(NSData *)data key:(NSData *)key {
    return [self aesOperation:kCCDecrypt OnData:data key:key];
}

+ (NSData *)aesOperation:(CCOperation)op
                  OnData:(NSData *)data
                     key:(NSData *)inKey {
    NSUInteger dataLength = [data length];
    uint8_t unencryptedData[dataLength + kCCKeySizeAES128];
    size_t unencryptedLength;
    
    CCCrypt(op,
            kCCAlgorithmAES128,
            kCCOptionECBMode,
            [inKey bytes],
            kCCKeySizeAES128,
            NULL,
            [data bytes],
            dataLength,
            unencryptedData,
            dataLength,
            &unencryptedLength);
    return [NSData dataWithBytes:unencryptedData length:unencryptedLength];
}

@end
