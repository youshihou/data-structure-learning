//
//  CountingSort.m
//  Sort
//
//  Created by Ankui on 8/19/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "CountingSort.h"

@implementation CountingSort
- (void)sorting {
    NSInteger count = _array.count;
    NSInteger min = [_array.firstObject integerValue];
    NSInteger max = [_array.firstObject integerValue];
    for (NSInteger i = 0; i < count; i++) {
        NSInteger value = [_array[i] integerValue];
        if (max < value) {
            max = value;
        }
        if (min > value) {
            min = value;
        }
    }
    
    NSInteger len = max - min + 1;
    NSMutableArray *cnts = [NSMutableArray arrayWithCapacity:len];
    for (NSInteger i = 0; i < len; i++) {
        [cnts addObject:@0];
    }
    for (NSInteger i = 0; i < count; i++) {
        NSInteger idx = [_array[i] integerValue] - min;
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
        NSInteger idx = [_array[i] integerValue] - min;
        NSInteger value = [cnts[idx] integerValue] - 1;
        cnts[idx] = @(value);
        result[value] = _array[i];
    }
    _array = result;
}

- (void)sorting2 {
    NSInteger count = _array.count;
    NSInteger max = [_array.firstObject integerValue];
    for (NSInteger i = 1; i < count; i++) {
        NSInteger value = [_array[i] integerValue];
        if (max < value) { max = value; }
    }
    
    NSInteger len = max + 1;
    NSMutableArray *cnts = [NSMutableArray arrayWithCapacity:len];
    for (NSInteger i = 0; i < len; i++) {
        [cnts addObject:@0];
    }
    for (NSInteger i = 0; i < count; i++) {
        NSInteger idx = [_array[i] integerValue];
        NSInteger value = [cnts[idx] integerValue];
        cnts[idx] = @(++value);
    }
    
    NSInteger idx = 0;
    for (NSInteger i = 0; i < cnts.count; i++) {
        NSInteger count = [cnts[i] integerValue];
        while (count-- > 0) {
            _array[idx++] = @(i);
        }
    }
}
@end
