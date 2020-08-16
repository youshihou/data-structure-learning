//
//  Sort.m
//  Sort
//
//  Created by Ankui on 8/16/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "Sort.h"

@interface Sort () {
    NSUInteger _cmpCount;
    NSUInteger _swapCount;
}
@end

@implementation Sort
+ (instancetype)sort:(NSMutableArray *)array {
    if (array.count == 0) { return nil; }
    Sort *s = [[self alloc] init];
    s->_array = array;
    return s;
}
- (void)sort {}

- (NSInteger)cmp:(NSUInteger)i1 with:(NSUInteger)i2 {
    _cmpCount++;
    return [_array[i1] integerValue] - [_array[i2] integerValue];
}
- (void)swap:(NSUInteger)i1 with:(NSUInteger)i2 {
    _swapCount++;
    id tmp = _array[i1];
    _array[i1] = _array[i2];
    _array[i2] = tmp;
}
@end
