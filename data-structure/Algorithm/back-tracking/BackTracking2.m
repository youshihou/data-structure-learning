//
//  BackTracking2.m
//  Algorithm
//
//  Created by Ankui on 9/12/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BackTracking2.h"

@interface BackTracking2 () {
    NSMutableArray *_queens;
    Byte _cols;
    short _leftTop;
    short _rightTop;
    NSInteger _ways;
}
@end

@implementation BackTracking2
- (void)place8Queens {
    _queens = [NSMutableArray array];
    for (NSInteger i = 0; i < 8; i++) {
        [_queens addObject:@0];
    }
    [self _place:0];
    NSLog(@"8 queens there are %zd place ways", _ways);
}

- (void)_place:(NSInteger)row {
    if (row == 8) {
        _ways++;
        [self _show];
        return;
    }
    for (NSInteger col = 0; col < 8; col++) {
        NSInteger cv = 1 << col;
        if ((_cols & cv) != 0) { continue; }
        NSInteger lv = 1 << (row - col + 7);
        if ((_leftTop & lv) != 0) { continue; }
        NSInteger rv = 1 << (row + col);
        if ((_rightTop & rv) != 0) { continue; }
        
        _queens[row] = @(col);
        _cols |= cv;
        _leftTop |= lv;
        _rightTop |= rv;
        [self _place:row + 1];
        _cols &= ~cv;
        _leftTop &= ~lv;
        _rightTop &= ~rv;
    }
}
- (void)_show {
    for (NSInteger row = 0; row < 8; row++) {
        for (NSInteger col = 0; col < 8; col++) {
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
