//
//  main.m
//  Algorithm
//
//  Created by Ankui on 9/8/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "Fibonacci.h"
#import "ClimbStairs.h"
#import "Hanoi.h"

void testFib(void) {
    Fibonacci *fib = [[Fibonacci alloc] init];
    NSInteger f0 = [fib fib0:10];
    NSInteger f1 = [fib fib1:10];
    NSInteger f2 = [fib fib2:10];
    NSInteger f3 = [fib fib3:10];
    NSInteger f4 = [fib fib4:10];
    NSInteger f = [fib fib:10];
    NSLog(@"%zd %zd %zd %zd %zd %zd", f0, f1, f2, f3, f4, f);
}
void testCli(void) {
    NSInteger n1 = [ClimbStairs climbStairs1:4];
    NSInteger n = [ClimbStairs climbStairs:4];
    NSLog(@"%zd %zd", n1, n);
}
void testHanoi(void) {
//    [Hanoi hanoi:1 a:@"A" b:@"B" c:@"C"];
    [Hanoi hanoi:3 a:@"A" b:@"B" c:@"C"];
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        testFib();
//        testCli();
        testHanoi();
    }
    return 0;
}
