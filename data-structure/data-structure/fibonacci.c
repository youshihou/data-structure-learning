//
//  fibonacci.c
//  data-structure
//
//  Created by Ankui on 7/1/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "fibonacci.h"

int fibonacci(int n) {
    if (n <= 1) { return n; }
    
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int fibonacci_(int n) {
    if (n <= 1) { return n; }
    
    // 0  1  2  3  4  5  6  7 ...n
    // 0, 1, 1, 2, 3, 5, 8, 13, ...
    int first = 0;
    int second = 1;
    for (int i = 0; i < n - 1; i++) {
        second = first + second;
        first = second - first;
        
//        int sum = first + second;
//        first = second;
//        second = sum;
    }
    return second;
}
