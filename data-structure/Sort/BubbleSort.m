//
//  BubbleSort.m
//  Sort
//
//  Created by Ankui on 8/16/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BubbleSort.h"

@implementation BubbleSort
- (void)sorting {
    for (NSInteger end = _array.count - 1; end > 0; end--) {
        for (NSUInteger begin = 1; begin <= end; begin++) {
            if ([self cmp:begin with:begin - 1] < 0) {
                [self swap:begin with:begin - 1];
            }
        }
    }
}
@end








@implementation BubbleSort2
- (void)sorting {
    for (NSInteger end = _array.count - 1; end > 0; end--) {
        BOOL sorted = YES;
        for (NSUInteger begin = 1; begin <= end; begin++) {
            if ([self cmp:begin with:begin - 1] < 0) {
                [self swap:begin with:begin - 1];
                sorted = NO;
            }
        }
        if (sorted) { break; }
    }
}
@end








@implementation BubbleSort3
- (void)sorting {
    for (NSInteger end = _array.count - 1; end > 0; end--) {
        NSUInteger sortedIdx = 1;
        for (NSUInteger begin = 1; begin <= end; begin++) {
            if ([self cmp:begin with:begin - 1] < 0) {
                [self swap:begin with:begin - 1];
                sortedIdx = begin;
            }
        }
        end = sortedIdx;
    }
}
@end
