//
//  NSData+Conversion.m
//  TelinkBle
//
//  Created by Thanh Tùng on 01/10/2021.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+Conversion.h"

@implementation NSData (NSData_Conversion)

#pragma mark - String Conversion
- (NSString *)hexadecimalString
{
    /* Returns hexadecimal string of NSData. Empty string if data is empty.   */
    
    const unsigned char *dataBuffer = (const unsigned char *)[self bytes];
    
    if (!dataBuffer)
        return [NSString string];
    
    NSUInteger          dataLength  = [self length];
    NSMutableString     *hexString  = [NSMutableString stringWithCapacity:(dataLength * 2)];
    
    for (int i = 0; i < dataLength; ++i)
    {
        if (i > 0) {
            [hexString appendString:@":"];
        }
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long)dataBuffer[i]]];
    }

    return [NSString stringWithString:hexString];
}

#pragma mark - Array Conversion
- (NSArray *)toArray
{
    /* Converts NSData to NSArray of NSNumber objects representing each byte */
    
    const unsigned char *dataBuffer = (const unsigned char *)[self bytes];
    
    if (!dataBuffer)
        return [NSArray array];
    
    NSUInteger dataLength = [self length];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:dataLength];
    
    for (int i = 0; i < dataLength; ++i)
    {
        [array addObject:[NSNumber numberWithUnsignedChar:dataBuffer[i]]];
    }
    
    return [NSArray arrayWithArray:array];
}

@end
