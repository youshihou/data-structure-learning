//
//  cycle_queue.c
//  data-structure
//
//  Created by Ankui on 7/19/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "cycle_queue.h"

int cycle_size = 0;
int cycle_len = 0;
int *cycle_elements = NULL;
int front = 0;

void cycle_queue_create(void) {
    cycle_len = DEFAULT_CAPACITY;
    cycle_elements = malloc(sizeof(int) * cycle_len);
}

int cycle_queue_size(void) {
    return cycle_size;
}

bool cycle_queue_isEmpty(void) {
    return cycle_size == 0;
}

void cycle_enqueue(int value) {
    int idx = (front + cycle_size) % cycle_len;
    cycle_elements[idx] = value;
    cycle_size++;
}

int cycle_dequeue(void) {
    int value = cycle_elements[front];
    cycle_elements[front] = -1;
    front = (front + 1) % cycle_len;
    cycle_size--;
    return value;
}

int cycle_front(void) {
    return cycle_elements[front];
}

void cycle_print(void) {
    printf("capacity = %d, size = %d, [", cycle_len, cycle_size);
    for (int i = 0; i < cycle_len; i++) {
        if (i != 0) {
            printf(", ");
        }
        printf("%d", cycle_elements[i]);
    }
    printf("]\n");

}
