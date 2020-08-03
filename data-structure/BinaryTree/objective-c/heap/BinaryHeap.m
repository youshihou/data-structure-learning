//
//  BinaryHeap.m
//  BinaryTree
//
//  Created by Ankui on 8/2/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BinaryHeap.h"
#import "BinaryTreePrintHandler.h"


@interface BinaryHeap () <BinaryTreeProtocol> {
    NSUInteger _capacity;
    NSMutableArray *_elements;
}
@end

@implementation BinaryHeap

static const NSUInteger DEFAULT_CAPACITY = 10;

- (instancetype)init {
    if (self = [super init]) {
        _capacity = DEFAULT_CAPACITY;
        _elements = [NSMutableArray arrayWithCapacity:DEFAULT_CAPACITY];
    }
    return self;
}
- (void)clear {
    if (_size == 0) { return; }
    [_elements removeAllObjects];
    _size = 0;
}
- (void)add:(id)element {
    [self _elementCheck:element];
    [self _ensureCapacity:_size + 1];
    _elements[_size++] = element;
    [self _siftUp:_size - 1];
}
- (id)get {
    [self _emptyCheck];
    return _elements.firstObject;
}
- (id)remove {
    [self _emptyCheck];
    id top = _elements.firstObject;
    _elements[0] = _elements[_size - 1];
    _size--;
    [_elements removeLastObject];
    [self _siftDown:0];
    return top;
}
- (id)replace:(id)element {
    return nil;
}
- (void)print {
    [BinaryTreePrintHandler println:self];
}

- (void)_siftDown:(NSUInteger)index {
    id element = _elements[index];
    NSUInteger half = _size >> 1;
    while (index < half) {
        NSUInteger lIndex = (index << 1) + 1;
        id left = _elements[lIndex];
        NSUInteger rIndex = lIndex + 1;
        if (rIndex < _size && [self compare:_elements[rIndex] e2:left] > 0) {
            left = _elements[lIndex = rIndex];
        }
        if ([self compare:element e2:left] >= 0) { break; }
        _elements[index] = left;
        index = lIndex; // CARE!!!
    }
    _elements[index] = element;
}
- (void)_siftUp:(NSUInteger)index {
    id element = _elements[index];
    while (index > 0) {
        NSUInteger pIndex = (index - 1) >> 1;
        id parent = _elements[pIndex];
        if ([self compare:element e2:parent] <= 0) { break; }
        _elements[index] = parent;
        index = pIndex; // CARE!!!
    }
    _elements[index] = element;
}
- (void)_ensureCapacity:(NSInteger)capacity {
    if (_capacity >= capacity) { return; }
    _capacity = _capacity + (_capacity >> 1);
    NSMutableArray *oldElements = [NSMutableArray arrayWithArray:_elements];
    _elements = [NSMutableArray arrayWithCapacity:_capacity];
    for (NSUInteger i = 0; i < _size; i++) {
        _elements[i] = oldElements[i];
    }
}
- (void)_emptyCheck {
    if (_size == 0) {
        assert("Heap is empty");
    }
}
- (void)_elementCheck:(id)element {
    if (!element) {
        assert("element msut not be nil");
    }
}


// MARK: - BinaryTreeProtocol
- (id)root {
    return nil;
}
- (id)left:(id)object {
    NSInteger index = [object integerValue];
    index = (index << 1) + 1;
    return index >= _size ? nil : @(index);
}
- (id)right:(id)object {
    NSInteger index = [object integerValue];
    index = (index << 1) + 2;
    return index >= _size ? nil : @(index);
}
- (id)string:(id)object {
    NSInteger index = [object integerValue];
    return _elements[index];
}
@end
