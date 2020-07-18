//
//  stack.c
//  data-structure
//
//  Created by Ankui on 7/18/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "stack.h"

int stack_size(struct Node** s) {
    int size = 0;
    struct Node* e = *s;
    while (e) {
        size++;
        e = e->next;
    }
    return size;
}

bool stack_isEmpty(struct Node** s) {
    return (*s == NULL);
}

void stack_push(struct Node** s, int value) {
    struct Node* e = malloc(sizeof(struct Node));
    assert(e);
    
    e->element = value;
    e->next = *s; // CARE!!!
    *s = e; // CARE!!!
}

int stack_pop(struct Node** s) {
    assert(!stack_isEmpty(s));
    
    struct Node* e = *s;
    int ret = e->element;
    *s = e->next;
    free(e);
    return ret;
}

int stack_top(struct Node** s) {
    assert(!stack_isEmpty(s));
    
    return (*s)->element;
}

void stack_print(struct Node** s) {
    int size = stack_size(s);
    printf("size = %d, [", size);
    struct Node* e = *s;
    while (e) {
        printf("%d", e->element);
        e = e->next;
        if (e) {
            printf(", ");
        }
    }
    printf("]\n");
}
