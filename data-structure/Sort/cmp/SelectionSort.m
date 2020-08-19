//
//  SelectionSort.m
//  Sort
//
//  Created by Ankui on 8/16/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "SelectionSort.h"

@implementation SelectionSort
- (void)sorting {
    for (NSInteger end = _array.count - 1; end > 0; end--) {
        NSUInteger maxIdx = 0;
        for (NSInteger begin = 1; begin <= end; begin++) {
            if ([self cmp:maxIdx with:begin] < 0) {
                maxIdx = begin;
            }
        }
        [self swap:maxIdx with:end];
    }
}
@end
