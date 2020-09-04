//
//  UnionFind.m
//  Graph
//
//  Created by Ankui on 9/4/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "UnionFind.h"

@interface Node : NSObject {
    @public
    id _value;
    Node *_parent;
    NSInteger _rank;
}
@end
@implementation Node
- (instancetype)init {
    self = [super init];
    if (self) {
        _parent = self;
        _rank = 1;
    }
    return self;
}
+ (instancetype)nodeWith:(id)value {
    Node *n = [[self alloc] init];
    n->_value = value;
    return n;
}
- (void)dealloc {
    NSLog(@"%s", __func__);
}
@end


@interface UnionFind () {
    NSMutableDictionary *_nodes;
}
@end
@implementation UnionFind
- (instancetype)init {
    self = [super init];
    if (self) {
        _nodes = [NSMutableDictionary dictionary];
    }
    return self;
}
- (void)dealloc {
    NSLog(@"%s", __func__);
}
+ (instancetype)unionFind {
    return [[self alloc] init];
}
- (void)makeSet:(id)value {
    if (!value) { return; }
    if ([[_nodes allKeys] containsObject:value]) { return; }
    _nodes[value] = [Node nodeWith:value];
}
- (id)find:(id)value {
    Node *node = [self _node:value];
    return node ? node->_value : nil;
}
- (void)unionWith:(id)v1 v2:(id)v2 {
    Node *n1 = [self _node:v1];
    Node *n2 = [self _node:v2];
    if (!n1 || !n2) { return; }
    if ([n1->_value isEqual:n2->_value]) { return; }
    if (n1->_rank < n2->_rank) {
        n1->_parent = n2;
    } else if (n1->_rank > n2->_rank) {
        n2->_parent = n1;
    } else {
        n1->_parent = n2;
        n2->_rank += 1;
    }
}
- (BOOL)isSameWith:(id)v1 v2:(id)v2 {
    return [[self find:v1] isEqual:[self find:v2]];
}

- (Node *)_node:(id)value {
    if (!value) { return nil; }
    Node *node = _nodes[value];
    if (!node) { return nil; }
    while (![node->_value isEqual:node->_parent->_value]) {
        node->_parent = node->_parent->_parent;
        node = node->_parent;
    }
    return node;
}
@end
