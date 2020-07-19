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




















#define RIGHT (0)
#define LEFT (1)

typedef struct elt {
    struct elt* next[2];
} *Elt;

Elt listCreate(void) {
    Elt e;
    e = malloc(sizeof(*e));
    if (e) {
        e->next[LEFT] = e->next[RIGHT] = e;
    }
    return e;
}

void listRemove(Elt e) {
    e->next[RIGHT]->next[LEFT] = e->next[LEFT];
    e->next[LEFT]->next[RIGHT] = e->next[RIGHT];
}

void listInsert(Elt head, int dir, Elt e) {
    e->next[dir] = head->next[dir];
    e->next[!dir] = head;
    
    e->next[dir]->next[!dir] = e;
    e->next[!dir]->next[dir] = e;
}

void listSplit(Elt e1, Elt e2) {
    e2->next[RIGHT]->next[LEFT] = e1->next[LEFT];
    e1->next[LEFT]->next[RIGHT] = e2->next[RIGHT];
    
    e2->next[RIGHT] = e1;
    e1->next[LEFT] = e2;
}

void listSplice(Elt e1, Elt e2) {
    e2->next[LEFT]->next[RIGHT] = e1->next[RIGHT];
    e1->next[RIGHT]->next[LEFT] = e2->next[LEFT];
    
    e1->next[RIGHT] = e2;
    e2->next[LEFT] = e1;
}

void listDestroy(Elt e) {
    Elt next = NULL;
    Elt target = e->next[RIGHT];
    for (; target != e; target = next) {
        next = target->next[RIGHT];
        free(target);
    }
    
//    while (target != e) {
//        next = target->next[RIGHT];
//        free(target);
//        target = next;
//    }
    
    free(e);
}

//void listSanityCheck(Elt e) {
//    assert(e != NULL);
//
//    Elt check = e;
//    do {
//        assert(check->next[RIGHT]->next[LEFT] == check);
//        assert(check->next[LEFT]->next[RIGHT] == check);
//        check = check->next[RIGHT];
//    } while (check != e);
//}

//struct elt_ {
//    struct elt_* next[2];
//    char* name;
//    int socialSecurityNumber;
//    int gullibility;
//};
//
//struct fancyElt {
//    struct elt* next[2];
//    char* name;
//    int socialSecurityNumber;
//    int gullibility;
//};
