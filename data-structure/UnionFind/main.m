//
//  main.m
//  UnionFind
//
//  Created by Ankui on 8/23/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnionFind.h"

void testUnionFind(void) {
    UnionFind *uf = [[UnionFind alloc] initWithCapacity:12];
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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        testUnionFind();
    }
    return 0;
}
