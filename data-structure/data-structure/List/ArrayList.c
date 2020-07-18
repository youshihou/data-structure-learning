//
//  ArrayList.c
//  data-structure
//
//  Created by Ankui on 7/13/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "ArrayList.h"

static int DEFAULT_CAPACITY = 10;

int al_size_ = 0;
int al_len = 0;
int *elements = NULL;

// MARK: - private
void al_outOfBounds(int index) {
    printf("Index: %d, Size: %d\n", index, al_size_);
    assert(false);
}

void al_rangeCheck(int index) {
    if (index < 0 || index >= al_size_) {
        al_outOfBounds(index);
    }
}

void al_rangeCheckForAdd(int index) {
    if (index < 0 || index > al_size_) { // CARE!!! IS index > al_size_ NOT index>= al_size_
        al_outOfBounds(index);
    }
}

void al_ensureCapacity(int capacity) {
    int oldCapacity = al_len;
    if (oldCapacity >= capacity) { return; }
    
    int newCapacity = oldCapacity + (oldCapacity >> 1);
    al_len = newCapacity;
    int *newElements = malloc(sizeof(int) * newCapacity);
    for (int i = 0; i < al_size_; i++) { // CARE!!! IS al_size_ NOT _len
        newElements[i] = elements[i];
    }
    elements = newElements;
    free(newElements);
    printf("oldCapacity: %d --> newCapacoty: %d\n", oldCapacity, newCapacity);
}

void al_trim(void) {
    int oldCapacity = al_len;
    int newCapacity = (oldCapacity >> 1);
    if (al_size_ >= newCapacity || oldCapacity <= DEFAULT_CAPACITY) { return; } // CARE!!! IS || NOT &&
    
    al_len = newCapacity;
    int *newElements = malloc(sizeof(int) * newCapacity); // ERROR!!! why?
    for (int i = 0; i < al_size_; i++) {
        newElements[i] = elements[i];
    }
    elements = newElements;
    free(newElements); // ERROR!!! why?
    printf("oldCapacity: %d --> newCapacoty: %d\n", oldCapacity, newCapacity);
}

// MARK: - public
void al_createList(int capacity) {
    al_len = capacity < DEFAULT_CAPACITY ? DEFAULT_CAPACITY : capacity;
    elements = malloc(sizeof(int) * al_len);
}

void al_createList_() {
    al_createList(DEFAULT_CAPACITY);
}

int al_size(void) {
    return al_size_;
}

bool al_isEmpty(void) {
    return al_size_ == 0;
}

int al_indexOf(int element) {
    for (int i = 0; i < al_size_; i++) {
        if (elements[i] == element) {
            return i;
        }
    }
    return ELEMENT_NOT_FOUND;
}

bool al_contains(int element) {
    return al_indexOf(element) != ELEMENT_NOT_FOUND;
}

void al_add_(int index, int element) {
    al_rangeCheckForAdd(index);
    
    al_ensureCapacity(al_size_ + 1);
  
    for (int i = al_size_; i > index; i--) { // CARE!!! i = [al_size_, index)
        elements[i] = elements[i - 1];
    }

//    for (int i = al_size_ - 1; i >= index; i--) { // CARE!!! i = [al_size_ - 1, index]
//        elements[i + 1] = elements[i];
//    }
    elements[index] = element;
    al_size_++;
}

void al_add(int element) {
//    elements[_size_++] = element;
    al_add_(al_size_, element);
}

int al_remove(int index) {
    al_rangeCheck(index);
    
    int old = elements[index];
//    for (int i = index + 1; i < al_size_; i++) { // CARE!!! i = [index + 1, al_size_)
//        elements[i - 1] = elements[i];
//    }
    
    for (int i = index + 1; i <= al_size_ - 1; i++) { // CARE!!! i = [index + 1, al_size_ - 1]
        elements[i - 1] = elements[i];
    }
    al_size_--;
    
    al_trim();

    return old;
}

int al_get(int index) {
    al_rangeCheck(index);
    return elements[index];
}

int al_set(int index, int element) {
    al_rangeCheck(index);
    int old = elements[index];
    elements[index] = element;
    return old;
}

void al_clear(void) {
    free(elements);
    al_size_ = 0;
}

void al_print(void) {
    printf("size = %d, [", al_size_);
    for (int i = 0; i < al_size_; i++) {
        if (i != 0) {
            printf(", ");
        }
        printf("%d", elements[i]);
    }
    printf("]\n");
}
