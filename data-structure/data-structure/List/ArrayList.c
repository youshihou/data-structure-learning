//
//  ArrayList.c
//  data-structure
//
//  Created by Ankui on 7/13/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "ArrayList.h"

static int ELEMENT_NOT_FOUND_ = -1;
static int DEFAULT_CAPACITY = 10;

int _size_ = 0;
int _len = 0;
int *elements = NULL;

// MARK: - private
void _outOfBounds(int index) {
    printf("Index: %d, Size: %d\n", index, _size_);
    assert(false);
}

void _rangeCheck(int index) {
    if (index < 0 || index >= _size_) {
        _outOfBounds(index);
    }
}

void _rangeCheckForAdd(int index) {
    if (index < 0 || index > _size_) { // CARE!!! IS index > _size_ NOT index>= _size_
        _outOfBounds(index);
    }
}

void _ensureCapacity(int capacity) {
    int oldCapacity = _len;
    if (oldCapacity >= capacity) { return; }
    
    int newCapacity = oldCapacity + (oldCapacity >> 1);
    _len = newCapacity;
    int *newElements = malloc(sizeof(int) * newCapacity);
    for (int i = 0; i < _size_; i++) { // CARE!!! IS _size_ NOT _len
        newElements[i] = elements[i];
    }
    elements = newElements;
    free(newElements);
    printf("oldCapacity: %d --> newCapacoty: %d\n", oldCapacity, newCapacity);
}

void _trim(void) {
    int oldCapacity = _len;
    int newCapacity = (oldCapacity >> 1);
    if (_size_ >= newCapacity || oldCapacity <= DEFAULT_CAPACITY) { return; } // CARE!!! IS || NOT &&
    
    _len = newCapacity;
    int *newElements = malloc(sizeof(int) * newCapacity); // ERROR!!! why?
    for (int i = 0; i < _size_; i++) {
        newElements[i] = elements[i];
    }
    elements = newElements;
//    free(newElements); // ERROR!!! why?
    printf("oldCapacity: %d --> newCapacoty: %d\n", oldCapacity, newCapacity);
}

// MARK: - public
void createList(int capacity) {
    _len = capacity < DEFAULT_CAPACITY ? DEFAULT_CAPACITY : capacity;
    elements = malloc(sizeof(int) * _len);
}

void _createList() {
    createList(DEFAULT_CAPACITY);
}

int _size(void) {
    return _size_;
}

bool _isEmpty(void) {
    return _size_ == 0;
}

int _indexOf(int element) {
    for (int i = 0; i < _size_; i++) {
        if (elements[i] == element) {
            return i;
        }
    }
    return ELEMENT_NOT_FOUND_;
}

bool _contains(int element) {
    return _indexOf(element) != ELEMENT_NOT_FOUND_;
}

void __add(int index, int element) {
    _rangeCheckForAdd(index);
    
    _ensureCapacity(_size_ + 1);
  
    for (int i = _size_; i > index; i--) { // CARE!!! i = [_size_, index)
        elements[i] = elements[i - 1];
    }

//    for (int i = _size_ - 1; i >= index; i--) { // CARE!!! i = [_size_ - 1, index]
//        elements[i + 1] = elements[i];
//    }
    elements[index] = element;
    _size_++;
}

void _add(int element) {
//    elements[_size_++] = element;
    __add(_size_, element);
}

int _remove(int index) {
    _rangeCheck(index);
    
    int old = elements[index];
//    for (int i = index + 1; i < _size_; i++) { // CARE!!! i = [index + 1, _size_)
//        elements[i - 1] = elements[i];
//    }
    
    for (int i = index + 1; i <= _size_ - 1; i++) { // CARE!!! i = [index + 1, _size_ - 1]
        elements[i - 1] = elements[i];
    }
    _size_--;
    
    _trim();

    return old;
}

int _get(int index) {
    _rangeCheck(index);
    return elements[index];
}

int _set(int index, int element) {
    _rangeCheck(index);
    int old = elements[index];
    elements[index] = element;
    return old;
}

void _clear(void) {
    free(elements);
    _size_ = 0;
}

void _print(void) {
    printf("size = %d, [", _size_);
    for (int i = 0; i < _size_; i++) {
        if (i != 0) {
            printf(", ");
        }
        printf("%d", elements[i]);
    }
    printf("]\n");
}
