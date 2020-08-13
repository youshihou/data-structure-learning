//
//  SLinkedList.m
//  LinkedList
//
//  Created by Ankui on 8/9/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "SLinkedList.h"

@interface ListNode : NSObject {
    @public
    id _element;
    ListNode *_next;
}
@end
@implementation ListNode
+ (instancetype)nodeWithElement:(id)element next:(ListNode *)next {
    ListNode *node = [[self alloc] init];
    node->_element = element;
    node->_next = next;
    return node;
}
- (void)dealloc {
    NSLog(@"%s - %@", __func__, _element);
}
@end


@interface SLinkedList () {
    ListNode *_first;
}
@end
@implementation SLinkedList
- (NSString *)description {
    NSMutableString *s = [NSMutableString stringWithFormat:@"size = %zd, [", _size];
    ListNode *node = _first;
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
    ListNode *node = [self _node:index];
    id old = node->_element;
    node->_element = element;
    return old;
}
- (void)add:(NSUInteger)index element:(id)element {
    [self rangeCheckForAdd:index];
    
    if (index == 0) {
        ListNode *add = [ListNode nodeWithElement:element next:_first];
        _first = add;
    } else {
        ListNode *prev = [self _node:index - 1];
        ListNode *add = [ListNode nodeWithElement:element next:prev->_next];
        prev->_next = add;
    }
    _size++;
}
- (id)remove:(NSUInteger)index {
    [self rangeCheck:index];
    
    ListNode *node = _first;
    if (index == 0) {
        _first = _first->_next;
    } else {
        ListNode *prev = [self _node:index - 1];
        node = prev->_next;
        prev->_next = prev->_next->_next;
    }
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
    ListNode *node = _first;
    for (NSUInteger i = 0; i < index; i++) {
        node = node->_next;
    }
    return node;
}
@end







@interface VirtualSLinkedList () {
    ListNode *_first;
}
@end
@implementation VirtualSLinkedList
- (NSString *)description {
    NSMutableString *s = [NSMutableString stringWithFormat:@"size = %zd, [", _size];
    if (_first) {
        ListNode *node = _first->_next;
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
    ListNode *node = _first->_next;
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
