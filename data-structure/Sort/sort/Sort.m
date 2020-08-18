//
//  Sort.m
//  Sort
//
//  Created by Ankui on 8/16/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "Sort.h"

@interface Student : NSObject {
    @public
    NSNumber *_score;
    NSNumber *_age;
}
@end
@implementation Student
- (NSComparisonResult)compare:(id)other {
    Student *s = other;
    return [_age integerValue] - [s->_age integerValue];
}
@end



@implementation Sort
+ (instancetype)sort {
    return [[self alloc] init];
}
- (NSString *)description {
    NSString *time = [[NSString alloc] initWithFormat:@"time: %fs(%f)ms", _time, _time * 1000.0];
    NSString *cmp = [[NSString alloc] initWithFormat:@"cmp: %@", [self _numberString:_cmpCount]];
    NSString *swap = [[NSString alloc] initWithFormat:@"swap: %@", [self _numberString:_swapCount]];
    NSString *stable = [[NSString alloc] initWithFormat:@"stable: %d", [self _isStable]];
    NSString *name = NSStringFromClass(self.class);
    NSString *line = @"------------------------------------------------------------------------------------------";
    return [[NSString alloc] initWithFormat:@"\n[%@]\n%@\t\t%@\t\t%@\t\t%@\n%@", name, stable, time, cmp, swap, line];
}
- (NSString *)_numberString:(NSUInteger)number {
    if (number < 10000) { return [NSString stringWithFormat:@"%zd", number]; }
    if (number < 100000000) { return [NSString stringWithFormat:@"%.2f万", number / 10000.0]; }
    return [NSString stringWithFormat:@"%.2f亿", number / 100000000.0];
}
- (BOOL)_isStable {
    if ([NSStringFromClass(self.class) isEqualToString:@"ShellSort"]) { return NO; }
    NSUInteger count = 20;
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger i = 0; i < count; i++) {
        Student *s = [[Student alloc] init];
        s->_score = @(i * 10);
        s->_age = @10;
        [array addObject:s];
    }
    [self sort:array];
    for (NSUInteger i = 1; i < count; i++) {
        Student *s = array[i];
        NSInteger score = [s->_score integerValue];
        Student *prev = array[i - 1];
        NSInteger prevScore = [prev->_score integerValue];
        if (score != prevScore + 10) { return NO; }
    }
    return YES;
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
    return [_array[i1] compare:_array[i2]];
}
- (NSInteger)cmpElement:(id)e1 with:(id)e2 {
    _cmpCount++;
    return [e1 compare:e2];
}
- (void)swap:(NSUInteger)i1 with:(NSUInteger)i2 {
    _swapCount++;
    id tmp = _array[i1];
    _array[i1] = _array[i2];
    _array[i2] = tmp;
}
- (BOOL)isAscOrder {
    for (NSUInteger i = 1; i < _array.count; i++) {
        if ([_array[i - 1] compare:_array[i]] > 0) {
            return NO;
        }
    }
    return YES;
}
@end
