//
//  CycleLinkedList.c
//  data-structure
//
//  Created by Ankui on 7/18/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "CycleLinkedList.h"

int cl_size_ = 0;
struct ListNode* cl_first = NULL;
struct ListNode* cl_last = NULL;


// MARK: - private
void cl_outOfBounds(int index) {
    printf("Index: %d, Size: %d", index, cl_size_);
    assert(false);
}

void cl_rangeCheck(int index) {
    if (index < 0 || index >= cl_size_) {
        cl_outOfBounds(index);
    }
}

void cl_rangeCheckForAdd(int index) {
    if (index < 0 || index > cl_size_) {
        cl_outOfBounds(index);
    }
}

struct ListNode* cl_node(int index) {
    cl_rangeCheck(index);
    
    if (index < (cl_size_ >> 1)) {
        struct ListNode* node = cl_first;
        for (int i = 0; i < index; i++) {
            node = node->next;
        }
        return node;
    } else {
        struct ListNode* node = cl_last;
        for (int i = cl_size_ - 1; i > index; i--) {
            node = node->prev;
        }
        return node;
    }
}

// MARK: - public

// use virtual head node
//void cl_create(void) {
//    cl_first = malloc(sizeof(struct ListNode));
//    cl_first->element = 0;
//    cl_first->next = NULL;
//    cl_last = malloc(sizeof(struct ListNode));
//    cl_last->element = 0;
//    cl_last->next = NULL;
//}

int cl_size(void) {
    return cl_size_;
}

bool cl_isEmpty(void) {
    return cl_size_ == 0;
}

int cl_indexOf(int element) {
    struct ListNode* node = cl_first;
    for (int i = 0; i < cl_size_; i++) {
        if (node->element == element) {
            return i;
        }
        node = node->next;
    }
    return ELEMENT_NOT_FOUND;
}

bool cl_contains(int element) {
    return cl_indexOf(element) != ELEMENT_NOT_FOUND;
}

void cl_add_(int index, int element) {
    cl_rangeCheckForAdd(index);
    
    struct ListNode* add = malloc(sizeof(struct ListNode));
    add->element = element;
    
    if (index == cl_size_) { // index == cl_size_
        struct ListNode* oldLast = cl_last;
        add->prev = oldLast;
        add->next = cl_first;
        cl_last = add;
        if (oldLast == NULL) { // add the first node
            cl_first = cl_last;
            cl_last->next = cl_first;
            cl_first->prev = cl_first;
        } else {
            oldLast->next = cl_last;
            cl_first->prev = cl_last;
        }
    } else {
        struct ListNode* next = cl_node(index);
        struct ListNode* prev = next->prev;
        add->prev = prev;
        add->next = next;
        next->prev = add;
        prev->next = add;
        if (next == cl_first) { // index == 0
            cl_first = add;
        }
    }
    
    cl_size_++;
}

void cl_add(int element) {
    cl_add_(cl_size_, element);
}

int cl_remove(int index) {
    cl_rangeCheck(index);
    
    struct ListNode* remove = cl_node(index);
    int element = remove->element;
    if (cl_size_ == 1) {
        cl_first = NULL;
        cl_last = NULL;
    } else {
        struct ListNode* prev = remove->prev;
        struct ListNode* next = remove->next;
        prev->next = next;
        next->prev = prev;
        if (remove == cl_first) { // index == 0
            cl_first = next;
        }
        if (remove == cl_last) { // index == cl_size_ - 1
            cl_last = prev;
        }
    }
    free(remove);

    cl_size_--;

    return element;
}


int cl_get(int index) {
    return cl_node(index)->element;
}

int cl_set(int index, int element) {
    struct ListNode* _node = cl_node(index);
    int old = _node->element;
    _node->element = element;
    return old;
}

void cl_clear(void) {
    while (cl_first) {
        struct ListNode* tmp = cl_first;
        cl_first = cl_first->next;
        free(tmp);
    }
    cl_size_ = 0;
}

void cl_print(void) {
    printf("size = %d, [", cl_size_);
    struct ListNode* node = cl_first;
    for (int i = 0; i < cl_size_; i++) {
        if (i != 0) {
            printf(", ");
        }
        if (node->prev) {
            printf("%d", node->prev->element);
        } else {
            printf("NULL");
        }
        printf("_%d_", node->element);
        if (node->next) {
            printf("%d", node->next->element);
        } else {
            printf("NULL");
        }
        node = node->next;
    }
    printf("]\n");
}
