//
//  QuickUnionRank.m
//  UnionFind
//
//  Created by Ankui on 8/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "QuickUnionRank.h"

@interface QuickUnionRank () {
    NSMutableArray *_ranks;
}
@end

@implementation QuickUnionRank
- (instancetype)initWithCapacity:(NSInteger)capacity {
    if (self = [super initWithCapacity:capacity]) {
        _ranks = [NSMutableArray arrayWithCapacity:capacity];
        for (NSInteger i = 0; i < capacity; i++) {
            _ranks[i] = @1;
        }
    }
    return self;
}
- (void)unionWith:(id)v1 v2:(id)v2 {
    NSInteger p1 = [[self find:v1] integerValue];
    NSInteger p2 = [[self find:v2] integerValue];
    if (p1 == p2) { return; }
    
    if (_ranks[p1] < _ranks[p2]) {
        _parents[p1] = @(p2);
    } else if (_ranks[p1] > _ranks[p2]) {
        _parents[p2] = @(p1);
    } else {
        _parents[p1] = @(p2);
        _ranks[p2] = @([_ranks[p2] integerValue] + 1);
    }
}
@end
