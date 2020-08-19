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
    NSInteger max = [_array.firstObject integerValue];
    for (NSInteger i = 1; i < count; i++) {
        NSInteger value = [_array[i] integerValue];
        if (max < value) { max = value; }
    }
    
    NSMutableArray *cnts = [NSMutableArray array];
    for (NSInteger i = 0; i < max + 1; i++) {
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
