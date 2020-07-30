//
//  TreeMap.m
//  BinaryTree
//
//  Created by Ankui on 7/29/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "TreeMap.h"

static const BOOL RED = NO;
static const BOOL BLACK = YES;

@interface TMNode : NSObject {
    @public
    id _key;
    id _value;
    TMNode *_left;
    TMNode *_right;
    __weak TMNode *_parent;
    BOOL _color;
}
@end
@implementation TMNode
+ (instancetype)nodeWithKey:(id)key value:(id)value parent:(TMNode * _Nullable)parent {
    TMNode *n = [[self alloc] init];
    n->_key = key;
    n->_value = value;
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
- (TMNode *)sibling {
    if ([self isLeftChild]) {
        return _parent->_right;
    }
    if ([self isRightChild]) {
        return _parent->_left;
    }
    return nil;
}
@end


@interface TreeMap () {
    NSUInteger _size;
    TMNode *_root;
    int(^_block)(id, id);
    id<TreeMapComparator> _comparator;
}
@end

@implementation TreeMap
+ (instancetype)map {
    return [[self alloc] init];;
}
+ (instancetype)mapWithComparator:(id<TreeMapComparator>)comparator {
    TreeMap *map = [TreeMap map];
    map->_comparator = comparator;
    return map;
}
+ (instancetype)mapWithBlock:(int (^)(id _Nonnull, id _Nonnull))block {
    TreeMap *map = [TreeMap map];
    map->_block = block;
    return map;
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
- (id)put:(id)key value:(id _Nullable)value {
    if (!key) {
        assert("key must not be nil");
        return nil;
    }
    if (!_root) {
        _root = [TMNode nodeWithKey:key value:value parent:nil];
        _size++;
        [self _afterPut:_root];
        return nil;
    }
    
    TMNode *parent = _root;
    TMNode *node = _root;
    int cmp = 0;
    while (node) {
        parent = node;
        cmp = [self _compare:key k2:node->_key];
        if (cmp > 0) {
            node = node->_right;
        } else if (cmp < 0) {
            node = node->_left;
        } else {
            node->_key = key;
            id old = node->_value;
            node->_value = value;
            return old;
        }
    }
    TMNode *add = [TMNode nodeWithKey:key value:value parent:parent];
    if (cmp > 0) {
        parent->_right = add;
    } else {
        parent->_left = add;
    }
    _size++;
    [self _afterPut:add];
    return nil;
}
- (id)get:(id)key {
    TMNode *node = [self _findNode:key];
    return node->_value;
}
- (id)remove:(id)key {
    return [self _remove:[self _findNode:key]];
}
- (BOOL)containsKey:(id)key {
    return [self _findNode:key] != nil;
}
- (BOOL)containsValue:(id)value {
    if (!_root) { return false; }
    NSMutableArray<TMNode *> *array = [NSMutableArray array];
    [array addObject:_root];
    while (array.count) {
        TMNode *node = array.firstObject;
        [array removeObjectAtIndex:0];
        
        if ([value isEqual:node->_value]) {
            return YES;
        }
        
        if (node->_left) {
            [array addObject:node->_left];
        }
        if (node->_right) {
            [array addObject:node->_right];
        }
    }
    
    return NO;
}
- (void)traversal:(struct MapVisitor *)visitor {
    if (visitor == NULL) { return; }
    [self _traversal:_root visitor:visitor];
}

- (void)_afterPut:(TMNode *)node {
    TMNode *parent = node->_parent;
    
    // root
    if (!parent) {
        [self _black:node];
        return;
    }
    
    // parent is black
    if ([self _isBlack:parent]) { return; }
    
    TMNode *uncle = [parent sibling];
    TMNode *grand = [self _red:parent->_parent];
    // uncle is red, overflow
    if ([self _isRed:uncle]) {
        [self _black:parent];
        [self _black:uncle];
        // will grand as new add node
        [self _afterPut:grand];
        return;
    }
    
    // uncel is not red
    if ([parent isLeftChild]) { // L
        if ([node isLeftChild]) { // LL
            [self _black:parent];
        } else { // LR
            [self _black:node];
            [self _rotateLeft:parent];
        }
        [self _rotateRight:grand];
    } else { // R
        if ([node isLeftChild]) { // RL
            [self _black:node];
            [self _rotateRight:parent];
        } else { // RR
            [self _black:parent];
        }
        [self _rotateLeft:grand];
    }
}
- (void)_rotateLeft:(TMNode *)grand {
    TMNode *parent = grand->_right;
    TMNode *child = parent->_left;
    grand->_right = child;
    parent->_left = grand;
    
    [self _afterRotate:grand parent:parent child:child];
}
- (void)_rotateRight:(TMNode *)grand {
    TMNode *parent = grand->_left;
    TMNode *child = parent->_right;
    grand->_left = child;
    parent->_right = grand;
    
    [self _afterRotate:grand parent:parent child:child];
}
- (void)_afterRotate:(TMNode *)grand parent:(TMNode *)parent child:(TMNode *)child {
    // update parent's parent, become the subtree's root
    parent->_parent = grand->_parent;
    if ([grand isLeftChild]) {
        grand->_parent->_left = parent;
    } else if ([grand isRightChild]) {
        grand->_parent->_right = parent;
    } else {
        // grand is root
        _root = parent;
    }
    
    // update child's parent
    if (child) {
        child->_parent = grand;
    }
    
    // update grand's parent
    grand->_parent = parent;
}
- (TMNode *)_findNode:(id)key {
    TMNode *node = _root;
    while (node) {
        int cmp = [self _compare:key k2:node->_key];
        if (cmp == 0) { return node; }
        if (cmp > 0) {
            node = node->_right;
        } else {
            node = node->_left;
        }
    }
    return nil;
}
- (TMNode *)_predcessor:(TMNode *)node {
    if (!node) { return nil; }
    TMNode *p = node->_left;
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
- (TMNode *)_successor:(TMNode *)node {
    if (!node) { return nil; }
    TMNode *s = node->_right;
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
- (id)_remove:(TMNode *)node {
    if (!node) { return nil; }
    id old = node->_value;
    
    _size--;
    if (node->_left && node->_right) {
        TMNode *s = [self _successor:node];
        node->_key = s->_key;
        node->_value = s->_value;
        node = s;
    }
    
    TMNode *replace = node->_left ?: node->_right;
    if (replace) {
        replace->_parent = node->_parent;
        if (!node->_parent) {
            _root = replace;
        } else if (node == node->_parent->_left) {
            node->_parent->_left = replace;
        } else {
            node->_parent->_right = replace;
        }
        [self _afterRemove:replace];
    }
    else if (!node->_parent) {
        _root = nil;
        [self _afterRemove:node];
    }
    else {
        if (node == node->_parent->_left) {
            node->_parent->_left = nil;
        } else {
            node->_parent->_right = nil;
        }
        [self _afterRemove:node];
    }
    return old;
}
- (void)_afterRemove:(TMNode *)node {
    // will remove node is red
    // replace node will remove is red
    if ([self _isRed:node]) {
        [self _black:node];
        return;
    }
    
    TMNode *parent = node->_parent;
    // node is root
    if (!parent) { return; }
    
    // will remove node is black leaf node, underflow
    BOOL left = !parent->_left || [node isLeftChild];
    TMNode *sibling = left ? parent->_right : parent->_left; // CARE!!! find sibling
    if (left) { // the removed node in left, sibling node in right
         if ([self _isRed:sibling]) { // sibling is red
             [self _black:sibling];
             [self _red:parent];
             [self _rotateLeft:parent];
             sibling = parent->_right; // CARE!!!
         }
         
         // sibling node is black
         if ([self _isBlack:sibling->_left] && [self _isBlack:sibling->_right]) {
             // sibling node have not a red child node, so parent underflow
             BOOL black = [self _isBlack:parent];
             [self _black:parent];
             [self _red:sibling];
             if (black) {
                 [self _afterRemove:parent];
             }
         } else { // sibling node at least have a red child node
             if ([self _isBlack:sibling->_right]) { // sibling node right is black, sibling ratate
                 [self _rotateRight:sibling];
                 sibling = parent->_right; // CARE!!!
             }
             [self _color:sibling color:[self _colorOf:parent]];
             [self _black:sibling->_right];
             [self _black:parent];
             [self _rotateLeft:parent];
         }
    }
    else { // the removed node in right, sibling node in left
        if ([self _isRed:sibling]) { // sibling is red
            [self _black:sibling];
            [self _red:parent];
            [self _rotateRight:parent];
            sibling = parent->_left; // CARE!!!
        }
        
        // sibling node is black
        if ([self _isBlack:sibling->_left] && [self _isBlack:sibling->_right]) {
            // sibling node have not a red child node, so parent underflow
            BOOL black = [self _isBlack:parent];
            [self _black:parent];
            [self _red:sibling];
            if (black) {
                [self _afterRemove:parent];
            }
        } else { // sibling node at least have a red child node
            if ([self _isBlack:sibling->_left]) { // sibling node left is black, sibling ratate
                [self _rotateLeft:sibling];
                sibling = parent->_left; // CARE!!!
            }
            [self _color:sibling color:[self _colorOf:parent]];
            [self _black:sibling->_left];
            [self _black:parent];
            [self _rotateRight:parent];
        }
    }
    
}
- (void)_traversal:(TMNode *)node visitor:(struct MapVisitor *)visitor {
    if (!node || visitor->stop) { return; }
    [self _traversal:node->_left visitor:visitor];
    visitor->stop = visitor->visit((__bridge void * _Nonnull)(node->_key), (__bridge void * _Nonnull)(node->_value));
    [self _traversal:node->_right visitor:visitor];
}
- (int)_compare:(id)k1 k2:(id)k2 {
    return _block ? _block(k1, k2) : (_comparator ? [_comparator compare:k1 with:k2] : (int)[k1 compare:k2]);
}

- (TMNode *)_color:(TMNode *)node color:(BOOL)color {
    if (!node) { return node; }
    node->_color = color;
    return node;
}
- (TMNode *)_red:(TMNode *)node {
    return [self _color:node color:RED];
}
- (TMNode *)_black:(TMNode *)node {
    return [self _color:node color:BLACK];
}
- (BOOL)_colorOf:(TMNode *)node {
    return node ? node->_color : BLACK;
}
- (BOOL)_isRed:(TMNode *)node {
    return [self _colorOf:node] == RED;
}
- (BOOL)_isBlack:(TMNode *)node {
    return [self _colorOf:node] == BLACK;
}
@end
