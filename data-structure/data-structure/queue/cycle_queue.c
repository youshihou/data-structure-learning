//
//  cycle_queue.c
//  data-structure
//
//  Created by Ankui on 7/19/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "cycle_queue.h"

int *cycle_elements = NULL;
int cycle_size = 0;
int cycle_len = 0;
int cycle_front = 0;

// MARK: - private
int cycle_queue_index(int idx) {
//    return (cycle_front + idx) % cycle_len;
    idx += cycle_front;
    return idx - (idx >= cycle_len ? cycle_len : 0);
}

void cycle_queue_ensureCapacity(int capacity) {
    int oldCapacity = cycle_len;
    if (oldCapacity >= capacity) { return; }
    
    int newCapacity = oldCapacity + (oldCapacity >> 1);
    int *newElements = malloc(sizeof(int) * newCapacity);
    memset(newElements, -1, sizeof(int) * newCapacity);
    for (int i = 0; i < cycle_size; i++) {
//        int idx = (cycle_front + i) % cycle_len;
        int idx = cycle_queue_index(i);
        newElements[i] = cycle_elements[idx];
    }
    cycle_elements = newElements;
    free(newElements);
    cycle_len = newCapacity;
    printf("oldCapacity: %d --> newCapacoty: %d\n", oldCapacity, newCapacity);
    cycle_front = 0;
}


// MARK: - public
void cycle_queue_create(void) {
    cycle_len = DEFAULT_CAPACITY;
    cycle_elements = malloc(sizeof(int) * cycle_len);
    memset(cycle_elements, -1, sizeof(int) * cycle_len);
}

int cycle_queue_size(void) {
    return cycle_size;
}

bool cycle_queue_isEmpty(void) {
    return cycle_size == 0;
}

void cycle_queue_enqueue(int value) {
    cycle_queue_ensureCapacity(cycle_size + 1);
    
//    int idx = (cycle_front + cycle_size) % cycle_len;
    int idx = cycle_queue_index(cycle_size);
    cycle_elements[idx] = value;
    cycle_size++;
}

int cycle_queue_dequeue(void) {
    int value = cycle_elements[cycle_front];
    cycle_elements[cycle_front] = -1;
//    cycle_front = (cycle_front + 1) % cycle_len;
    cycle_front = cycle_queue_index(1);
    cycle_size--;
    return value;
}

int cycle_queue_front(void) {
    return cycle_elements[cycle_front];
}

void cycle_queue_print(void) {
    printf("capacity = %d, size = %d, front = %d, [", cycle_len, cycle_size, cycle_front);
    for (int i = 0; i < cycle_len; i++) {
        if (i != 0) {
            printf(", ");
        }
        printf("%d", cycle_elements[i]);
    }
    printf("]\n");
}

void cycle_queue_clear(void) {
    for (int i = 0; i < cycle_size; i++) {
        int idx = cycle_queue_index(i);
        cycle_elements[idx] = -1;
    }
    cycle_size = 0;
    cycle_front = 0;
}
