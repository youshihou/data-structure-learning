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


@implementation InsertionSort1

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
