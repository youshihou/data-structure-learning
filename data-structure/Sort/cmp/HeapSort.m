//
//  HeapSort.m
//  Sort
//
//  Created by Ankui on 8/16/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "HeapSort.h"

@interface HeapSort () {
    NSUInteger _heapSize;
}
@end

@implementation HeapSort
- (void)sorting {
    _heapSize = _array.count;
    [self _heapify];
    while (_heapSize > 1) {
        [self swap:0 with:--_heapSize];
        [self _siftDown:0];
    }
}

- (void)_heapify {
    for (NSInteger i = (_heapSize >> 1) - 1; i >= 0; i--) {
        [self _siftDown:i];
    }
}
- (void)_siftDown:(NSUInteger)index {
    id e = _array[index];
    NSUInteger half = _heapSize >> 1;
    while (index < half) {
        NSUInteger leftIdx = (index << 1) + 1;
        id left = _array[leftIdx];
        NSUInteger rightIdx = leftIdx + 1;
        if (rightIdx < _heapSize && [self cmpElement:_array[rightIdx] with:left] > 0) {
            left = _array[leftIdx = rightIdx];
        }
        if ([self cmpElement:e with:left] >= 0) { break; }
        _array[index] = left;
        index = leftIdx;
    }
    _array[index] = e;
}
@end
