//
//  BinaryTree.h
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BinaryTreePrint.h"
#import "BinaryTreeLevelOrderPrint.h"
#import "BinaryTreeInorderPrint.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BinaryTreePrintStyle) {
    BinaryTreePrintStyleLevelOrder,
    BinaryTreePrintStyleInorder
};

@interface BinaryTree : BinaryTreePrint
+ (void)println:(id<BinaryTreeProtocol>)tree style:(BinaryTreePrintStyle)style;
+ (void)println:(id<BinaryTreeProtocol>)tree;
+ (void)print:(id<BinaryTreeProtocol>)tree style:(BinaryTreePrintStyle)style;
+ (void)print:(id<BinaryTreeProtocol>)tree;
+ (NSString *)printString:(id<BinaryTreeProtocol>)tree style:(BinaryTreePrintStyle)style;
+ (NSString *)printString:(id<BinaryTreeProtocol>)tree;
@end

NS_ASSUME_NONNULL_END
