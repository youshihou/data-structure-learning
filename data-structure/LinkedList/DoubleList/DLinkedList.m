//
//  DLinkedList.m
//  LinkedList
//
//  Created by Ankui on 8/13/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "DLinkedList.h"

@interface DListNode : NSObject {
    @public
    id _element;
    DListNode *_prev;
    DListNode *_next;
}
@end
@implementation DListNode
+ (instancetype)nodeWith:(DListNode *)prev element:(id)element next:(DListNode *)next {
    DListNode *node = [[self alloc] init];
    node->_prev = prev;
    node->_element = element;
    node->_next = next;
    return node;
}
- (NSString *)description {
    NSMutableString *s = [NSMutableString string];
    if (_prev) {
        [s appendString:[_prev->_element stringValue]];
    } else {
        [s appendString:@"null"];
    }
    [s appendFormat:@"_%@_", _element];
    if (_next) {
        [s appendString:[_next->_element stringValue]];
    } else {
        [s appendString:@"null"];
    }
    return s;
}
- (void)dealloc {
    NSLog(@"%s - %@", __func__, _element);
}
@end


@interface DLinkedList () {
    DListNode *_first;
    DListNode *_last;
}
@end
@implementation DLinkedList
- (NSString *)description {
    NSMutableString *s = [NSMutableString stringWithFormat:@"size = %zd, [", _size];
    DListNode *node = _first;
    for (NSUInteger i = 0; i < _size; i++) {
        if (i != 0) {
            [s appendString:@", "];
        }
        [s appendFormat:@"%@", node];
        node = node->_next;
    }
    [s appendString:@"]"];
    return s;
}


// MARK: - ListProtocol
- (void)clear {
    DListNode *node = _first;
    while (node) {
        DListNode *next = node->_next;
        node->_prev = nil;
        node->_next = nil;
        node = next;
    }
    _size = 0;
    _first = nil;
    _last = nil;
}
- (id)get:(NSUInteger)index {
    return [self _node:index]->_element;
}
- (id)set:(NSUInteger)index element:(id)element {
    DListNode *node = [self _node:index];
    id old = node->_element;
    node->_element = element;
    return old;
}
- (void)add:(NSUInteger)index element:(id)element {
    [self rangeCheckForAdd:index];
    if (index == _size) {
        DListNode *oldLast = _last;
        DListNode *add = [DListNode nodeWith:oldLast element:element next:nil];
        _last = add;
        if (!oldLast) { // add the first node
            _first = _last;
        } else {
            oldLast->_next = _last;
        }
    } else {
        DListNode *next = [self _node:index];
        DListNode *prev = next->_prev;
        DListNode *add = [DListNode nodeWith:prev element:element next:next];
        next->_prev = add;
        if (!prev) { // index == 0
            _first = add;
        } else {
            prev->_next = add;
        }
    }
    _size++;
}
- (id)remove:(NSUInteger)index {
    [self rangeCheck:index];
    DListNode *node = [self _node:index];
    DListNode *prev = node->_prev;
    DListNode *next = node->_next;
    if (!prev) { // index == 0
        _first = next;
    } else {
        prev->_next = next;
    }
    if (!next) { // index == _size - 1
        _last = prev;
    } else {
        next->_prev = prev;
    }
    _size--;
    return node->_element;
}
- (NSUInteger)indexOf:(id)element {
    DListNode *node = _first;
    for (NSUInteger i = 0; i < _size; i++) {
        if (node->_element == element) { return i; }
        node = node->_next;
    }
    return ELEMENT_NOT_FOUND;
}

- (DListNode *)_node:(NSUInteger)index {
    [self rangeCheck:index];
    if (index < (_size >> 1)) {
        DListNode *node = _first;
        for (NSUInteger i = 0; i < index; i++) {
            node = node->_next;
        }
        return node;
    } else {
        DListNode *node = _last;
        for (NSUInteger i = _size - 1; i > index; i--) {
            node = node->_prev;
        }
        return node;
    }
}
@end


















@interface CircleDLinkedList () {
    DListNode *_first;
    DListNode *_last;
    DListNode *_current;
}
@end
@implementation CircleDLinkedList
- (NSString *)description {
    NSMutableString *s = [NSMutableString stringWithFormat:@"size = %zd, [", _size];
    DListNode *node = _first;
    for (NSUInteger i = 0; i < _size; i++) {
        if (i != 0) {
            [s appendString:@", "];
        }
        [s appendFormat:@"%@", node];
        node = node->_next;
    }
    [s appendString:@"]"];
    return s;
}

- (void)reset {
    _current = _first;
}
- (id)next {
    if (!_current) { return nil; }
    _current = _current->_next;
    return _current->_element;
}
- (id)remove {
    if (!_current) { return nil; }
    DListNode *next = _current->_next;
    id element = [self _remove:_current];
    if (_size == 0) {
        _current = nil;
    } else {
        _current = next;
    }
    return element;
}



// MARK: - ListProtocol
- (void)clear {
    DListNode *node = _first;
    while (node) {
        DListNode *next = node->_next;
        node->_prev = nil;
        node->_next = nil;
        node = next;
    }
    _size = 0;
    _first = nil;
    _last = nil;
}
- (id)get:(NSUInteger)index {
    return [self _node:index]->_element;
}
- (id)set:(NSUInteger)index element:(id)element {
    DListNode *node = [self _node:index];
    id old = node->_element;
    node->_element = element;
    return old;
}
- (void)add:(NSUInteger)index element:(id)element {
    [self rangeCheckForAdd:index];
    if (index == _size) {
        DListNode *oldLast = _last;
        DListNode *add = [DListNode nodeWith:oldLast element:element next:_first];
        _last = add;
        if (!oldLast) { // add the first node
            _first = _last;
            _first->_next = _first;
            _first->_prev = _first;
        } else {
            oldLast->_next = _last;
            _first->_prev = _last;
        }
    } else {
        DListNode *next = [self _node:index];
        DListNode *prev = next->_prev;
        DListNode *add = [DListNode nodeWith:prev element:element next:next];
        next->_prev = add;
        prev->_next = add;
        if (next == _first) { // index == 0
            _first = add;
        }
    }
    _size++;
}
- (id)remove:(NSUInteger)index {
    [self rangeCheck:index];
    DListNode *node = [self _node:index];
    return [self _remove:node];
}
- (NSUInteger)indexOf:(id)element {
    DListNode *node = _first;
    for (NSUInteger i = 0; i < _size; i++) {
        if (node->_element == element) { return i; }
        node = node->_next;
    }
    return ELEMENT_NOT_FOUND;
}

- (DListNode *)_node:(NSUInteger)index {
    [self rangeCheck:index];
    if (index < (_size >> 1)) {
        DListNode *node = _first;
        for (NSUInteger i = 0; i < index; i++) {
            node = node->_next;
        }
        return node;
    } else {
        DListNode *node = _last;
        for (NSUInteger i = _size - 1; i > index; i--) {
            node = node->_prev;
        }
        return node;
    }
}
- (id)_remove:(DListNode *)node {
    if (_size == 1) {
        _first = nil;
        _last = nil;
    } else {
        DListNode *prev = node->_prev;
        DListNode *next = node->_next;
        prev->_next = next;
        next->_prev = prev;
        if (node == _first) { // index == 0
            _first = next;
        }
        if (node == _last) { // index == _size - 1
            _last = prev;
        }
    }
    _size--;
    return node->_element;
}
@end
