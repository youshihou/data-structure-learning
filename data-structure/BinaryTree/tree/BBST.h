//
//  BBST.h
//  BinaryTree
//
//  Created by Ankui on 7/27/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BST.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBST : BST
- (void)rotateLeft:(TreeNode *)grand;
- (void)rotateRight:(TreeNode *)grand;
- (void)afterRotate:(TreeNode *)grand parent:(TreeNode *)parent child:(TreeNode *)child;
- (void)rotate:(TreeNode *)r b:(TreeNode *)b c:(TreeNode *)c d:(TreeNode *)d e:(TreeNode *)e f:(TreeNode *)f;
@end

NS_ASSUME_NONNULL_END
