//
//  main.c
//  data-structure
//
//  Created by Ankui on 6/30/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include <stdio.h>
#include "fibonacci.h"

#include "common.h"

int main(int argc, const char * argv[]) {
    
    time_t start, end;
    start = clock();
//    start = time(NULL);
    int result = fibonacci(44);
    printf("%d\n", result);
    end = clock();
//    end = time(NULL);
    printf("%.2f ms\n", difftime(end, start));
    

    return 0;
}
