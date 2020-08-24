//
//  QuickUnionSize.m
//  UnionFind
//
//  Created by Ankui on 8/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "QuickUnionSize.h"

@interface QuickUnionSize () {
    NSMutableArray *_sizes;
}
@end

@implementation QuickUnionSize
- (instancetype)initWithCapacity:(NSInteger)capacity {
    if (self = [super initWithCapacity:capacity]) {
        _sizes = [NSMutableArray arrayWithCapacity:capacity];
        for (NSInteger i = 0; i < capacity; i++) {
            _sizes[i] = @1;
        }
    }
    return self;
}
- (void)unionWith:(id)v1 v2:(id)v2 {
    NSInteger p1 = [[self find:v1] integerValue];
    NSInteger p2 = [[self find:v2] integerValue];
    if (p1 == p2) { return; }
    if (_sizes[p1] < _sizes[p2]) {
        _parents[p1] = @(p2);
        _sizes[p2] = @([_sizes[p2] integerValue] + [_sizes[p1] integerValue]);
    } else {
        _parents[p2] = @(p1);
        _sizes[p1] = @([_sizes[p1] integerValue] + [_sizes[p2] integerValue]);
    }
}
@end
