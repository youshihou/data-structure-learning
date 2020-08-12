//
//  VirtualLinkedList.m
//  LinkedList
//
//  Created by Ankui on 8/12/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "VirtualLinkedList.h"

@interface VirtualLinkedList () {
    ListNode *_first;
}
@end

@implementation VirtualLinkedList
- (NSString *)description {
    NSMutableString *s = [NSMutableString stringWithFormat:@"size = %zd, [", _size];
    ListNode *node = _first->_next;
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

+ (instancetype)list {
    VirtualLinkedList *list = [[self alloc] init];
    list->_first = [ListNode nodeWithElement:nil next:nil];
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
    ListNode *node = [self _node:index];
    id old = node->_element;
    node->_element = element;
    return old;
}
- (void)add:(NSUInteger)index element:(id)element {
    [self rangeCheckForAdd:index];
    
    ListNode *prev = index == 0 ? _first : [self _node:index - 1];
    prev->_next = [ListNode nodeWithElement:element next:prev->_next];
    _size++;
}
- (id)remove:(NSUInteger)index {
    [self rangeCheck:index];
    
    ListNode *prev = index == 0 ? _first : [self _node:index - 1];
    ListNode *node = prev->_next;
    prev->_next = prev->_next->_next;
    _size--;
    return node->_element;
}
- (NSUInteger)indexOf:(id)element {
    ListNode *node = _first;
    for (NSUInteger i = 0; i < _size; i++) {
        if (node->_element == element) { return i; }
        node = node->_next;
    }
    return ELEMENT_NOT_FOUND;
}

- (ListNode *)_node:(NSUInteger)index {
    [self rangeCheck:index];
    ListNode *node = _first->_next;
    for (NSUInteger i = 0; i < index; i++) {
        node = node->_next;
    }
    return node;
}
@end
