//
//  MergeSort.m
//  Sort
//
//  Created by Ankui on 8/16/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "MergeSort.h"

@interface MergeSort () {
    NSMutableArray *_left;
}
@end

@implementation MergeSort
- (instancetype)init {
    if (self = [super init]) {
        _left = [NSMutableArray array];
    }
    return self;
}

- (void)sorting {
    [self _sort:0 end:_array.count];
}
- (void)_sort:(NSInteger)begin end:(NSInteger)end {
    if (end - begin < 2) { return; }
    NSInteger mid = (begin + end) >> 1;
    [self _sort:begin end:mid];
    [self _sort:mid end:end];
    [self _merge:begin mid:mid end:end];
}
- (void)_merge:(NSInteger)begin mid:(NSInteger)mid end:(NSInteger)end {
    NSInteger li = 0, le = mid - begin;
    NSInteger ri = mid, re = end;
    NSInteger ai = begin; // CARE!!! is begin NOT 0
    for (NSInteger i = li; i < le; i++) { 
        _left[i] = _array[begin + i]; // CARE!!! is begin + i NOT i
    }
    
    while (li < le) {
        if (ri < re && [self cmpElement:_array[ri] with:_left[li]] < 0) { // CARE!!!
            _array[ai++] = _array[ri++];
        } else {
            _array[ai++] = _left[li++];
        }
    }
}
@end
