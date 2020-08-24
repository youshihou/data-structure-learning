//
//  QuickUnionRankPathSpliting.m
//  UnionFind
//
//  Created by Ankui on 8/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "QuickUnionRankPathSpliting.h"

@implementation QuickUnionRankPathSpliting
- (id)find:(id)value {
    NSInteger v = [value integerValue];
    [self rangeCheck:v];
    while (v != [_parents[v] integerValue]) {
        NSInteger p = [_parents[v] integerValue];
        _parents[v] = _parents[p];
        v = p;
    }
    return @(v);
}
@end
