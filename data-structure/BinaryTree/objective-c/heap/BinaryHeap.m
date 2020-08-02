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
    NSUInteger _size;
    NSUInteger _capacity;
    NSMutableArray *_elements;
    NSInteger(^_block)(id, id);
    id<BinaryHeapComparator> _comparator;
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
+ (instancetype)heap {
    return [[self alloc] init];
}
+ (instancetype)heapWithComparator:(id<BinaryHeapComparator>)comparator {
    BinaryHeap *heap = [BinaryHeap heap];
    heap->_comparator = comparator;
    return heap;
}
+ (instancetype)heapWithBlock:(NSInteger (^)(id _Nullable, id _Nullable))block {
    BinaryHeap *heap = [BinaryHeap heap];
    heap->_block = block;
    return heap;
}

- (NSUInteger)size {
    return _size;
}
- (BOOL)isEmpty {
    return _size == 0;
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
    return nil;
}
- (id)replace:(id)element {
    return nil;
}
- (void)print {
    [BinaryTreePrintHandler println:self];
}

- (void)_siftUp:(NSUInteger)index {
    id e = _elements[index];
    while (index > 0) {
        NSUInteger pIndex = (index - 1) >> 1;
        id p = _elements[pIndex];
        if ([self _compare:e e2:p] <= 0) { return; }
        
        id tmp = _elements[index];
        _elements[index] = _elements[pIndex];
        _elements[pIndex] = tmp;
        index = pIndex; // CARE!!!
    }
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
- (NSInteger)_compare:(id)e1 e2:(id)e2 {
    return _block ? _block(e1, e2) : (_comparator ? [_comparator compare:e1 with:e2] : (NSInteger)[e1 compare:e2]);
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
