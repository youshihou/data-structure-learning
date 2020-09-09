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
    if (num <= 2) { return 1; }
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < num + 1; i++) {
        array[i] = @0;
    }
    array[1] = array[2] = @1;
    for (NSInteger i = 3; i <= num; i++) {
        array[i] = @([array[i - 1] integerValue] + [array[i - 2] integerValue]);
    }
    return [array[num] integerValue];
}

- (NSInteger)fib3:(NSInteger)num {
    if (num <= 2) { return 1; }
    NSMutableArray *array = [@[@1, @1] mutableCopy];
    for (NSInteger i = 3; i <= num; i++) {
        array[i % 2] = @([array[(i - 1) % 2] integerValue] + [array[(i - 2) % 2] integerValue]);
    }
    return [array[num % 2] integerValue];
}

// n % 2 == n & 1
- (NSInteger)fib4:(NSInteger)num {
    if (num <= 2) { return 1; }
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@1];
    [array addObject:@1];
    for (NSInteger i = 3; i <= num; i++) {
        array[i & 1] = @([array[(i - 1) & 1] integerValue] + [array[(i - 2) & 1] integerValue]);
    }
    return [array[num & 1] integerValue];
}

// 1 1 2 3 5 8
- (NSInteger)fib:(NSInteger)num {
    if (num <= 2) { return 1; }
    NSInteger first = 1;
    NSInteger second = 1;
    for (NSInteger i = 3; i <= num; i++) {
        second = first + second;
        first = second - first;
    }
    return second;
}
@end
