//
//  QuickFind.m
//  UnionFind
//
//  Created by Ankui on 8/23/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "QuickFind.h"

@implementation QuickFind
- (id)find:(id)value {
    NSInteger v = [value integerValue];
    [self rangeCheck:v];
    return _parents[v];
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

@end
