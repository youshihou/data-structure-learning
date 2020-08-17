//
//  QuickSort.m
//  Sort
//
//  Created by Ankui on 8/16/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "QuickSort.h"

@implementation QuickSort
- (void)sorting {
    [self _sort:0 end:_array.count];
}
- (void)_sort:(NSInteger)begin end:(NSInteger)end {
    if (end - begin < 2) { return; }
    NSInteger mid = [self _pivotIndex:begin end:end];
    [self _sort:begin end:mid];
    [self _sort:mid + 1 end:end];
}
- (NSInteger)_pivotIndex:(NSInteger)begin end:(NSInteger)end {
    id pivot = _array[begin];
    end--;
    while (begin < end) {
        while (begin < end) {
            if ([self cmpElement:pivot with:_array[end]] < 0) {
                end--;
            } else {
                _array[begin++] = _array[end];
                break;
            }
        }
        while (begin < end) {
            if ([self cmpElement:pivot with:_array[begin]] > 0) { // CARE!!! >
                begin++;
            } else {
                _array[end--] = _array[begin];
                break;
            }
        }
    }
    _array[begin] = pivot;
    return begin;
}
@end
