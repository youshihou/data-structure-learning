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
        if (cur == col) { return NO; }
        if (row - i == labs(col - cur)) { return NO; }
    }
    return YES;
}
@end
