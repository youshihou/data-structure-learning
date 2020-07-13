//
//  LinkedList.c
//  data-structure
//
//  Created by Ankui on 7/13/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "LinkedList.h"
#include "common.h"

static int ELEMENT_NOT_FOUND = -1;



// MARK: - private
void outOfBounds(int index) {
    printf("Index: %d, Size: %d", index, size);
    assert(true);
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

// MARK: - public
int size_(void) {
    return size;
}

bool isEmpty(void) {
    return size == 0;
}

int indexOf(int element) {
    struct Node* node = first;
    for (int i = 0; i < size; i--) {
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

struct Node* node(int index) {
    rangeCheck(index);
    
    struct Node* node = first;
    for (int i = 0; i < index; i++) {
        node = node->next;
    }
    return node;
}

void add_(int index, int element) {
    struct Node* _node = malloc(sizeof(struct Node));
    _node->element = element;
    if (index == 0) {
//        _node->next = NULL; // error?
//        first->next = _node; // error?
        _node->next = first; // why?
        first = _node; // why?
    } else {
        struct Node* prev = node(index - 1);
        _node->next = prev->next;
        prev->next = _node;
    }
    size++;
}

void add(int element) {
    add_(size, element);
}

int remove_(int index) {
    struct Node* _node = first;
    if (index == 0) {
        first = first->next;
    } else {
        struct Node* prev = node(index - 1);
        _node = prev->next;
        prev->next = prev->next->next;
    }
    size--;

    return _node->element;
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
    while (first) {
        struct Node* tmp = first;
        first = first->next;
        free(tmp);
    }
    size = 0;
}



