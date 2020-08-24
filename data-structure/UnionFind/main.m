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

void testUnionFind(UnionFind *uf) {
    [uf unionWith:@0 v2:@1];
    [uf unionWith:@0 v2:@3];
    [uf unionWith:@0 v2:@4];
    [uf unionWith:@2 v2:@3];
    [uf unionWith:@2 v2:@5];
    
    [uf unionWith:@6 v2:@7];
    
    [uf unionWith:@8 v2:@10];
    [uf unionWith:@9 v2:@10];
    [uf unionWith:@9 v2:@11];
    
    assert([uf isSameWith:@0 v2:@6] == false);
    assert([uf isSameWith:@0 v2:@5] == true);
    assert([uf isSameWith:@2 v2:@7] == false);
    [uf unionWith:@4 v2:@6];
    assert([uf isSameWith:@2 v2:@7] == true);
}

void testUnionFindTime(UnionFind *uf, NSInteger count) {
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
//        testUnionFind([[QuickFind alloc] initWithCapacity:12]);
//        testUnionFind([[QuickUnion alloc] initWithCapacity:12]);
//        testUnionFind([[QuickUnionSize alloc] initWithCapacity:12]);
        
        NSInteger count = 10000;
        testUnionFindTime([[QuickFind alloc] initWithCapacity:count], count);
        testUnionFindTime([[QuickUnion alloc] initWithCapacity:count], count);
        testUnionFindTime([[QuickUnionSize alloc] initWithCapacity:count], count);
    }
    return 0;
}
