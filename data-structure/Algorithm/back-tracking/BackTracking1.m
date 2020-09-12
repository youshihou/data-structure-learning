//
//  BackTracking1.m
//  Algorithm
//
//  Created by Ankui on 9/12/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BackTracking1.h"

@interface BackTracking1 () {
    NSMutableArray *_queens;
    NSMutableArray *_cols;
    NSMutableArray *_leftTop;
    NSMutableArray *_rightTop;
    NSInteger _ways;
}
@end

@implementation BackTracking1
- (void)placeQueens:(NSInteger)n {
    if (n < 1) { return; }
    _queens = [NSMutableArray array];
    _cols = [NSMutableArray array];
    for (NSInteger i = 0; i < n; i++) {
        [_queens addObject:@0];
        [_cols addObject:@NO];
    }
    _leftTop = [NSMutableArray array];
    _rightTop = [NSMutableArray array];
    NSInteger count = (n << 1) - 1;
    for (NSInteger i = 0; i < count; i++) {
        [_leftTop addObject:@NO];
        [_rightTop addObject:@NO];
    }
    [self _place:0];
    NSLog(@"%zd queens there are %zd place ways", n, _ways);
}

- (void)_place:(NSInteger)row {
    if (row == _cols.count) {
        _ways++;
        [self _show];
        return;
    }
    NSInteger count = _cols.count;
    for (NSInteger col = 0; col < count; col++) {
        if ([_cols[col] boolValue]) { continue; }
        NSInteger leftIdx = row - col + count - 1;
        if ([_leftTop[leftIdx] boolValue]) { continue; }
        NSInteger rightIdx = row + col;
        if ([_rightTop[rightIdx] boolValue]) { continue; }
        
        _queens[row] = @(col);
        _cols[col] = @YES;
        _leftTop[leftIdx] = @YES;
        _rightTop[rightIdx] = @YES;
        [self _place:row + 1];
        _cols[col] = @NO;
        _leftTop[leftIdx] = @NO;
        _rightTop[rightIdx] = @NO;
    }
}
- (void)_show {
    NSInteger count = _queens.count;
    for (NSInteger row = 0; row < count; row++) {
        for (NSInteger col = 0; col < count; col++) {
            if ([_queens[row] integerValue] == col) {
                printf("1 ");
            } else {
                printf("0 ");
            }
        }
        printf("\n");
    }
    printf("---------------\n");
}
@end
