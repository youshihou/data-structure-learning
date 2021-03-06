//
//  BackTracking.m
//  Algorithm
//
//  Created by Ankui on 9/12/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BackTracking.h"

@interface BackTracking () {
    NSMutableArray *_cols;
    NSInteger _ways;
}
@end

@implementation BackTracking
- (void)placeQueens:(NSInteger)n {
    if (n < 1) { return; }
    _cols = [NSMutableArray array];
    for (NSInteger i = 0; i < n; i++) {
        [_cols addObject:@0];
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
    for (NSInteger col = 0; col < _cols.count; col++) {
        if ([self _isValid:row col:col]) {
            _cols[row] = @(col);
            [self _place:row + 1];
        }
    }
}
- (BOOL)_isValid:(NSInteger)row col:(NSInteger)col {
    for (NSInteger i = 0; i < row; i++) {
        NSInteger cur = [_cols[i] integerValue];
        if (cur == col) {
            printf("[%zd][%zd] = false\n", row, col);
            return NO;
        }
        if (row - i == labs(col - cur)) {
            printf("[%zd][%zd] = false\n", row, col);
            return NO;
        }
    }
    printf("[%zd][%zd] = true\n", row, col);
    return YES;
}
- (void)_show {
    for (NSInteger row = 0; row < _cols.count; row++) {
        for (NSInteger col = 0; col < _cols.count; col++) {
            if ([_cols[row] integerValue] == col) {
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
