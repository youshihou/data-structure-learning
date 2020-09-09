//
//  ClimbStairs.m
//  Algorithm
//
//  Created by Ankui on 9/9/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "ClimbStairs.h"

@implementation ClimbStairs
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
@end
