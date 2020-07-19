//
//  cycleQueue.c
//  data-structure
//
//  Created by Ankui on 7/19/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "cycleQueue.h"

int cycle_size = 0;
int cycle_len = 0;
int *elements = NULL;
int front = 0;

void cycle_queue_create(void) {
    cycle_len = DEFAULT_CAPACITY;
    elements = malloc(sizeof(int) * cycle_len);
}

int cycle_queue_size(void) {
    return cycle_size;
}

bool cycle_queue_isEmpty(void) {
    return cycle_size == 0;
}

void cycle_enqueue(int value) {
    int idx = (front + cycle_size) % cycle_len;
    elements[idx] = value;
    cycle_size++;
}

int cycle_dequeue(void) {
    int value = elements[front];
    elements[front] = -1;
    front = (front + 1) % cycle_len;
    cycle_size--;
    return value;
}

int cycle_front(void) {
    return elements[front];
}
