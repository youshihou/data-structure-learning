//
//  Sort.m
//  Sort
//
//  Created by Ankui on 8/16/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "Sort.h"

@implementation Sort
+ (instancetype)sort {
    return [[self alloc] init];
}
- (NSString *)description {
    NSString *time = [[NSString alloc] initWithFormat:@"time: %fs(%f)ms", _time, _time * 1000.0];
    NSString *cmp = [[NSString alloc] initWithFormat:@"cmp: %@", [self _numberString:_cmpCount]];
    NSString *swap = [[NSString alloc] initWithFormat:@"swap: %@", [self _numberString:_swapCount]];
    NSString *name = NSStringFromClass(self.class);
    NSString *line = @"---------------------------------------------------------------------------";
    return [[NSString alloc] initWithFormat:@"\n[%@]\n%@\t\t%@\t\t%@\n%@", name, time, cmp, swap, line];
}
- (NSString *)_numberString:(NSUInteger)number {
    if (number < 10000) { return [NSString stringWithFormat:@"%zd", number]; }
    if (number < 100000000) { return [NSString stringWithFormat:@"%.2f万", number / 10000.0]; }
    return [NSString stringWithFormat:@"%.2f", number / 100000000.0];
}

- (void)sort:(NSMutableArray *)array {
    if (array.count == 0) { return; }
    _array = array;
    CFTimeInterval begin = CFAbsoluteTimeGetCurrent();
    [self sorting];
    _time = CFAbsoluteTimeGetCurrent() - begin;
}
- (void)sorting {}
- (NSInteger)cmp:(NSUInteger)i1 with:(NSUInteger)i2 {
    _cmpCount++;
    return [_array[i1] integerValue] - [_array[i2] integerValue];
}
- (NSInteger)cmpElement:(id)e1 with:(id)e2 {
    _cmpCount++;
    return [e1 integerValue] - [e2 integerValue];
}
- (void)swap:(NSUInteger)i1 with:(NSUInteger)i2 {
    _swapCount++;
    id tmp = _array[i1];
    _array[i1] = _array[i2];
    _array[i2] = tmp;
}
@end
