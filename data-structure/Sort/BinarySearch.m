//
//  BinarySearch.m
//  Sort
//
//  Created by Ankui on 8/16/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BinarySearch.h"

@implementation BinarySearch
+ (NSInteger)indexOf:(NSArray *)array value:(id)value {
    if (array.count == 0) { return -1; }
    NSUInteger begin = 0;
    NSUInteger end = array.count;
    while (begin < end) {
        NSUInteger mid = (begin + end) >> 1;
//        NSUInteger mid = begin + ((end - begin) >> 1);
        if ([value integerValue] < [array[mid] integerValue]) {
            end = mid;
        } else if ([value integerValue] > [array[mid] integerValue]) {
            begin = mid + 1;
        } else {
            return mid;
        }
    }
    return -1;
}
@end
