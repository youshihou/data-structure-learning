//
//  main.m
//  Algorithm
//
//  Created by Ankui on 9/8/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "Recursion.h"
#import "BackTracking.h"
#import "BackTracking1.h"
#import "BackTracking2.h"
#import "Greedy.h"
#import "DivideConquer.h"

void testFib(void) {
    Recursion *fib = [[Recursion alloc] init];
    NSInteger f0 = [fib fib0:10];
    NSInteger f1 = [fib fib1:10];
    NSInteger f2 = [fib fib2:10];
    NSInteger f3 = [fib fib3:10];
    NSInteger f4 = [fib fib4:10];
    NSInteger f = [fib fib:10];
    NSLog(@"%zd %zd %zd %zd %zd %zd", f0, f1, f2, f3, f4, f);
}
void testCli(void) {
    NSInteger n1 = [Recursion climbStairs1:4];
    NSInteger n = [Recursion climbStairs:4];
    NSLog(@"%zd %zd", n1, n);
}
void testHanoi(void) {
//    [Recursion hanoi:1 a:@"A" b:@"B" c:@"C"];
    [Recursion hanoi:3 a:@"A" b:@"B" c:@"C"];
}
void testTailCall(void) {
    NSInteger n1 = [Recursion facttorial:4];
    NSInteger n = [Recursion facttorial:4];
    NSLog(@"%zd %zd", n1, n);
    NSInteger n2 = [Recursion fib1:10];
    NSInteger n3 = [Recursion fib:10];
    NSLog(@"%zd %zd", n2, n3);
}
void testPlaceQueens(void) {
//    BackTracking *bt = [[BackTracking alloc] init];
//    [bt placeQueens:8];
//    BackTracking1 *bt1 = [[BackTracking1 alloc] init];
//    [bt1 placeQueens:8];
    BackTracking2 *bt2 = [[BackTracking2 alloc] init];
    [bt2 place8Queens];
}
void testGreedy(void) {
//    [Greedy pirate];
    
    NSArray *faces = @[@25, @10, @5, @1];
////    faces = @[@25, @20, @5, @1];
    [Greedy coinChange:faces total:41];
    
//    [Greedy knapsack];
}
void testDivideConquer(void) {
    NSArray *array = @[@-2, @1, @-3, @4, @-1, @2, @1, @-5, @4];
    NSInteger max = [DivideConquer maxSubarray:array];
    NSLog(@"%zd", max);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        testFib();
//        testCli();
//        testHanoi();
//        testTailCall();
//        testPlaceQueens();
        testGreedy();
//        testDivideConquer();
    }
    return 0;
}
