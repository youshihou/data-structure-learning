//
//  queue.h
//  data-structure
//
//  Created by Ankui on 7/18/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef queue_h
#define queue_h

#include "common.h"

struct queue {
    struct Node* head;
    struct Node* tail;
};

struct queue* queue_create(void);
bool queue_isEmpty(struct queue*);
void enqueue(struct queue*, int);
int dequeue(struct queue*);
void queue_destroy(struct queue*);
void queue_print(struct queue*);
int queue_size(struct queue*);

#endif /* queue_h */
