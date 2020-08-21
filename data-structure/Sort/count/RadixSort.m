//
//  RadixSort.m
//  Sort
//
//  Created by Ankui on 8/20/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "RadixSort.h"

@implementation RadixSort
- (void)sorting {
    NSInteger count = _array.count;
    NSInteger max = [_array.firstObject integerValue];
    for (NSInteger i = 0; i < count; i++) {
        NSInteger value = [_array[i] integerValue];
        if (max < value) {
            max = value;
        }
    }
    
    for (NSInteger divider = 1; divider <= max; divider *= 10) {
        [self _countingSort:divider];
    }
}
- (void)_countingSort:(NSInteger)divider {
    NSInteger count = _array.count;
    NSInteger len = 10; // 0 ~ 9
    NSMutableArray *cnts = [NSMutableArray arrayWithCapacity:len];
    for (NSInteger i = 0; i < len; i++) {
        [cnts addObject:@0];
    }
    for (NSInteger i = 0; i < count; i++) {
        NSInteger idx = [_array[i] integerValue] / divider % 10;
        NSInteger value = [cnts[idx] integerValue];
        cnts[idx] = @(++value);
    }
    
    for (NSInteger i = 1; i < cnts.count; i++) {
        NSInteger value = [cnts[i] integerValue] + [cnts[i - 1] integerValue];
        cnts[i] = @(value);
    }
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        [result addObject:@0];
    }
    for (NSInteger i = count - 1; i >= 0; i--) {
        NSInteger idx = [_array[i] integerValue] / divider % 10;
        NSInteger value = [cnts[idx] integerValue] - 1;
        cnts[idx] = @(value);
        result[value] = _array[i];
    }
    _array = result;
}

@end
