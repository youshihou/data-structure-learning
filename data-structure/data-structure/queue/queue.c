//
//  queue.c
//  data-structure
//
//  Created by Ankui on 7/18/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "queue.h"

struct queue* queue_create(void) {
    struct queue* q = malloc(sizeof(struct queue));
    assert(q);
    
    q->head = q->tail = NULL;
    
    return q;
}

bool queue_isEmpty(struct queue* q) {
    return q->head == NULL;
}

void enqueue(struct queue* q, int value) {
    struct Node* e = malloc(sizeof(struct Node));
    assert(e);
    
    e->element = value;
    e->next = NULL;
    if (q->head == NULL) {
        q->head = e;
    } else {
        q->tail->next = e; // CARE!!!
    }
    q->tail = e;
}

int dequeue(struct queue* q) {
    assert(!queue_isEmpty(q));
    
    struct Node* e = q->head;
    int ret = e->element;
    q->head = e->next;
    free(e);
    
    return ret;
}

void queue_destroy(struct queue* q) {
    while (!queue_isEmpty(q)) {
        dequeue(q);
    }
    free(q);
}

int queue_size(struct queue* q) {
    int size = 0;
    struct Node* e = q->head;
    while (e) {
        size++;
        e = e->next;
    }
    return size;
}

void queue_print(struct queue* q) {
    int size = queue_size(q);
    printf("size = %d, [", size);
    struct Node* e = q->head;
    while (e) {
        printf("%d", e->element);
        e = e->next;
        if (e) {
            printf(", ");
        }
    }
    printf("]\n");
}
