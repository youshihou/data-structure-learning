//
//  RBTree.m
//  BinaryTree
//
//  Created by Ankui on 7/25/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "RBTree.h"

static const BOOL RED = NO;
static const BOOL BLACK = YES;

@interface RBTNode : TreeNode {
    @public
    BOOL _color;
}
@end
@implementation RBTNode
- (instancetype)init {
    self = [super init];
    if (self) {
        _color = RED;
    }
    return self;
}
- (NSString *)description {
    return [NSString stringWithFormat:@"%@%@", _color == RED ? @"R_" : @"", _element];
}
@end


@implementation RBTree
- (TreeNode *)createNodeWith:(id)element parent:(TreeNode *)parent {
    return [RBTNode nodeWith:element parent:parent];
}
- (void)afterAdd:(TreeNode *)node {
    TreeNode *parent = node->_parent;
    
    // root
    if (!parent) {
        [self _black:node];
        return;
    }
    
    // parent is black
    if ([self _isBlack:parent]) { return; }
    
    TreeNode *uncle = [parent sibling];
//    TreeNode *grand = parent->_parent;
    TreeNode *grand = [self _red:parent->_parent];
    // uncle is red, overflow
    if ([self _isRed:uncle]) {
        [self _black:parent];
        [self _black:uncle];
        // will grand as new add node
//        [self afterAdd:[self _red:grand]];
        [self afterAdd:grand];
        return;
    }
    
    // uncel is not red
    if ([parent isLeftChild]) { // L
//        [self _red:grand];
        if ([node isLeftChild]) { // LL
            [self _black:parent];
        } else { // LR
            [self _black:node];
            [self rotateLeft:parent];
        }
        [self rotateRight:grand];
    } else { // R
//        [self _red:grand];
        if ([node isLeftChild]) { // RL
            [self _black:node];
            [self rotateRight:parent];
        } else { // RR
            [self _black:parent];
        }
        [self rotateLeft:grand];
    }
}
- (void)afterRemove:(TreeNode *)node replace:(TreeNode * _Nullable)replace {
    // will remove node is red
    if ([self _isRed:node]) { return; }
    
    // replace node will remove is red
    if ([self _isRed:replace]) {
        [self _black:replace];
        return;
    }
    
    TreeNode *parent = node->_parent;
    // node is root
    if (!parent) { return; }
    
    // will remove node is black leaf node, underflow
    BOOL left = !parent->_left || [node isLeftChild];
    TreeNode *sibling = left ? parent->_right : parent->_left; // CARE!!! find sibling
    if (left) { // the removed node in left, sibling node in right
         if ([self _isRed:sibling]) { // sibling is red
             [self _black:sibling];
             [self _red:parent];
             [self rotateLeft:parent];
             sibling = parent->_right; // CARE!!!
         }
         
         // sibling node is black
         if ([self _isBlack:sibling->_left] && [self _isBlack:sibling->_right]) {
             // sibling node have not a red child node, so parent underflow
             BOOL black = [self _isBlack:parent];
             [self _black:parent];
             [self _red:sibling];
             if (black) {
                 [self afterRemove:parent replace:nil];
             }
         } else { // sibling node at least have a red child node
             if ([self _isBlack:sibling->_right]) { // sibling node right is black, sibling ratate
                 [self rotateRight:sibling];
                 sibling = parent->_right; // CARE!!!
             }
             [self _color:sibling color:[self _colorOf:parent]];
             [self _black:sibling->_right];
             [self _black:parent];
             [self rotateLeft:parent];
         }
    }
    else { // the removed node in right, sibling node in left
        if ([self _isRed:sibling]) { // sibling is red
            [self _black:sibling];
            [self _red:parent];
            [self rotateRight:parent];
            sibling = parent->_left; // CARE!!!
        }
        
        // sibling node is black
        if ([self _isBlack:sibling->_left] && [self _isBlack:sibling->_right]) {
            // sibling node have not a red child node, so parent underflow
            BOOL black = [self _isBlack:parent];
            [self _black:parent];
            [self _red:sibling];
            if (black) {
                [self afterRemove:parent replace:nil];
            }
        } else { // sibling node at least have a red child node
            if ([self _isBlack:sibling->_left]) { // sibling node left is black, sibling ratate
                [self rotateLeft:sibling];
                sibling = parent->_left; // CARE!!!
            }
            [self _color:sibling color:[self _colorOf:parent]];
            [self _black:sibling->_left];
            [self _black:parent];
            [self rotateRight:parent];
        }
    }
    
}
- (TreeNode *)_color:(TreeNode *)node color:(BOOL)color {
    if (!node) { return node; }
    ((RBTNode *)node)->_color = color;
    return node;
}
- (TreeNode *)_red:(TreeNode *)node {
    return [self _color:node color:RED];
}
- (TreeNode *)_black:(TreeNode *)node {
    return [self _color:node color:BLACK];
}
- (BOOL)_colorOf:(TreeNode *)node {
    return node ? ((RBTNode *)node)->_color : BLACK;
}
- (BOOL)_isRed:(TreeNode *)node {
    return [self _colorOf:node] == RED;
}
- (BOOL)_isBlack:(TreeNode *)node {
    return [self _colorOf:node] == BLACK;
}
@end
