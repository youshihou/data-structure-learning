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




















struct ringbuffer_deque {
    size_t base;
    size_t length;
    size_t size;
    int * contents;
};

#define INITIAL_SIZE (8)

static struct ringbuffer_deque* deque_create_interal(size_t size) {
    struct ringbuffer_deque* d = malloc(sizeof(struct ringbuffer_deque));
    assert(d);
    
    d->base = 0;
    d->length = 0;
    d->size = size;
    d->contents = malloc(sizeof(int) * d->size);
    assert(d->contents);
    
    return d;
}

struct ringbuffer_deque* ringbuffer_deque_create(void) {
    return deque_create_interal(INITIAL_SIZE);
}

int ringbuffer_deque_isEmpty(struct ringbuffer_deque* d) {
    return d->length == 0;
}

int ringbuffer_deque_pop(struct ringbuffer_deque* d, int direction) {
    if (ringbuffer_deque_isEmpty(d)) { return DEQUE_EMPTY; }
    
    if (direction == DEQUE_FRONT) {
        int ret = d->contents[d->base];
        d->base = (d->base + 1) % d->size;
        d->length--;
        return ret;
    } else {
        return d->contents[(d->base + --d->length) % d->size];
    }
}

void ringbuffer_deque_push(struct ringbuffer_deque* d, int value, int direction) {
    if (d->length == d->size) {
        struct ringbuffer_deque* d2 = deque_create_interal(d->size * 2);
        while (!ringbuffer_deque_isEmpty(d)) {
            ringbuffer_deque_push(d2, ringbuffer_deque_pop(d, DEQUE_FRONT), DEQUE_BACK);
        }
        int* old = d->contents;
        *d = *d2;
        free(old);
        free(d2);
    }
    
    if (direction == DEQUE_FRONT) {
        if (d->base == 0) {
            d->base = d->size - 1;
        } else {
            d->base--;
        }
        d->length++;
        d->contents[d->base] = value;
    } else {
        d->contents[(d->base + d->length++) % d->size] = value;
    }
}

void ringbuffer_deque_destroy(struct ringbuffer_deque* d) {
    free(d->contents);
    free(d);
}






















