//
//  binary_heap.c
//  data-structure
//
//  Created by Ankui on 8/2/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "binary_heap.h"

int heap_size_ = 0;
int heap_capacity = 0;
int *heap_elements = NULL;

// MARK: - private
void heap_empty_check(void) {
    if (heap_size_ == 0) {
        assert("Heap is empty");
    }
}
void heap_ensure_capacity(int capacity) {
    if (heap_capacity >= capacity) { return; }
    
    heap_capacity = heap_capacity + (heap_capacity >> 1);
    int *newElements = malloc(sizeof(int) * heap_capacity);
    for (int i = 0; i < heap_size_; i++) {
        newElements[i] = heap_elements[i];
    }
    heap_elements = newElements;
    free(newElements);
}
void heap_sift_up(int index) {
    int e = heap_elements[index];
    while (index > 0) {
        int pIndex = (index - 1) >> 1;
        int p = heap_elements[pIndex];
        if (e <= p) { break;; }
        heap_elements[index] = p;
        index = pIndex;
    }
    heap_elements[index] = e;
    
//    while (index > 0) {
//        int pIndex = (index - 1) >> 1;
//        int p = heap_elements[pIndex];
//        if (e <= p) { return; }
//        int tmp = heap_elements[index];
//        heap_elements[index] = heap_elements[pIndex];
//        heap_elements[pIndex] = tmp;
//        index = pIndex;
//    }
}
void heap_sift_down(int index) {
    int e = heap_elements[index];
    int half = heap_size_ >> 1;
    while (index < half) {
        int lIndex = (index << 1) + 1;
        int left = heap_elements[lIndex];
        int rIndex = lIndex + 1;
        if (rIndex < heap_size_ && heap_elements[rIndex] > left) {
            left = heap_elements[lIndex = rIndex];
        }
        if (e >= left) { break; }
        heap_elements[index] = left;
        index = lIndex;
    }
    heap_elements[index] = e;
}

void heap_heapify(void) {
//    for (int i = 1; i < heap_size_; i++) {
//        heap_sift_up(i);
//    }
    
    for (int i = (heap_size_ >> 1) - 1; i >= 0; i--) {
        heap_sift_down(i);
    }
}


void create_heap_list(int* arr, int size) {
    if (size == 0) {
        heap_capacity = DEFAULT_CAPACITY;
        heap_elements = malloc(sizeof(int) * heap_capacity);
    } else {
        heap_size_ = size;
        heap_capacity = fmax(DEFAULT_CAPACITY, size);
        heap_elements = malloc(sizeof(int) * heap_capacity);
        for (int i = 0; i < size; i++) {
            heap_elements[i] = arr[i];
        }
        heap_heapify();
    }
}

void create_heap(void) {
    heap_capacity = DEFAULT_CAPACITY;
    heap_elements = malloc(sizeof(int) * heap_capacity);
}
int heap_size(void) {
    return heap_size_;
}
bool heap_isEmpty(void) {
    return heap_size_ == 0;
}
void heap_clear(void) {
    if (heap_size_ == 0) { return; }
    free(heap_elements);
    heap_size_ = 0;
}
void heap_add(int element) {
    heap_ensure_capacity(heap_size_ + 1);
    heap_elements[heap_size_++] = element;
    heap_sift_up(heap_size_ - 1);
}
int heap_get(void) {
    heap_empty_check();
    return heap_elements[0];
}
int heap_remove(void) {
    heap_empty_check();
    int top = heap_elements[0];
    int lastIndex = --heap_size_;
    heap_elements[0] = heap_elements[lastIndex];
    heap_elements[lastIndex] = -1;
    heap_sift_down(0);
    return top;
}
int heap_replace(int element) {
    int top = -1;
    if (heap_size_ == 0) {
        heap_elements[0] = element;
        heap_size_++;
    } else {
        top = heap_elements[0];
        heap_elements[0] = element;
        heap_sift_down(0);
    }
    return top;
}
