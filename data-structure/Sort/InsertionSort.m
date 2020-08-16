//
//  InsertionSort.m
//  Sort
//
//  Created by Ankui on 8/16/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "InsertionSort.h"

@implementation InsertionSort
- (void)sorting {
    for (NSUInteger begin = 1; begin < _array.count; begin++) {
        id e = _array[begin];
        NSInteger index = [self _search:begin];
        for (NSUInteger i = begin; i > index; i--) {
            _array[i] = _array[i - 1];
        }
//        for (NSInteger i = begin - 1; i >= index; i--) { // CARE!!! i MUST be NSInteger NOT NSUInteger
//            _array[i + 1] = _array[i];
//        }
        _array[index] = e;
    }
}
- (NSUInteger)_search:(NSUInteger)index {
    NSUInteger begin = 0;
    NSUInteger end = index;
    while (begin < end) {
        NSUInteger mid = (begin + end) >> 1;
        if ([self cmpElement:_array[index] with:_array[mid]] < 0) {
            end = mid;
        } else {
            begin = mid + 1;
        }
    }
    return begin;
}
@end


@implementation InsertionSort1
- (void)sorting {
    for (NSUInteger begin = 1; begin < _array.count; begin++) {
        NSUInteger cur = begin;
        id e = _array[cur];
        while (cur > 0 && [self cmpElement:e with:_array[cur - 1]] < 0)  { // CARE!!! cmpare element not index
            _array[cur] = _array[cur - 1];
            cur--;
        }
        _array[cur] = e;
    }
}
@end


@implementation InsertionSort2
- (void)sorting {
    for (NSUInteger begin = 1; begin < _array.count; begin++) {
        NSUInteger cur = begin;
        while (cur > 0 && [self cmp:cur with:cur - 1] < 0) {
            [self swap:cur with:cur - 1];
            cur--;
        }
    }
}
@end
