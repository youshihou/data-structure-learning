//
//  SingleLinkedList.c
//  data-structure
//
//  Created by Ankui on 7/13/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "SingleLinkedList.h"

int sl_size_ = 0;
struct Node* first = NULL;


// MARK: - private
void sl_outOfBounds(int index) {
    printf("Index: %d, Size: %d", index, sl_size_);
    assert(false);
}

void sl_rangeCheck(int index) {
    if (index < 0 || index >= sl_size_) {
        sl_outOfBounds(index);
    }
}

void sl_rangeCheckForAdd(int index) {
    if (index < 0 || index > sl_size_) {
        sl_outOfBounds(index);
    }
}

struct Node* sl_node(int index) {
    sl_rangeCheck(index);
    
    struct Node* node = first;
    for (int i = 0; i < index; i++) {
        node = node->next;
    }
    return node;
}

// MARK: - public

// use virtual head node
void sl_create(void) {
    first = malloc(sizeof(struct Node));
    first->element = 0;
    first->next = NULL;
}

int sl_size(void) {
    return sl_size_;
}

bool sl_isEmpty(void) {
    return sl_size_ == 0;
}

int sl_indexOf(int element) {
    // use virtual head node
    struct Node* node = first->next;
    
//    struct Node* node = first;
    for (int i = 0; i < sl_size_; i++) {
        if (node->element == element) {
            return i;
        }
        node = node->next;
    }
    return ELEMENT_NOT_FOUND;
}

bool csl_ontains(int element) {
    return sl_indexOf(element) != ELEMENT_NOT_FOUND;
}

void sl_add_(int index, int element) {
    sl_rangeCheckForAdd(index);
    
    struct Node* _node = malloc(sizeof(struct Node));
    _node->element = element;
    
    // use virtual head node
    struct Node* prev = index == 0 ? first : sl_node(index - 1);
    _node->next = prev->next;
    prev->next = _node;
    
//    if (index == 0) {
////        _node->next = NULL; // error?
////        first->next = _node; // error?
//        _node->next = first; // why?
//        first = _node; // why?
//    } else {
//        struct Node* prev = sl_node(index - 1);
//        _node->next = prev->next;
//        prev->next = _node;
//    }
    sl_size_++;
}

void sl_add(int element) {
    sl_add_(sl_size_, element);
}

int sl_remove(int index) {
    sl_rangeCheck(index);
    
    // use virtual head node
    struct Node* prev = index == 0 ? first : sl_node(index - 1);
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
//        struct Node* prev = sl_node(index - 1);
//        tmp = prev->next;
//        element = tmp->element;
//        prev->next = prev->next->next;
//        free(tmp);
//    }
    sl_size_--;

    return element;
}


int sl_get(int index) {
    return sl_node(index)->element;
}

int sl_set(int index, int element) {
    struct Node* _node = sl_node(index);
    int old = _node->element;
    _node->element = element;
    return old;
}

void sl_clear(void) {
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
    sl_size_ = 0;
}

void sl_print(void) {
    printf("size = %d, [", sl_size_);
    
    // use virtual head node
    struct Node* node = first->next;
    
//    struct Node* node = first;
    for (int i = 0; i < sl_size_; i++) {
        if (i != 0) {
            printf(", ");
        }
        printf("%d", node->element);
        node = node->next;
    }
    printf("]\n");
}
