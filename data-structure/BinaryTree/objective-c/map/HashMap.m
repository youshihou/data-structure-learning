//
//  HashMap.m
//  BinaryTree
//
//  Created by Ankui on 7/31/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "HashMap.h"
#import "BinaryTreePrintHandler.h"

static const BOOL RED = NO;
static const BOOL BLACK = YES;

@interface HashNode : NSObject {
    @public
    id _key;
    id _value;
    NSUInteger _hash;
    HashNode *_left;
    HashNode *_right;
    __weak HashNode *_parent;
    BOOL _color;
}
@end
@implementation HashNode
+ (instancetype)nodeWithKey:(id)key value:(id)value parent:(HashNode * _Nullable)parent {
    HashNode *n = [[self alloc] init];
    n->_key = key;
    n->_value = value;
    n->_hash = [key hash];
    n->_parent = parent;
    return n;
}
- (BOOL)isLeftChild {
    return _parent != nil && self == _parent->_left;
}
- (BOOL)isRightChild {
    return _parent != nil && self == _parent->_right;
}
- (HashNode *)sibling {
    if ([self isLeftChild]) {
        return _parent->_right;
    }
    if ([self isRightChild]) {
        return _parent->_left;
    }
    return nil;
}
- (NSString *)description {
    return [NSString stringWithFormat:@"Node_%@_%@", _key, _value];
}
@end


@interface ValueTree : NSObject <BinaryTreeProtocol> {
    HashNode *_root;
}
@end
@implementation ValueTree
- (instancetype)initWithRoot:(HashNode *)root {
    if (self = [super init]) {
        _root = root;
    }
    return self;
}
// MARK: - BinaryTreeProtocol
- (id)root {
    return _root;
}
- (id)left:(id)object {
    HashNode *node = object;
    return node ? node->_left : nil;
}
- (id)right:(id)object {
    HashNode *node = object;
    return node ? node->_right : nil;
}
- (id)string:(id)object {
    return object;
}
@end


@interface HashMap () {
    NSUInteger _size;
    NSUInteger _capacity;
    NSMutableArray *_table;
}
@end

@implementation HashMap

static const NSUInteger DEFAULT_CAPACITY = (1 << 4);

- (instancetype)init {
    self = [super init];
    if (self) {
        _table = [NSMutableArray arrayWithCapacity:DEFAULT_CAPACITY];
        _capacity = DEFAULT_CAPACITY;
        for (NSUInteger i = 0; i < DEFAULT_CAPACITY; i++) {
            [_table addObject:[NSNull null]];
        }
    }
    return self;
}
+ (instancetype)map {
    return [[self alloc] init];
}
- (NSUInteger)size {
    return _size;
}
- (BOOL)isEmpty {
    return _size == 0;
}
- (void)clear {
    if (_size == 0) { return; }
    [_table removeAllObjects];
    _size = 0;
}
- (id)put:(id)key value:(id)value {
    NSUInteger index = [self _index:key];
    HashNode *root = _table[index];
    if ([root isKindOfClass:NSNull.class]) {
        root = [HashNode nodeWithKey:key value:value parent:nil];
        _table[index] = root;
        _size++;
        [self _afterPut:root];
        return nil;
    }
    
    HashNode *parent = root;
    HashNode *node = root;
    NSInteger cmp = 0;
    NSUInteger h1 = [key hash];
    HashNode *result = nil;
    BOOL searched = NO;
    do {
        parent = node;
        id k2 = node->_key;
        NSUInteger h2 = node->_hash;
        if (h1 > h2) {
            cmp = 1;
        } else if (h1 < h2) {
            cmp = -1;
        } else if ([key isEqual:k2]) {
            cmp = 0;
        } else if (key && k2 &&
                   [key class] == [k2 class] &&
                   [key respondsToSelector:@selector(compare:)] &&
                   (cmp = [key compare:k2] != 0)) {
        } else if (searched) {
            cmp = &key - &k2; // think!!!
        } else {
            if ((node->_left && (result = [self _node:node->_left key:key])) ||
                (node->_right && (result = [self _node:node->_right key:key]))) {
                node = result; // CARE!!!
                cmp = 0;
            } else {
                cmp = &key - &k2; //think!!!
                searched = YES;
            }
        }
                
        if (cmp > 0) {
            node = node->_right;
        } else if (cmp < 0) {
            node = node->_left;
        } else {
            id old = node->_value;
            node->_key = key;
            node->_value = value;
            return old;
        }
    } while (node);

    HashNode *add = [HashNode nodeWithKey:key value:value parent:parent];
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
    HashNode *node = [self _node:key];
    return node ? node->_value : nil;
}
- (id)remove:(id)key {
    HashNode *node = [self _node:key];
    return [self _remove:node];
}
- (BOOL)containsKey:(id)key {
    return [self _node:key] != nil;
}
- (BOOL)containsValue:(id)value {
    if (_size == 0) { return NO; }
    NSMutableArray *queue = [NSMutableArray array];
    for (NSUInteger i = 0; i < _table.count; i++) {
        HashNode *root = _table[i];
        if (!root || [root isKindOfClass:NSNull.class]) { continue; }
        [queue addObject:root];
        while (queue.count) {
            HashNode *node = queue.firstObject;
            [queue removeObjectAtIndex:0];
            if ([node->_value isEqual:value]) {
                return YES;
            }
            if (node->_left) {
                [queue addObject:node->_left];
            }
            if (node->_right) {
                [queue addObject:node->_right];
            }
        }
    }
    return NO;
}
- (void)traversal:(struct HashMapVisitor *)visitor {
    if (_size == 0 || visitor == NULL) { return; }
    NSMutableArray *queue = [NSMutableArray array];
    for (NSUInteger i = 0; i < _table.count; i++) {
        HashNode *root = _table[i];
        if (!root || [root isKindOfClass:NSNull.class]) { continue; }
        [queue addObject:root];
        while (queue.count) {
            HashNode *node = queue.firstObject;
            [queue removeObjectAtIndex:0];
            if (visitor->stop) { return; }
            visitor->stop = visitor->visit((__bridge void * _Nonnull)(node->_key), (__bridge void * _Nonnull)(node->_value));
            if (node->_left) {
                [queue addObject:node->_left];
            }
            if (node->_right) {
                [queue addObject:node->_right];
            }
        }
    }
}
- (void)print {
    if (_size == 0) { return; }
    for (NSUInteger i = 0; i < _table.count; i++) {
        printf("[index = %zd]\n", i);
        HashNode *root = _table[i];
        if (!root || [root isKindOfClass:NSNull.class]) { continue; }
        ValueTree *tree = [[ValueTree alloc] initWithRoot:root];
        [BinaryTreePrintHandler println:tree];
        printf("----------------------------------------------\n");
    }
}

- (NSUInteger)_index:(id)key {
    if (!key) { return 0; }
    NSUInteger hash = [key hash];
    return (hash ^ (hash >> 16)) & (_capacity - 1);
}
- (NSUInteger)_indexOf:(HashNode *)node {
    return (node->_hash ^ (node->_hash >> 16)) & (_capacity - 1);
}
- (HashNode *)_node:(id)key {
    NSUInteger index = [self _index:key];
    HashNode *root = _table[index];
    if (root && ![root isKindOfClass:NSNull.class]) {
        return [self _node:root key:key];
    }
    return nil;
}
- (HashNode *)_node:(HashNode *)node key:(id)k1 {
    HashNode *result = nil;
    NSUInteger h1 = [k1 hash];
    NSInteger cmp = 0;
    while (node) {
        id k2 = node->_key;
        NSUInteger h2 = node->_hash;
        if (h1 > h2) {
            node = node->_right;
        } else if (h1 < h2) {
            node = node->_left;
        } else if ([k1 isEqual:k2]) {
            return node;
        } else if (k1 && k2 &&
                   [k1 class] == [k2 class] &&
                   [k1 respondsToSelector:@selector(compare:)] &&
                   (cmp = [k1 compare:k2] != 0)) {
            node = cmp > 0 ? node->_right : node->_left;
        } else if (node->_right && (result = [self _node:node->_right key:k1])) {
            return result;
        } else {
            node = node->_left;
        }
    }
    return nil;
}
- (void)_afterPut:(HashNode *)node {
    HashNode *parent = node->_parent;
    
    // root
    if (!parent) {
        [self _black:node];
        return;
    }
    
    // parent is black
    if ([self _isBlack:parent]) { return; }
    
    HashNode *uncle = [parent sibling];
    HashNode *grand = [self _red:parent->_parent];
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
- (void)_rotateLeft:(HashNode *)grand {
    HashNode *parent = grand->_right;
    HashNode *child = parent->_left;
    grand->_right = child;
    parent->_left = grand;
    
    [self _afterRotate:grand parent:parent child:child];
}
- (void)_rotateRight:(HashNode *)grand {
    HashNode *parent = grand->_left;
    HashNode *child = parent->_right;
    grand->_left = child;
    parent->_right = grand;
    
    [self _afterRotate:grand parent:parent child:child];
}
- (void)_afterRotate:(HashNode *)grand parent:(HashNode *)parent child:(HashNode *)child {
    // update parent's parent, become the subtree's root
    parent->_parent = grand->_parent;
    if ([grand isLeftChild]) {
        grand->_parent->_left = parent;
    } else if ([grand isRightChild]) {
        grand->_parent->_right = parent;
    } else {
        // grand is root
        _table[[self _indexOf:grand]] = parent;
    }
    
    // update child's parent
    if (child) {
        child->_parent = grand;
    }
    
    // update grand's parent
    grand->_parent = parent;
}
- (HashNode *)_predcessor:(HashNode *)node {
    if (!node) { return nil; }
    HashNode *p = node->_left;
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
- (HashNode *)_successor:(HashNode *)node {
    if (!node) { return nil; }
    HashNode *s = node->_right;
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
- (id)_remove:(HashNode *)node {
    if (!node) { return nil; }
    id old = node->_value;
    
    _size--;
    if (node->_left && node->_right) {
        HashNode *s = [self _successor:node];
        node->_key = s->_key;
        node->_value = s->_value;
        node = s;
    }
    
    NSUInteger index = [self _indexOf:node];
    HashNode *replace = node->_left ?: node->_right;
    if (replace) {
        replace->_parent = node->_parent;
        if (!node->_parent) {
            _table[index] = replace;
        } else if (node == node->_parent->_left) {
            node->_parent->_left = replace;
        } else {
            node->_parent->_right = replace;
        }
        [self _afterRemove:replace];
    }
    else if (!node->_parent) {
//        _table[index] = nil;
        [_table removeObjectAtIndex:index];
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
- (void)_afterRemove:(HashNode *)node {
    // will remove node is red
    // replace node will remove is red
    if ([self _isRed:node]) {
        [self _black:node];
        return;
    }
    
    HashNode *parent = node->_parent;
    // node is root
    if (!parent) { return; }
    
    // will remove node is black leaf node, underflow
    BOOL left = !parent->_left || [node isLeftChild];
    HashNode *sibling = left ? parent->_right : parent->_left; // CARE!!! find sibling
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



- (HashNode *)_color:(HashNode *)node color:(BOOL)color {
    if (!node) { return node; }
    node->_color = color;
    return node;
}
- (HashNode *)_red:(HashNode *)node {
    return [self _color:node color:RED];
}
- (HashNode *)_black:(HashNode *)node {
    return [self _color:node color:BLACK];
}
- (BOOL)_colorOf:(HashNode *)node {
    return node ? node->_color : BLACK;
}
- (BOOL)_isRed:(HashNode *)node {
    return [self _colorOf:node] == RED;
}
- (BOOL)_isBlack:(HashNode *)node {
    return [self _colorOf:node] == BLACK;
}
@end
