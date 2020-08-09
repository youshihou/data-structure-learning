//
//  BinaryTreePrint.m
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BinaryTreePrint.h"

@implementation BinaryTreePrint

+ (instancetype)printWithTree:(id<BinaryTreeProtocol>)tree {
    BinaryTreePrint *p = [[self alloc] init];
    p.tree = tree;
    return p;
}

- (NSString *)printString {
    return nil;
}

- (void)print {
    printf("%s", self.printString.UTF8String);
}

- (void)println {
    [self print];
    printf("\n");
}

@end
