//
//  main.m
//  UnionFind
//
//  Created by Ankui on 8/23/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnionFind.h"
#import "QuickFind.h"
#import "QuickUnion.h"
#import "QuickUnionSize.h"
#import "QuickUnionRank.h"
#import "QuickUnionRankPathCompression.h"

void testUnionFind(UnionFind *uf, NSInteger count) {
    CFTimeInterval begin = CFAbsoluteTimeGetCurrent();
    for (NSInteger i = 0; i < count; i++) {
        NSInteger v1 = arc4random() % count;
        NSInteger v2 = arc4random() % count;
        [uf unionWith:@(v1) v2:@(v2)];
    }
    for (NSInteger i = 0; i < count; i++) {
        NSInteger v1 = arc4random() % count;
        NSInteger v2 = arc4random() % count;
        [uf isSameWith:@(v1) v2:@(v2)];
    }
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    NSString *time = [[NSString alloc] initWithFormat:@"time:  %fs(%f)ms", end - begin, (end - begin) * 1000.0];
    NSString *name = NSStringFromClass(uf.class);
    NSString *line = @"---------------------------------------------------------";
    NSLog(@"\n[%@]\nbegin: %f\nend:   %f\n%@\n%@", name, begin, end, time, line);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSInteger count = 100000;
//        testUnionFind([[QuickFind alloc] initWithCapacity:count], count);
//        testUnionFind([[QuickUnion alloc] initWithCapacity:count], count);
//        testUnionFind([[QuickUnionSize alloc] initWithCapacity:count], count);
        testUnionFind([[QuickUnionRank alloc] initWithCapacity:count], count);
        testUnionFind([[QuickUnionRankPathCompression alloc] initWithCapacity:count], count);
    }
    return 0;
}
