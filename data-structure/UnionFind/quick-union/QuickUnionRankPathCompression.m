//
//  QuickUnionRankPathCompression.m
//  UnionFind
//
//  Created by Ankui on 8/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "QuickUnionRankPathCompression.h"

@implementation QuickUnionRankPathCompression
- (id)find:(id)value {
    NSInteger v = [value integerValue];
    [self rangeCheck:v];
    if ([_parents[v] integerValue] != v) {
        _parents[v] = [self find:_parents[v]];
    }
    return _parents[v];
}
@end
