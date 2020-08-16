//
//  main.m
//  Sort
//
//  Created by Ankui on 8/16/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BubbleSort.h"
#import "SelectionSort.h"
#import "HeapSort.h"

void testSorts(NSArray *arrray, NSArray<Sort *> *sorts) {
    for (Sort *sort in sorts) {
        [sort sort:[arrray mutableCopy]];
    }
    
    NSArray *sorteds = [sorts sortedArrayUsingComparator:^NSComparisonResult(Sort *obj1, Sort *obj2) {
        NSInteger max = 1000000;
        NSInteger result = (obj1->_time * max - obj2->_time * max);
        if (result) { return result; }
        result = obj1->_cmpCount - obj2->_cmpCount;
        if (result) { return result; }
        return obj1->_swapCount - obj2->_swapCount;
    }];
    for (Sort *s in sorteds) {
        NSLog(@"%@", s);
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *array = [NSMutableArray array];
        NSUInteger max = 1000;
        for (NSUInteger i = 0; i < max; i++) {
            int n = arc4random() % max;
            NSNumber *number = [NSNumber numberWithInt:n];
            [array addObject:number];
        }
        NSArray *sorts = @[
            [BubbleSort sort],
            [BubbleSort2 sort],
            [BubbleSort3 sort],
            [SelectionSort sort],
            [HeapSort sort],
        ];
        testSorts(array, sorts);
    }
    return 0;
}
