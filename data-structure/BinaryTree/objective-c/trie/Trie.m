//
//  Trie.m
//  BinaryTree
//
//  Created by Ankui on 8/6/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "Trie.h"

@interface TrieNode : NSObject {
    @public
    NSMutableDictionary<NSString *, TrieNode *> *_child;
    id _value;
    BOOL _word;
}
@end
@implementation TrieNode
@end

@interface Trie () {
    NSUInteger _size;
    TrieNode *_root;
}
@end

@implementation Trie
+ (instancetype)trie {
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
    _size = 0;
    _root = nil;
}
- (id)get:(NSString *)key {
    TrieNode *node = [self _node:key];
    return node && node->_word ? node->_value : nil;
}
- (BOOL)contains:(NSString *)key {
    TrieNode *node = [self _node:key];
    return node && node->_word;

}
- (id)addKey:(NSString *)key value:(id)value {
    [self _keyCheck:key];
    if (!_root) {
        _root = [[TrieNode alloc] init];
    }
    
    TrieNode *node = _root;
    NSUInteger len = key.length;
    for (NSUInteger i = 0; i < len; i++) {
        unichar c = [key characterAtIndex:i];
        NSString *k = [NSString stringWithCharacters:&c length:1];
        BOOL empty = node->_child == nil;
        TrieNode *childNode = empty ? nil : node->_child[k];
        if (!childNode) {
            childNode = [[TrieNode alloc] init];
            node->_child = empty ? [NSMutableDictionary dictionary] : node->_child;
            node->_child[k] = childNode;
        }
        node = childNode;
    }
    
    if (node->_word) {
        id old = node->_value;
        node->_value = value;
        return old;
    }
    
    node->_word = YES;
    node->_value = value;
    _size++;
    return nil;    
}
- (id)remove:(NSString *)key {
    return nil;
}
- (BOOL)starsWith:(NSString *)prefix {
    return [self _node:prefix] != nil;
}


- (TrieNode *)_node:(NSString *)key {
    [self _keyCheck:key];
    
    TrieNode *node = _root;
    NSUInteger len = key.length;
    for (NSUInteger i = 0; i < len; i++) {
        if (!node || !node->_child || node->_child.count == 0) { return nil; }
        unichar c = [key characterAtIndex:i];
        NSString *k = [NSString stringWithCharacters:&c length:1];
        node = node->_child[k];
    }
    return node;
}
- (void)_keyCheck:(NSString *)key {
    if (key.length == 0) {
        assert("Key must not be empty");
    }
}
@end
