//
//  MinHeap.m
//  Graph
//
//  Created by Ankui on 9/3/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "MinHeap.h"

@interface MinHeap () {
    NSInteger _size;
    NSInteger(^_block)(id, id);
    id<MinHeapComparator> _comparator;
    NSMutableArray *_elements;
}
@end

@implementation MinHeap

static const NSUInteger DEFAULT_CAPACITY = 10;

- (instancetype)init {
    self = [super init];
    if (self) {
        _elements = [NSMutableArray arrayWithCapacity:DEFAULT_CAPACITY];
        for (NSInteger i = 0; i < DEFAULT_CAPACITY; i++) {
            [_elements addObject:[NSNull null]];
        }
    }
    return self;
}
- (void)dealloc {
    NSLog(@"%s", __func__);
}
+ (instancetype)heap {
    return [[self alloc] init];
}
+ (instancetype)heapWithBlock:(NSInteger (^)(id _Nullable, id _Nullable))block {
    return [self heapWithArray:nil block:block];
}
+ (instancetype)heapWithComparator:(id<MinHeapComparator>)comparator {
    return [self heapWithArray:nil comparator:comparator];
}
+ (instancetype)heapWithArray:(NSArray *)array {
    return [self heapWithArray:array comparator:nil];
}
+ (instancetype)heapWithArray:(NSArray *)array comparator:(id<MinHeapComparator>)comparator {
    MinHeap *heap = [self heap];
    heap->_comparator = comparator;
    if (array.count) {
        heap->_size = array.count;
        NSInteger capacity = MAX(heap->_size, DEFAULT_CAPACITY);
        heap->_elements = [NSMutableArray arrayWithCapacity:capacity];
        for (NSUInteger i = 0; i < array.count; i++) {
            [heap->_elements addObject:array[i]];
        }
        [heap _heapify];
    }
    return heap;
}
+ (instancetype)heapWithArray:(NSArray *)array block:(NSInteger (^)(id _Nullable, id _Nullable))block {
    MinHeap *heap = [self heap];
    heap->_block = block;
    if (array.count) {
        heap->_size = array.count;
        NSInteger capacity = MAX(heap->_size, DEFAULT_CAPACITY);
        heap->_elements = [NSMutableArray arrayWithCapacity:capacity];
        for (NSUInteger i = 0; i < array.count; i++) {
            [heap->_elements addObject:array[i]];
        }
        [heap _heapify];
    }
    return heap;
}
+ (instancetype)heapWithSet:(NSSet * _Nullable)set {
    return [self heapWithSet:set comparator:nil];
}
+ (instancetype)heapWithSet:(NSSet * _Nullable)set comparator:(id<MinHeapComparator> _Nullable)comparator {
    MinHeap *heap = [self heap];
    heap->_comparator = comparator;
    if (set.count) {
        heap->_size = set.count;
        NSInteger capacity = MAX(heap->_size, DEFAULT_CAPACITY);
        heap->_elements = [NSMutableArray arrayWithCapacity:capacity];
        for (id s in set) {
            [heap->_elements addObject:s];
        }
        [heap _heapify];
    }
    return heap;
}
+ (instancetype)heapWithSet:(NSSet * _Nullable)set block:(NSInteger(^)(id _Nullable, id _Nullable))block {
    MinHeap *heap = [self heap];
    heap->_block = block;
    if (set.count) {
        heap->_size = set.count;
        NSInteger capacity = MAX(heap->_size, DEFAULT_CAPACITY);
        heap->_elements = [NSMutableArray arrayWithCapacity:capacity];
        for (id s in set) {
            [heap->_elements addObject:s];
        }
        [heap _heapify];
    }
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
- (void)addAllArray:(NSArray *)array {
    if (array.count == 0) { return; }
    for (id a in array) {
        [self add:a];
    }
}
- (void)addAllSet:(NSSet *)set {
    if (set.count == 0) { return; }
    for (id s in set) {
        [self add:s];
    }
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
    [self _elementCheck:element];
    id top = _elements.firstObject;
    if (_size == 0) {
        _elements[0] = element;
        _size++;
    } else {
        _elements[0] = element;
        [self _siftDown:0];
    }
    return top;
}

// MARK: - private method
- (NSInteger)_compare:(id)e1 e2:(id)e2 {
    return _block ? _block(e1, e2) : (_comparator ? [_comparator compare:e1 with:e2] : (NSInteger)[e1 compare:e2]);
}
- (void)_heapify {
//    for (NSUInteger i = 0; i < _size; i++) {
//        [self _siftUp:i];
//    }
    for (NSInteger i = (_size >> 1) - 1; i >= 0; i--) {
        [self _siftDown:i];
    }
}
- (void)_siftDown:(NSUInteger)index {
    if (_elements.count == 0) { return; }
    id element = _elements[index];
    NSUInteger half = _size >> 1;
    while (index < half) {
        NSUInteger lIndex = (index << 1) + 1;
        id left = _elements[lIndex];
        NSUInteger rIndex = lIndex + 1;
        if (rIndex < _size && [self _compare:_elements[rIndex] e2:left] > 0) {
            left = _elements[lIndex = rIndex];
        }
        if ([self _compare:element e2:left] >= 0) { break; }
        _elements[index] = left;
        index = lIndex;
    }
    _elements[index] = element;
}
- (void)_siftUp:(NSUInteger)index {
    id element = _elements[index];
    while (index > 0) {
        NSUInteger pIndex = (index - 1) >> 1;
        id parent = _elements[pIndex];
        if ([self _compare:element e2:parent] <= 0) { break; }
        _elements[index] = parent;
        index = pIndex; 
    }
    _elements[index] = element;
}
- (void)_ensureCapacity:(NSInteger)capacity {
    NSInteger oldCapacity = _elements.count;
    if (oldCapacity >= capacity) { return; }
    NSInteger newCapacity = oldCapacity + (oldCapacity >> 1);
    NSMutableArray *oldElements = [NSMutableArray arrayWithArray:_elements];
    _elements = [NSMutableArray arrayWithCapacity:newCapacity];
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
@end
