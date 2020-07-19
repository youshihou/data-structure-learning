//
//  cycle_deque.c
//  data-structure
//
//  Created by Ankui on 7/19/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "cycle_deque.h"

int *cycle_deque_elements = NULL;
int cycle_deque_len = 0;
int cycle_deque_size_ = 0;
int cycle_deque_front_ = 0;

// MARK: - private
int cycle_deque_index(int idx) {
    idx += cycle_deque_front_;
    if (idx < 0) {
        return idx + cycle_deque_len;
    }
//    return idx % cycle_deque_len;
    return idx - (idx >= cycle_deque_len ? cycle_deque_len : 0);
}

void cycle_deque_ensureCapacity(int capacity) {
    int oldCapacity = cycle_deque_len;
    if (oldCapacity >= capacity) { return; }
    
    int newCapacity = oldCapacity + (oldCapacity >> 1);
    int *newElements = malloc(sizeof(int) * newCapacity);
    memset(newElements, -1, sizeof(int) * newCapacity);
    for (int i = 0; i < cycle_deque_size_; i++) {
        int idx = cycle_deque_index(i);
        newElements[i] = cycle_deque_elements[idx];
    }
    cycle_deque_elements = newElements;
    free(newElements);
    cycle_deque_len = newCapacity;
    printf("oldCapacity: %d --> newCapacoty: %d\n", oldCapacity, newCapacity);
    cycle_deque_front_ = 0;
}


// MARK: - public
void cycle_deque_create(void) {
    cycle_deque_len = DEFAULT_CAPACITY;
    cycle_deque_elements = malloc(sizeof(int) * cycle_deque_len);
    memset(cycle_deque_elements, -1, sizeof(int) * cycle_deque_len);
}

int cycle_deque_size(void) {
    return cycle_deque_size_;
}

bool cycle_deque_isEmpty(void) {
    return cycle_deque_size_ == 0;
}

void cycle_deque_enqueue_back(int value) {
    cycle_deque_ensureCapacity(cycle_deque_size_ + 1);
    int idx = cycle_deque_index(cycle_deque_size_);
    cycle_deque_elements[idx] = value;
    cycle_deque_size_++;
}

int cycle_deque_dequeue_back(void) {
    int idx = cycle_deque_index(cycle_deque_size_ - 1);
    int value = cycle_deque_elements[idx];
    cycle_deque_elements[idx] = -1;
    cycle_deque_size_--;
    return value;
}

void cycle_deque_enqueue_front(int value) {
    cycle_deque_ensureCapacity(cycle_deque_size_ + 1);
    int idx = cycle_deque_index(- 1);
    cycle_deque_front_ = idx;
    cycle_deque_elements[cycle_deque_front_] = value;
    cycle_deque_size_++;
}

int cycle_deque_dequeue_front(void) {
    int value = cycle_deque_elements[cycle_deque_front_];
    cycle_deque_elements[cycle_deque_front_] = -1;
    cycle_deque_front_ = cycle_deque_index(1);
    cycle_deque_size_--;
    return value;
}

int cycle_deque_front(void) {
    return cycle_deque_elements[cycle_deque_front_];
}

int cycle_deque_back(void) {
    int idx = cycle_deque_index(cycle_deque_size_ - 1);
    return cycle_deque_elements[idx];
}

void cycle_deque_print(void) {
    printf("capacity = %d, size = %d, front = %d, [", cycle_deque_len, cycle_deque_size_, cycle_deque_front_);
    for (int i = 0; i < cycle_deque_len; i++) {
        if (i != 0) {
            printf(", ");
        }
        printf("%d", cycle_deque_elements[i]);
    }
    printf("]\n");
}

void cycle_deque_clear(void) {
    for (int i = 0; i < cycle_deque_size_; i++) {
        int idx = cycle_deque_index(i);
        cycle_deque_elements[idx] = -1;
    }
    cycle_deque_size_ = 0;
    cycle_deque_front_ = 0;
}
