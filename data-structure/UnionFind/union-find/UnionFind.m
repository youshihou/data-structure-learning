//
//  UnionFind.m
//  UnionFind
//
//  Created by Ankui on 8/23/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "UnionFind.h"

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
    return nil;
}
- (void)unionWith:(id)v1 v2:(id)v2 {}
- (BOOL)isSameWith:(id)v1 v2:(id)v2 {
    return [[self find:v1] integerValue] == [[self find:v2] integerValue];
}
- (void)rangeCheck:(NSInteger)value {
    if (value < 0 || value >= _parents.count) {
        assert("value is out of bounds");
    }
}
@end
