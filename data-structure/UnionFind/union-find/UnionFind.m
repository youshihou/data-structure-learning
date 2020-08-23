//
//  UnionFind.m
//  UnionFind
//
//  Created by Ankui on 8/23/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "UnionFind.h"

@interface UnionFind () {
    NSMutableArray *_parents;
}
@end

@implementation UnionFind
- (instancetype)initWithCapacity:(NSInteger)capacity {
    if (capacity < 0) { assert("capacity must be >= 1"); }
    if (self = [super init]) {
        _parents = [NSMutableArray arrayWithCapacity:capacity];
        for (NSInteger i = 0; i < capacity; i++) {
            _parents[i] = @(i);
        }
    }
    return self;
}
- (id)find:(id)value {
    NSInteger v = [value integerValue];
    [self _rangeCheck:v];
    return _parents[v];
}
- (BOOL)isSameWith:(id)v1 v2:(id)v2 {
    return [[self find:v1] integerValue] == [[self find:v2] integerValue];
}
- (void)unionWith:(id)v1 v2:(id)v2 {
    NSInteger p1 = [[self find:v1] integerValue];
    NSInteger p2 = [[self find:v2] integerValue];
    if (p1 == p2) { return; }
    
    for (NSInteger i = 0; i < _parents.count; i++) {
        if ([_parents[i] integerValue] == p1) {
            _parents[i] = @(p2);
        }
    }
}

- (void)_rangeCheck:(NSInteger)value {
    if (value < 0 || value >= _parents.count) {
        assert("value is out of bounds");
    }
}
@end
