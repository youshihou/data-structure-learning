//
//  DivideConquer.m
//  Algorithm
//
//  Created by Ankui on 9/13/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "DivideConquer.h"

@implementation DivideConquer
+ (NSInteger)maxSubarray1:(NSArray *)array {
    if (array.count == 0) { return 0; }
    NSInteger max = INT_MIN;
    NSInteger sum = 0;
    for (NSInteger begin = 0; begin < array.count; begin++) {
        for (NSInteger end = begin; end < array.count; end++) {
            sum = 0;
            for (NSInteger i = begin; i <= end; i++) {
                sum += [array[i] integerValue];
            }
            max = MAX(max, sum);
        }
    }
    return max;
}

+ (NSInteger)maxSubarray:(NSArray *)array {
    if (array.count == 0) { return 0; }
    NSInteger max = INT_MIN;
    NSInteger sum = 0;
    for (NSInteger begin = 0; begin < array.count; begin++) {
        sum = 0;
        for (NSInteger end = begin; end < array.count; end++) {
            sum += [array[end] integerValue];
            max = MAX(max, sum);
        }
    }
    return max;
}
@end
