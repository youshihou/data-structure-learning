//
//  stack.c
//  data-structure
//
//  Created by Ankui on 7/18/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "stack.h"

bool stack_isEmpty(struct Node** s) {
    return *s == NULL;
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

void stack_destroy(struct Node** s) {
    while (!stack_isEmpty(s)) {
        stack_pop(s);
    }
    free(*s); // CARE!!!
}

int stack_size(struct Node** s) {
    int size = 0;
    struct Node* e = *s;
    while (e) {
        size++;
        e = e->next;
    }
    return size;
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






struct stack* stack_create(void) {
    struct stack* s = malloc(sizeof(struct stack));
    assert(s);
    
    s->head = NULL;
    
    return s;
}

bool stack_isEmpty_(struct stack* s) {
    return s->head == NULL; // CARE!!!
}

void stack_push_(struct stack* s, int value) {
    struct Node* e = malloc(sizeof(struct Node));
    assert(e);
    
    e->element = value;
    e->next = s->head;
    s->head = e;
}

int stack_pop_(struct stack* s) {
    assert(!stack_isEmpty_(s));
    
    struct Node* e = s->head;
    int ret = e->element;
    s->head = e->next;
    free(e);
    return ret;
}

int stack_top_(struct stack* s) {
    assert(!stack_isEmpty_(s));
    
    return s->head->element;
}

void stack_destroy_(struct stack* s) {
    while (!stack_isEmpty_(s)) {
        stack_pop_(s);
    }
    free(s);
}

int stack_size_(struct stack* s) {
    int size = 0;
    struct Node* e = s->head;
    while (e) {
        size++;
        e = e->next;
    }
    return size;
}

void stack_print_(struct stack* s) {
    int size = stack_size_(s);
    printf("size = %d, [", size);
    struct Node* e = s->head;
    while (e) {
        printf("%d", e->element);
        e = e->next;
        if (e) {
            printf(", ");
        }
    }
    printf("]\n");
}
















struct old_stack* old_stack_create(void) {
    return NULL;
}

struct old_stack* old_stack_push(struct old_stack* old, const char* book) {
    struct old_stack* new = malloc(sizeof(struct old_stack));
    if (new == NULL) { return NULL; }
    new->next = old;
    new->book = strdup(book);
    if (new->book == NULL) {
        free(new);
        return NULL;
    }
    return new;
}

struct old_stack* old_stack_pop(struct old_stack* old, char** book) {
    if (old == NULL) {
        *book = NULL;
        return NULL;
    } else {
        struct old_stack* new = old->next;
        *book = old->book;
        free(old);
        return new;
    }
}

void old_stack_destroy(struct old_stack* s) {
    char* book;
    while (s) {
        s = old_stack_pop(s, &book);
        free(book);
    }
}












struct object_stack** object_stack_create(void) {
    struct object_stack** s = malloc(sizeof(struct object_stack *));
    assert(s);
    
    *s = NULL;
    
    return s;
}

bool object_stack_isEmpty(struct object_stack** s) {
    return *s == NULL;
}

int object_stack_push(struct object_stack** s, const char* book) {
    struct object_stack* new = malloc(sizeof(struct object_stack));
    assert(new);
    
    new->next = *s;
    new->book = strdup(book);
    if (new->book == NULL) {
        free(new);
        return 0;
    }
    *s = new;
    return 1;
}

char* object_stack_pop(struct object_stack** s) {
    if (*s == NULL) {
        return NULL;
    } else {
        char *book = (*s)->book;
        struct object_stack* new = (*s)->next;
        free(*s);
        *s = new;
        return book;
    }
}

void object_stack_destroy(struct object_stack** s) {
    while (!object_stack_isEmpty(s)) {
        free(object_stack_pop(s));
    }
    free(s);
}
