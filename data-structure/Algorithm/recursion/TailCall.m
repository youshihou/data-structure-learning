//
//  TailCall.m
//  Algorithm
//
//  Created by Ankui on 9/10/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "TailCall.h"

@implementation TailCall
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
