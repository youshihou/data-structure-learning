//
//  deque.c
//  data-structure
//
//  Created by Ankui on 7/19/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "deque.h"

#define NUM_DIRECTIONS (2)

struct deque {
    struct deque* next[NUM_DIRECTIONS];
    int value;
};


Deque* deque_create(void) {
    Deque *d = malloc(offsetof(struct deque, value));
    if (d) {
        d->next[DEQUE_FRONT] = d->next[DEQUE_BACK] = d;
    }
    return d;
}

void deque_push(Deque* d, int value, int direction) {
    assert(direction == DEQUE_FRONT || direction == DEQUE_BACK);
    
    struct deque* e = malloc(sizeof(struct deque));
    assert(e);
    
    e->next[direction] = d->next[direction];
    e->next[!direction] = d;
    e->value = value;
    
    d->next[direction] = e;
    e->next[direction]->next[!direction] = e;
}

int deque_pop(Deque* d, int direction) {
    assert(direction == DEQUE_FRONT || direction == DEQUE_BACK);
    
    struct deque* e = d->next[direction];
    if (e == d) { return DEQUE_EMPTY; }
    
    d->next[direction] = e->next[direction];
    e->next[direction]->next[!direction] = d;
    int ret = e->value;
    free(e);
    return ret;
}

int deque_isEmpty(Deque* d) {
    return d->next[DEQUE_FRONT] == d;
}

void deque_destroy(Deque* d) {
    while (!deque_isEmpty(d)) {
        deque_pop(d, DEQUE_FRONT);
    }
    free(d);
}


