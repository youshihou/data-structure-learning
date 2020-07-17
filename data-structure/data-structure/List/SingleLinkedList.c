//
//  SingleLinkedList.c
//  data-structure
//
//  Created by Ankui on 7/13/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "SingleLinkedList.h"

static int ELEMENT_NOT_FOUND = -1;

int size = 0;
struct Node* first = NULL;


// MARK: - private
void outOfBounds(int index) {
    printf("Index: %d, Size: %d", index, size);
    assert(false);
}

void rangeCheck(int index) {
    if (index < 0 || index >= size) {
        outOfBounds(index);
    }
}

void rangeCheckForAdd(int index) {
    if (index < 0 || index > size) {
        outOfBounds(index);
    }
}

struct Node* node(int index) {
    rangeCheck(index);
    
    struct Node* node = first;
    for (int i = 0; i < index; i++) {
        node = node->next;
    }
    return node;
}

// MARK: - public

// use virtual head node
void create_(void) {
    first = malloc(sizeof(struct Node));
    first->element = 0;
    first->next = NULL;
}

int size_(void) {
    return size;
}

bool isEmpty(void) {
    return size == 0;
}

int indexOf(int element) {
    // use virtual head node
    struct Node* node = first->next;
    
//    struct Node* node = first;
    for (int i = 0; i < size; i++) {
        if (node->element == element) {
            return i;
        }
        node = node->next;
    }
    return ELEMENT_NOT_FOUND;
}

bool contains(int element) {
    return indexOf(element) != ELEMENT_NOT_FOUND;
}

void add_(int index, int element) {
    rangeCheckForAdd(index);
    
    struct Node* _node = malloc(sizeof(struct Node));
    _node->element = element;
    
    // use virtual head node
    struct Node* prev = index == 0 ? first : node(index - 1);
    _node->next = prev->next;
    prev->next = _node;
    
//    if (index == 0) {
////        _node->next = NULL; // error?
////        first->next = _node; // error?
//        _node->next = first; // why?
//        first = _node; // why?
//    } else {
//        struct Node* prev = node(index - 1);
//        _node->next = prev->next;
//        prev->next = _node;
//    }
    size++;
}

void add(int element) {
    add_(size, element);
}

int remove_(int index) {
    rangeCheck(index);
    
    // use virtual head node
    struct Node* prev = index == 0 ? first : node(index - 1);
    struct Node* tmp = prev->next;
    int element = tmp->element;
    prev->next = prev->next->next;
    free(tmp);
    
//    struct Node* tmp = first;
//    int element = tmp->element;
//    if (index == 0) {
//        first = first->next;
//        free(tmp);
//    } else {
//        struct Node* prev = node(index - 1);
//        tmp = prev->next;
//        element = tmp->element;
//        prev->next = prev->next->next;
//        free(tmp);
//    }
    size--;

    return element;
}


int get(int index) {
    return node(index)->element;
}

int set(int index, int element) {
    struct Node* _node = node(index);
    int old = _node->element;
    _node->element = element;
    return old;
}

void clear_(void) {
    // use virtual head node
    
    struct Node* curr = first->next;
    while (curr) {
        struct Node* tmp = curr;
        curr = curr->next;
        free(tmp);
    }
        
//    while (first) {
//        struct Node* tmp = first;
//        first = first->next;
//        free(tmp);
//    }
    size = 0;
}

void print_(void) {
    printf("size = %d, [", size);
    
    // use virtual head node
    struct Node* node = first->next;
    
//    struct Node* node = first;
    for (int i = 0; i < size; i++) {
        if (i != 0) {
            printf(", ");
        }
        printf("%d", node->element);
        node = node->next;
    }
    printf("]\n");
}
