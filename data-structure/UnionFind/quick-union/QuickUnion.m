//
//  QuickUnion.m
//  UnionFind
//
//  Created by Ankui on 8/23/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "QuickUnion.h"

@implementation QuickUnion
- (id)find:(id)value {
    NSInteger v = [value integerValue];
    [self rangeCheck:v];
    while (v != [_parents[v] integerValue]) {
        v = [_parents[v] integerValue];
    }
    return @(v);
}
- (void)unionWith:(id)v1 v2:(id)v2 {
    NSInteger p1 = [[self find:v1] integerValue];
    NSInteger p2 = [[self find:v2] integerValue];
    if (p1 == p2) { return; }
    _parents[p1] = @(p2);
}
@end
