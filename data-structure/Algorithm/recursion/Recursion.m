//
//  Recursion.m
//  Algorithm
//
//  Created by Ankui on 9/12/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "Recursion.h"

@implementation Recursion
// MARK: - Fibonacci
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


// MARK: - ClimbStairs
+ (NSInteger)climbStairs1:(NSInteger)n {
    if (n <= 2) { return n; }
    return [self climbStairs:n - 1] + [self climbStairs:n - 2];
}

+ (NSInteger)climbStairs:(NSInteger)n {
    if (n <= 2) { return n; }
    NSInteger first = 1;
    NSInteger second = 2;
    for (NSInteger i = 3; i <= n; i++) {
        second = first + second;
        first = second - first;
    }
    return second;
}


// MARK: - Hanoi
+ (void)hanoi:(NSInteger)n a:(NSString *)p1 b:(NSString *)p2 c:(NSString *)p3 {
    if (n == 1) {
        [self _move:n from:p1 to:p3];
        return;
    }
    
    [self hanoi:n - 1 a:p1 b:p3 c:p2];
    [self _move:n from:p1 to:p3];
    [self hanoi:n - 1 a:p2 b:p1 c:p3];
}
+ (void)_move:(NSInteger)n from:(NSString *)from to:(NSString *)to {
    NSLog(@"Move %zd from %@ to %@", n, from, to);
}


// MARK: - TailCall
+ (NSInteger)facttorial1:(NSInteger)n {
    if (n <= 1) { return n; }
    return n * [self facttorial:n - 1];
}

+ (NSInteger)facttorial:(NSInteger)n {
    return [self _facttorial:n result:1];
}
+ (NSInteger)_facttorial:(NSInteger)n result:(NSInteger)result {
    if (n <= 1) { return result; }
    return [self _facttorial:n - 1 result:result * n];
}


+ (NSInteger)fib1:(NSInteger)n {
    if (n <= 2) { return 1; }
    return [self fib1:n - 1] + [self fib1:n - 2];
}

+ (NSInteger)fib:(NSInteger)n {
    return [self _fib:n first:1 second:1];
}
+ (NSInteger)_fib:(NSInteger)n first:(NSInteger)first second:(NSInteger)second {
    if (n <= 1) { return first; }
    return [self _fib:n - 1 first:second second:first + second];
}
@end
