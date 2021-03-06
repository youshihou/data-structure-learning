//
//  BinaryTree.m
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BinaryTree.h"

@implementation TreeNode
+ (instancetype)nodeWith:(id)element parent:(TreeNode * _Nullable)parent {
    TreeNode *n = [[self alloc] init];
    n->_element = element;
    n->_parent = parent;
    return n;
}
- (BOOL)isLeaf {
    return _left == nil && _right == nil;
}
- (BOOL)hasTwoChild {
    return _left != nil && _right != nil;
}
- (BOOL)isLeftChild {
    return _parent != nil && self == _parent->_left;
}
- (BOOL)isRightChild {
    return _parent != nil && self == _parent->_right;
}
- (TreeNode *)sibling {
    if ([self isLeftChild]) {
        return _parent->_right;
    }
    if ([self isRightChild]) {
        return _parent->_left;
    }
    return nil;
}
@end


@implementation BinaryTree
+ (instancetype)tree {
    return [[self alloc] init];
}
- (NSUInteger)size {
    return _size;
}
- (BOOL)isEmpty {
    return _size == 0;
}
- (void)clear {
    _root = nil;
    _size = 0;
}

- (BOOL)isComplete {
    if (!_root) { return NO; }
    BOOL leaf = NO;
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:_root];
    while (queue.count) {
        TreeNode *node = queue.firstObject;
        [queue removeObjectAtIndex:0];
        if (leaf && ![node isLeaf]) { return NO; }
        if (node->_left) {
            [queue addObject:node->_left];
        } else if (node->_right) {
            return false;
        }
        if (node->_right) {
            [queue addObject:node->_right];
        } else {
            leaf = YES;
        }
    }
    return YES;
}
- (NSUInteger)height {
    return [self _height:_root];
}
- (NSUInteger)_height:(TreeNode *)node {
    if (!node) { return 0; }
    return 1 + MAX([self _height:node->_left], [self _height:node->_right]);
}
- (NSUInteger)height2 {
    if (!_root) { return 0; }
    NSUInteger height = 0;
    NSUInteger levelSize = 1;
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:_root];
    while (queue.count) {
        TreeNode *node = queue.firstObject;
        [queue removeObjectAtIndex:0];
        levelSize--;
        if (node->_left) {
            [queue addObject:node->_left];
        }
        if (node->_right) {
            [queue addObject:node->_right];
        }
        if (levelSize == 0) {
            levelSize = queue.count;
            height++;
        }
    }
    return height;
}
- (TreeNode *)predcessor:(TreeNode *)node {
    if (!node) { return nil; }
    TreeNode *p = node->_left;
    if (p) {
        while (p->_right) {
            p = p->_right;
        }
        return p;
    }
    while (node->_parent && node == node->_parent->_left) {
        node = node->_parent;
    }
    return node->_parent;
}
- (TreeNode *)successor:(TreeNode *)node {
    if (!node) { return nil; }
    TreeNode *s = node->_right;
    if (s) {
        while (s->_left) {
            s = s->_left;
        }
        return s;
    }
    while (node->_parent && node->_parent->_right) {
        node = node->_right;
    }
    return node->_parent;
}
- (void)preorder:(struct Visitor *)visitor {
    if (visitor == NULL) { return; }
    [self _preorder:_root visitor:visitor];
}
- (void)_preorder:(TreeNode *)node visitor:(struct Visitor *)visitor {
    if (!node || visitor->stop) { return; }
    visitor->stop = visitor->visit((__bridge void * _Nonnull)(node->_element));
    [self _preorder:node->_left visitor:visitor];
    [self _preorder:node->_right visitor:visitor];
}
- (void)inorder:(struct Visitor *)visitor {
    if (visitor == NULL) { return; }
    [self _inorder:_root visitor:visitor];
}
- (void)_inorder:(TreeNode *)node visitor:(struct Visitor *)visitor {
    if (!node || visitor->stop) { return; }
    [self _inorder:node->_left visitor:visitor];
    if (visitor->stop) { return; }
    visitor->stop = visitor->visit((__bridge void * _Nonnull)(node->_element));
    [self _inorder:node->_right visitor:visitor];
}
- (void)postorder:(struct Visitor *)visitor {
    if (visitor == NULL) { return; }
    [self _postorder:_root visitor:visitor];
}
- (void)_postorder:(TreeNode *)node visitor:(struct Visitor *)visitor {
    if (!node || visitor->stop) { return; }
    [self _postorder:node->_left visitor:visitor];
    [self _postorder:node->_right visitor:visitor];
    if (visitor->stop) { return; }
    visitor->stop = visitor->visit((__bridge void * _Nonnull)(node->_element));
}
- (void)levelOrder:(struct Visitor *)visitor {
    if (!_root || visitor->stop) { return; }
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:_root];
    while (queue.count) {
        TreeNode *node = queue.firstObject;
        [queue removeObjectAtIndex:0];
        bool stop = visitor->visit((__bridge void * _Nonnull)(node->_element));
        if (stop) { return; }
        if (node->_left) {
            [queue addObject:node->_left];
        }
        if (node->_right) {
            [queue addObject:node->_right];
        }
    }
}

- (void)preorder_new:(struct Visitor *)visitor {
    if (!_root || visitor->stop) { return; }
    NSMutableArray *stack = [NSMutableArray array];
    [stack addObject:_root];
    while (stack.count) {
        TreeNode *top = stack.lastObject;
        [stack removeLastObject];
        if (visitor->visit((__bridge void * _Nonnull)(top->_element))) { return; }
        if (top->_right) {
            [stack addObject:top->_right];
        }
        if (top->_left) {
            [stack addObject:top->_left];
        }
    }
}
- (void)preorder_new2:(struct Visitor *)visitor {
    if (!_root || visitor->stop) { return; }
    TreeNode *node = _root;
    NSMutableArray *stack = [NSMutableArray array];
    while (YES) {
        if (node) {
            if (visitor->visit((__bridge void * _Nonnull)(node->_element))) { return; }
            if (node->_right) {
                [stack addObject:node->_right];
            }
            node = node->_left;
        } else if (stack.count == 0) {
            return;
        } else {
            node = stack.lastObject;
            [stack removeLastObject];
        }
    }
}
- (void)inorder_new:(struct Visitor *)visitor {
    if (!_root || visitor->stop) { return; }
    TreeNode *node = _root;
    NSMutableArray *stack = [NSMutableArray array];
    while (YES) {
        if (node) {
            [stack addObject:node];
            node = node->_left;
        } else if (stack.count == 0) {
            return;
        } else {
            node = stack.lastObject;
            [stack removeLastObject];
            if (visitor->visit((__bridge void * _Nonnull)(node->_element))) { return; }
            node = node->_right;
        }
    }
}
- (void)postorder_new:(struct Visitor *)visitor {
    if (!_root || visitor->stop) { return; }
    TreeNode *prev = nil;
    NSMutableArray *stack = [NSMutableArray array];
    [stack addObject:_root];
    while (stack.count) {
        TreeNode *top = stack.lastObject;
        if ([top isLeaf] || (prev && prev->_parent == top)) {
            prev = stack.lastObject;
            [stack removeLastObject];
            if (visitor->visit((__bridge void * _Nonnull)(prev->_element))) { return; }
        } else {
            if (top->_right) {
                [stack addObject:top->_right];
            }
            if (top->_left) {
                [stack addObject:top->_left];
            }
        }
    }
}



- (void)inorder_morris:(struct Visitor *)visitor {
    if (!_root || visitor->stop) { return; }
    TreeNode *node = _root;
    while (node) {
        if (node->_left) {
            TreeNode *pred = node->_left;
            while (pred->_right && pred->_right != node) {
                pred = pred->_right;
            }
            if (!pred->_right) {
                pred->_right = node;
                node = node->_left;
            } else {
                if (visitor->visit((__bridge void * _Nonnull)(node->_element))) { return; }
                pred->_right = nil;
                node = node->_right;
            }
        } else {
            if (visitor->visit((__bridge void * _Nonnull)(node->_element))) { return; }
            node = node->_right;
        }
    }
}

@end
