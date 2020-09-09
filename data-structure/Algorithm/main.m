//
//  main.m
//  Algorithm
//
//  Created by Ankui on 9/8/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fibonacci.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fibonacci *f = [[Fibonacci alloc] init];
        NSInteger f1 = [f fib0:10];
        NSInteger f2 = [f fib1:10];
        NSLog(@"%zd %zd", f1, f2);
    }
    return 0;
}
