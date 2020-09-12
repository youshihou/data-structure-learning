//
//  Recursion.h
//  Algorithm
//
//  Created by Ankui on 9/12/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Recursion : NSObject
- (NSInteger)fib0:(NSInteger)num;
- (NSInteger)fib1:(NSInteger)num;
- (NSInteger)fib2:(NSInteger)num;
- (NSInteger)fib3:(NSInteger)num;
- (NSInteger)fib4:(NSInteger)num;
- (NSInteger)fib:(NSInteger)num;

+ (NSInteger)climbStairs1:(NSInteger)n;
+ (NSInteger)climbStairs:(NSInteger)n;

+ (void)hanoi:(NSInteger)n a:(NSString *)p1 b:(NSString *)p2 c:(NSString *)p3;


+ (NSInteger)facttorial1:(NSInteger)n;
+ (NSInteger)facttorial:(NSInteger)n;

+ (NSInteger)fib1:(NSInteger)n;
+ (NSInteger)fib:(NSInteger)n;
@end

NS_ASSUME_NONNULL_END
