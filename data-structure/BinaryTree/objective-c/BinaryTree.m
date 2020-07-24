//
//  BinaryTree.m
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BinaryTree.h"

@implementation BinaryTree
+ (BinaryTreePrint *)_printWith:(id<BinaryTreeProtocol>)tree style:(BinaryTreePrintStyle)style {
    if (!tree) { return nil; }
    if (style == BinaryTreePrintStyleLevelOrder) {
        return [BinaryTreeLevelOrderPrint printWithTree:tree];
    }
    return [BinaryTreeInorderPrint printWithTree:tree];
}
+ (void)println:(id<BinaryTreeProtocol>)tree style:(BinaryTreePrintStyle)style {
    [[self _printWith:tree style:style] println];
}
+ (void)println:(id<BinaryTreeProtocol>)tree {
    [self println:tree style:BinaryTreePrintStyleLevelOrder];
}
+ (void)print:(id<BinaryTreeProtocol>)tree style:(BinaryTreePrintStyle)style {
    [[self _printWith:tree style:style] print];
}
+ (void)print:(id<BinaryTreeProtocol>)tree {
    [self print:tree style:BinaryTreePrintStyleLevelOrder];
}
+ (NSString *)printString:(id<BinaryTreeProtocol>)tree style:(BinaryTreePrintStyle)style {
    return [self _printWith:tree style:style].printString;
}
+ (NSString *)printString:(id<BinaryTreeProtocol>)tree {
    return [self printString:tree style:BinaryTreePrintStyleLevelOrder];
}
@end
