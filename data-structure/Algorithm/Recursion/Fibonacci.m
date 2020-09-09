//
//  Fibonacci.m
//  Algorithm
//
//  Created by Ankui on 9/9/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "Fibonacci.h"

@implementation Fibonacci
- (NSInteger)fib0:(NSInteger)num {
    if (num <= 2) { return 1; }
    return [self fib0:num - 1] + [self fib0:num - 2];
}

- (NSInteger)fib1:(NSInteger)num {
    if (num <= 2) { return 1; }
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < num + 1; i++) {
        array[i] = @0;
    }
    array[1] = array[2] = @1;
    return [self _fib1:num array:array];
}
- (NSInteger)_fib1:(NSInteger)num array:(NSMutableArray *)array {
    if ([array[num] integerValue] == 0) {
        array[num] = @([self _fib1:num - 1 array:array] + [self _fib1:num - 2 array:array]);
    }
    return [array[num] integerValue];
}
- (NSInteger)fib2:(NSInteger)num {
    return 0;
}
@end
