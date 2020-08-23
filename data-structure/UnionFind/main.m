//
//  main.m
//  UnionFind
//
//  Created by Ankui on 8/23/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuickFind.h"

void testUnionFind(void) {
    QuickFind *qf = [[QuickFind alloc] initWithCapacity:12];
    [qf unionWith:@0 v2:@1];
    [qf unionWith:@0 v2:@3];
    [qf unionWith:@0 v2:@4];
    [qf unionWith:@2 v2:@3];
    [qf unionWith:@2 v2:@5];
    
    [qf unionWith:@6 v2:@7];
    
    [qf unionWith:@8 v2:@10];
    [qf unionWith:@9 v2:@10];
    [qf unionWith:@9 v2:@11];
    
    assert([qf isSameWith:@0 v2:@6] == false);
    assert([qf isSameWith:@0 v2:@5] == true);
    assert([qf isSameWith:@2 v2:@7] == false);

    [qf unionWith:@4 v2:@6];
    assert([qf isSameWith:@2 v2:@7] == true);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        testUnionFind();
    }
    return 0;
}
