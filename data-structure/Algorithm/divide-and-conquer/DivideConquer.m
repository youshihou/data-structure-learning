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

+ (NSInteger)maxSubarray2:(NSArray *)array {
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

+ (NSInteger)maxSubarray:(NSArray *)array {
    if (array.count == 0) { return 0; }
    return [self _maxSubarray:array begin:0 end:array.count];
}
+ (NSInteger)_maxSubarray:(NSArray *)array begin:(NSInteger)begin end:(NSInteger)end {
    if (end - begin < 2) { return [array[begin] integerValue]; }
    NSInteger mid = (begin + end) >> 1;
    NSInteger leftMax = INT_MIN;
    NSInteger leftSum = 0;
    for (NSInteger i = mid - 1; i >= begin; i--) {
        leftSum += [array[i] integerValue];
        leftMax = MAX(leftMax, leftSum);
    }
    NSInteger rightMax = INT_MIN;
    NSInteger rightSum = 0;
    for (NSInteger i = mid; i < end; i++) {
        rightSum += [array[i] integerValue];
        rightMax = MAX(rightMax, rightSum);
    }
    return MAX(leftMax + rightMax,
               MAX([self _maxSubarray:array begin:begin end:mid],
                   [self _maxSubarray:array begin:mid end:end]));
}
@end
