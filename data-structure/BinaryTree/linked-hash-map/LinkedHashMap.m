//
//  LinkedHashMap.m
//  BinaryTree
//
//  Created by Ankui on 8/2/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "LinkedHashMap.h"

@interface LinkedHashNode : HashNode {
    @public
    LinkedHashNode *_prev;
    LinkedHashNode *_next;
}
@end
@implementation LinkedHashNode
@end


@interface LinkedHashMap () {
    LinkedHashNode *_first;
    LinkedHashNode *_last;
}
@end

@implementation LinkedHashMap
- (void)clear {
    [super clear];
    
    _first = nil;
    _last = nil;
}
- (BOOL)containsValue:(id)value {
    LinkedHashNode *node = _first;
    while (node) {
        if (value == nil ? node->_value == nil : [node->_value isEqual:value]) {
            return YES;
        }
        node = node->_next;
    }
    return NO;
}
- (void)traversal:(struct HashMapVisitor *)visitor {
    if (visitor == NULL) { return; }
    LinkedHashNode *node = _first;
    while (node) {
        if (visitor->stop) { return; }
        visitor->stop = visitor->visit((__bridge void * _Nonnull)(node->_key), (__bridge void * _Nonnull)(node->_value));
        node = node->_next;
    }
}

- (HashNode *)createNode:(id)key value:(id)value parent:(HashNode *)parent {
    LinkedHashNode *node = [LinkedHashNode nodeWithKey:key value:value parent:parent];
    if (!_first) {
        _first = _last = node;
    } else {
        _last->_next = node;
        node->_prev = _last;
        _last = node;
    }
    return node;
}
- (void)afterRemove:(HashNode *)node will:(HashNode *)will {
    LinkedHashNode *removeNode = (LinkedHashNode *)node;
    LinkedHashNode *willNode = (LinkedHashNode *)will;
    if (removeNode != willNode) {
        // prev
        LinkedHashNode *tmp = willNode->_prev;
        willNode->_prev = removeNode->_prev;
        removeNode->_prev = tmp;
        if (!willNode->_prev) {
            _first = willNode;
        } else {
            willNode->_prev->_next = willNode;
        }
        if (!removeNode->_prev) {
            _first = removeNode;
        } else {
            removeNode->_prev->_next = removeNode;
        }
        
        // next
        tmp = willNode->_next;
        willNode->_next = removeNode->_next;
        removeNode->_next = tmp;
        if (!willNode->_next) {
            _last = willNode;
        } else {
            willNode->_next->_prev = willNode;
        }
        if (!removeNode->_next) {
            _last = removeNode;
        } else {
            removeNode->_next->_prev = removeNode;
        }
    }
    LinkedHashNode *prev = removeNode->_prev;
    LinkedHashNode *next = removeNode->_next;
    if (!prev) {
        _first = next;
    } else {
        prev->_next = next;
    }
    if (!next) {
        _last = prev;
    } else {
        next->_prev = prev;
    }
}
@end
