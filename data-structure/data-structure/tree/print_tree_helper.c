//
//  print_tree_helper.c
//  data-structure
//
//  Created by Ankui on 7/20/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "print_tree_helper.h"

struct object_queue* object_queue_create(void) {
    struct object_queue* q = malloc(sizeof(struct object_queue));
    assert(q);
    q->head = q->tail = NULL;
    return q;
}

bool object_queue_isEmpty(struct object_queue* q) {
    return q->head == NULL;
}

void object_queue_enqueue(struct object_queue* q, void* value) {
    struct object_node* e = malloc(sizeof(struct object_node));
    assert(e);
    e->value = value;
    e->next = NULL;
    if (q->head == NULL) {
        q->head = e;
    } else {
        q->tail->next = e;
    }
    q->tail = e;
}

void* object_queue_dequeue(struct object_queue* q) {
    assert(!object_queue_isEmpty(q));
    struct object_node* e = q->head;
    void* ret = e->value;
    q->head = e->next;
    free(e);
    return ret;
}

void object_queue_destroy(struct object_queue* q) {
    while (!object_queue_isEmpty(q)) {
        object_queue_dequeue(q);
    }
    free(q);
}

int object_queue_size(struct object_queue* q) {
    int size = 0;
    struct object_node* e = q->head;
    while (e) {
        size++;
        e = e->next;
    }
    return size;
}

void* object_queue_front(struct object_queue* q) {
    assert(!object_queue_isEmpty(q));
    return q->head->value;
}
