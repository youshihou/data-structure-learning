//
//  ShellSort.m
//  Sort
//
//  Created by Ankui on 8/18/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "ShellSort.h"

@implementation ShellSort
- (void)sorting {
    NSArray *steps = [self _steps];
    for (NSNumber *s in steps) {
        [self _sort:s.integerValue];
    }
}
- (void)_sort:(NSInteger)step {
    for (NSInteger col = 0; col < step; col++) {
        // [col, col + step, col + 2*step, col + 3*step, ...)
        for (NSInteger begin = col + step; begin < _array.count; begin += step) {
            NSInteger cur = begin;
            while (cur > col && [self cmp:cur with:cur - step] < 0)  {
                [self swap:cur with:cur - step];
                cur -= step;
            }
        }
    }
}
- (NSArray *)_steps {
    NSMutableArray *array = [NSMutableArray array];
    NSInteger step = _array.count;
    while ((step >>= 1) > 0) {
        [array addObject:@(step)];
    }
    return [array copy];
}
- (NSArray *)_steps2 {
    NSMutableArray *array = [NSMutableArray array];
    NSInteger k = 0, step = 0;
    while (true) {
        if (k % 2 == 0) {
            NSInteger p = pow(2, k >> 1);
            step = 1 + 9 * (p * p - p);
        } else {
            NSInteger p1 = pow(2, (k - 1) >> 1);
            NSInteger p2 = pow(2, (k + 1) >> 1);
            step = 1 + 8 * p1 * p2 - 6 * p2;
        }
        if (step >= _array.count) { break; }
        [array insertObject:@(step) atIndex:0];
        k++;
    }
    
    return [array copy];
}
@end
