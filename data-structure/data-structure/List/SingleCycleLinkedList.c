//
//  SingleCycleLinkedList.c
//  data-structure
//
//  Created by Ankui on 7/18/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "SingleCycleLinkedList.h"

int sc_size_ = 0;
struct Node* sc_first = NULL;


// MARK: - private
void sc_outOfBounds(int index) {
    printf("Index: %d, Size: %d", index, sc_size_);
    assert(false);
}

void sc_rangeCheck(int index) {
    if (index < 0 || index >= sc_size_) {
        sc_outOfBounds(index);
    }
}

void sc_rangeCheckForAdd(int index) {
    if (index < 0 || index > sc_size_) {
        sc_outOfBounds(index);
    }
}

struct Node* sc_node(int index) {
    sc_rangeCheck(index);
    
    struct Node* node = sc_first;
    for (int i = 0; i < index; i++) {
        node = node->next;
    }
    return node;
}

// MARK: - public

// use virtual head node
void sc_create(void) {
    sc_first = malloc(sizeof(struct Node));
    sc_first->element = 0;
    sc_first->next = NULL;
}

int sc_size(void) {
    return sc_size_;
}

bool sc_isEmpty(void) {
    return sc_size_ == 0;
}

int sc_indexOf(int element) {
    struct Node* node = sc_first;
    for (int i = 0; i < sc_size_; i++) {
        if (node->element == element) {
            return i;
        }
        node = node->next;
    }
    return ELEMENT_NOT_FOUND;
}

bool sc_contains(int element) {
    return sc_indexOf(element) != ELEMENT_NOT_FOUND;
}

void sc_add_(int index, int element) {
    sc_rangeCheckForAdd(index);
    
    struct Node* _node = malloc(sizeof(struct Node));
    _node->element = element;
        
    if (index == 0) {
        _node->next = sc_first;
        sc_first = _node;
        
        struct Node* last = sc_size_ == 0 ? sc_first : sc_node(sc_size_ - 1);
        last->next = sc_first;
    } else {
        struct Node* prev = sc_node(index - 1);
        _node->next = prev->next;
        prev->next = _node;
    }
    sc_size_++;
}

void sc_add(int element) {
    sc_add_(sc_size_, element);
}

int sc_remove(int index) {
    sc_rangeCheck(index);
    
    struct Node* tmp = sc_first;
    int element = tmp->element;
    if (index == 0) {
        if (sc_size_ == 1) {
            sc_first = NULL;
        } else {
            struct Node* last = sc_node(sc_size_ - 1);
            sc_first = sc_first->next;
            last->next = sc_first;
        }
    } else {
        struct Node* prev = sc_node(index - 1);
        tmp = prev->next;
        element = tmp->element;
        prev->next = prev->next->next;
    }
    free(tmp);
    
    sc_size_--;

    return element;
}


int sc_get(int index) {
    return sc_node(index)->element;
}

int sc_set(int index, int element) {
    struct Node* _node = sc_node(index);
    int old = _node->element;
    _node->element = element;
    return old;
}

void sc_clear(void) {
    while (sc_first) {
        struct Node* tmp = sc_first;
        sc_first = sc_first->next;
        free(tmp);
    }
    sc_size_ = 0;
}

void sc_print(void) {
    printf("size = %d, [", sc_size_);
    
    struct Node* node = sc_first;
    for (int i = 0; i < sc_size_; i++) {
        if (i != 0) {
            printf(", ");
        }
        printf("%d", node->element);
        node = node->next;
    }
    printf("]\n");
}
