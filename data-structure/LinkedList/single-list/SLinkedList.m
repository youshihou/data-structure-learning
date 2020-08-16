//
//  SLinkedList.m
//  LinkedList
//
//  Created by Ankui on 8/9/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "SLinkedList.h"

@interface SListNode : NSObject {
    @public
    id _element;
    SListNode *_next;
}
@end
@implementation SListNode
+ (instancetype)nodeWithElement:(id)element next:(SListNode *)next {
    SListNode *node = [[self alloc] init];
    node->_element = element;
    node->_next = next;
    return node;
}
- (NSString *)description {
    NSMutableString *s = [NSMutableString string];
    [s appendFormat:@"%@_", _element];
    if (_next->_element) {
        [s appendString:[_next->_element stringValue]];
    }
    return s;
}
- (void)dealloc {
    NSLog(@"%s - %@", __func__, _element);
}
@end


@interface SLinkedList () {
    SListNode *_first;
}
@end
@implementation SLinkedList
- (NSString *)description {
    NSMutableString *s = [NSMutableString stringWithFormat:@"size = %zd, [", _size];
    SListNode *node = _first;
    for (NSUInteger i = 0; i < _size; i++) {
        if (i != 0) {
            [s appendString:@", "];
        }
        [s appendFormat:@"%@", node->_element];
        node = node->_next;
    }
    [s appendString:@"]"];
    return s;
}


// MARK: - ListProtocol
- (void)clear {
    _size = 0;
    _first = nil;
}
- (id)get:(NSUInteger)index {
    return [self _node:index]->_element;
}
- (id)set:(NSUInteger)index element:(id)element {
    SListNode *node = [self _node:index];
    id old = node->_element;
    node->_element = element;
    return old;
}
- (void)add:(NSUInteger)index element:(id)element {
    [self rangeCheckForAdd:index];
    
    if (index == 0) {
        SListNode *add = [SListNode nodeWithElement:element next:_first];
        _first = add;
    } else {
        SListNode *prev = [self _node:index - 1];
        SListNode *add = [SListNode nodeWithElement:element next:prev->_next];
        prev->_next = add;
    }
    _size++;
}
- (id)remove:(NSUInteger)index {
    [self rangeCheck:index];
    
    SListNode *node = _first;
    if (index == 0) {
        _first = _first->_next;
    } else {
        SListNode *prev = [self _node:index - 1];
        node = prev->_next;
        prev->_next = prev->_next->_next;
    }
    _size--;
    return node->_element;
}
- (NSUInteger)indexOf:(id)element {
    SListNode *node = _first;
    for (NSUInteger i = 0; i < _size; i++) {
        if (node->_element == element) { return i; }
        node = node->_next;
    }
    return ELEMENT_NOT_FOUND;
}

- (SListNode *)_node:(NSUInteger)index {
    [self rangeCheck:index];
    SListNode *node = _first;
    for (NSUInteger i = 0; i < index; i++) {
        node = node->_next;
    }
    return node;
}
@end







@interface VirtualSLinkedList () {
    SListNode *_first;
}
@end
@implementation VirtualSLinkedList
- (NSString *)description {
    NSMutableString *s = [NSMutableString stringWithFormat:@"size = %zd, [", _size];
    if (_first) {
        SListNode *node = _first->_next;
        for (NSUInteger i = 0; i < _size; i++) {
            if (i != 0) {
                [s appendString:@", "];
            }
            [s appendFormat:@"%@", node->_element];
            node = node->_next;
        }
    }
    [s appendString:@"]"];
    return s;
}
+ (instancetype)list {
    VirtualSLinkedList *list = [[self alloc] init];
    list->_first = [SListNode nodeWithElement:nil next:nil];
    return list;
}

// MARK: - ListProtocol
- (void)clear {
    _size = 0;
    _first = nil;
}
- (id)get:(NSUInteger)index {
    return [self _node:index]->_element;
}
- (id)set:(NSUInteger)index element:(id)element {
    SListNode *node = [self _node:index];
    id old = node->_element;
    node->_element = element;
    return old;
}
- (void)add:(NSUInteger)index element:(id)element {
    [self rangeCheckForAdd:index];
    
    SListNode *prev = index == 0 ? _first : [self _node:index - 1];
    prev->_next = [SListNode nodeWithElement:element next:prev->_next];
    _size++;
}
- (id)remove:(NSUInteger)index {
    [self rangeCheck:index];
    
    SListNode *prev = index == 0 ? _first : [self _node:index - 1];
    SListNode *node = prev->_next;
    prev->_next = prev->_next->_next;
    _size--;
    return node->_element;
}
- (NSUInteger)indexOf:(id)element {
    SListNode *node = _first->_next;
    for (NSUInteger i = 0; i < _size; i++) {
        if (node->_element == element) { return i; }
        node = node->_next;
    }
    return ELEMENT_NOT_FOUND;
}

- (SListNode *)_node:(NSUInteger)index {
    [self rangeCheck:index];
    SListNode *node = _first->_next;
    for (NSUInteger i = 0; i < index; i++) {
        node = node->_next;
    }
    return node;
}
@end








@interface CircleSLinkedList () {
    SListNode *_first;
}
@end
@implementation CircleSLinkedList
- (NSString *)description {
    NSMutableString *s = [NSMutableString stringWithFormat:@"size = %zd, [", _size];
    SListNode *node = _first;
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
    SListNode *node = _first;
    while (node) {
        SListNode *next = node->_next;
        node->_next = nil;
        node = next;
    }
    _size = 0;
    _first = nil;
}
- (id)get:(NSUInteger)index {
    return [self _node:index]->_element;
}
- (id)set:(NSUInteger)index element:(id)element {
    SListNode *node = [self _node:index];
    id old = node->_element;
    node->_element = element;
    return old;
}
- (void)add:(NSUInteger)index element:(id)element {
    [self rangeCheckForAdd:index];
    
    if (index == 0) {
        SListNode *add = [SListNode nodeWithElement:element next:_first];
        SListNode *first = add;
        
        SListNode *last = _size == 0 ? first : [self _node:_size - 1];
        last->_next = first;
        _first = first;
    } else {
        SListNode *prev = [self _node:index - 1];
        SListNode *add = [SListNode nodeWithElement:element next:prev->_next];
        prev->_next = add;
    }
    _size++;
}
- (id)remove:(NSUInteger)index {
    [self rangeCheck:index];
    
    SListNode *node = _first;
    if (index == 0) {
        if (_size == 1) {
            _first = nil;
        } else {
            SListNode *last = [self _node:_size - 1];
            _first = _first->_next;
            last->_next = _first;
        }
    } else {
        SListNode *prev = [self _node:index - 1];
        node = prev->_next;
        prev->_next = prev->_next->_next;
    }
    _size--;
    return node->_element;
}
- (NSUInteger)indexOf:(id)element {
    SListNode *node = _first;
    for (NSUInteger i = 0; i < _size; i++) {
        if (node->_element == element) { return i; }
        node = node->_next;
    }
    return ELEMENT_NOT_FOUND;
}

- (SListNode *)_node:(NSUInteger)index {
    [self rangeCheck:index];
    SListNode *node = _first;
    for (NSUInteger i = 0; i < index; i++) {
        node = node->_next;
    }
    return node;
}
@end
