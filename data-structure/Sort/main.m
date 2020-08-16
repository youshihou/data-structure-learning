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
#import "InsertionSort.h"
#import "BinarySearch.h"

void testSorts(NSArray *arrray, NSArray<Sort *> *sorts) {
    for (Sort *sort in sorts) {
        NSMutableArray *list = [arrray mutableCopy];
        [sort sort:list];
        assert([sort isAscOrder]);
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

void testBinarySearch(void) {
    NSArray *array = @[@2, @4, @6, @8, @10];
    assert([BinarySearch indexOf:array value:@4] == 1);
    assert([BinarySearch indexOf:array value:@2] == 0);
    assert([BinarySearch indexOf:array value:@10] == 4);
    assert([BinarySearch indexOf:array value:@56] == -1);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *array = [NSMutableArray array];
        NSUInteger max = 100;
        for (NSUInteger i = 0; i < max; i++) {
            int n = arc4random() % max;
            NSNumber *number = [NSNumber numberWithInt:n];
            [array addObject:number];
        }
        NSArray *sorts = @[
            [BubbleSort sort],
//            [BubbleSort2 sort],
//            [BubbleSort3 sort],
            [SelectionSort sort],
            [HeapSort sort],
            [InsertionSort sort],
        ];
//        testSorts(array, sorts);
        
        testBinarySearch();
    }
    return 0;
}
