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
- (NSMutableDictionary *)getChild {
    if (!_child) {
        _child = [NSMutableDictionary dictionary];
    }
    return _child;
}
@end

@interface Trie () {
    NSUInteger _size;
    TrieNode *_root;
}
@end

@implementation Trie
- (instancetype)init {
    if (self = [super init]) {
        _root = [[TrieNode alloc] init];
    }
    return self;
}

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
    [_root->_child removeAllObjects];
}
- (id)get:(NSString *)key {
    TrieNode *node = [self _node:key];
    return node ? node->_value : nil;
}
- (BOOL)contains:(NSString *)key {
    return [self _node:key] != nil;

}
- (id)addKey:(NSString *)key value:(id)value {
    [self _keyCheck:key];
    
    TrieNode *node = _root;
    NSUInteger len = key.length;
    for (NSUInteger i = 0; i < len; i++) {
        unichar c = [key characterAtIndex:i];
        NSString *k = [NSString stringWithCharacters:&c length:1];
        TrieNode *childNode = [node getChild][k];
        if (!childNode) {
            childNode = [[TrieNode alloc] init];
            [node getChild][k] = childNode;
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
    [self _keyCheck:prefix];
    
    TrieNode *node = _root;
    NSUInteger len = prefix.length;
    for (NSUInteger i = 0; i < len; i++) {
        unichar c = [prefix characterAtIndex:i];
        NSString *k = [NSString stringWithCharacters:&c length:1];
        node = [node getChild][k];
        if (!node) { return NO; }
    }
    return YES;
}


- (TrieNode *)_node:(NSString *)key {
    [self _keyCheck:key];
    
    TrieNode *node = _root;
    NSUInteger len = key.length;
    for (NSUInteger i = 0; i < len; i++) {
        unichar c = [key characterAtIndex:i];
        NSString *k = [NSString stringWithCharacters:&c length:1];
        node = [node getChild][k];
        if (!node) { return nil; }
    }
    return node->_word ? node : nil;
}
- (void)_keyCheck:(NSString *)key {
    if (key.length == 0) {
        assert("Key must not be empty");
    }
}
@end
