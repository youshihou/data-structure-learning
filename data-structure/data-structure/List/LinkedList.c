//
//  DoubleLinkedList.c
//  data-structure
//
//  Created by Ankui on 7/17/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "DoubleLinkedList.h"

static int _ELEMENT_NOT_FOUND = -1;

int listSize = 0;
struct ListNode* listFirst = NULL;
struct ListNode* listLast = NULL;


// MARK: - private
void list_outOfBounds(int index) {
    printf("Index: %d, Size: %d", index, listSize);
    assert(false);
}

void list_rangeCheck(int index) {
    if (index < 0 || index >= listSize) {
        list_outOfBounds(index);
    }
}

void list_rangeCheckForAdd(int index) {
    if (index < 0 || index > listSize) {
        list_outOfBounds(index);
    }
}

struct ListNode* list_node(int index) {
    list_rangeCheck(index);
    
    if (index < (listSize >> 1)) {
        struct ListNode* node = listFirst;
        for (int i = 0; i < index; i++) {
            node = node->next;
        }
        return node;
    } else {
        struct ListNode* node = listLast;
        for (int i = listSize - 1; i > index; i--) { // CARE!!! i = listSize - 1 NOT i = listSize
            node = node->prev; // CARE!!!
        }
        return node;
    }
}

// MARK: - public
void list_create(void) {
    listFirst = malloc(sizeof(struct ListNode));
    listFirst->element = 0;
    listFirst->next = NULL;
    listLast = malloc(sizeof(struct ListNode));
    listLast->element = 0;
    listLast->next = NULL;
}

int list_size(void) {
    return listSize;
}

bool list_isEmpty(void) {
    return listSize == 0;
}

int list_indexOf(int element) {
    struct ListNode* node = listFirst;
    for (int i = 0; i < listSize; i++) {
        if (node->element == element) {
            return i;
        }
        node = node->next;
    }
    return _ELEMENT_NOT_FOUND;
}

bool list_contains(int element) {
    return list_indexOf(element) != _ELEMENT_NOT_FOUND;
}

void list_add_(int index, int element) {
    list_rangeCheckForAdd(index);
    
    struct ListNode* add = malloc(sizeof(struct ListNode));
    add->element = element;
    
    if (index == listSize) { // index == lisSize
        struct ListNode* oldLast = listLast; // CARE!!!
        add->prev = oldLast;
        add->next = NULL;
        listLast = add;
        if (oldLast == NULL) { // add the first node
            listFirst = listLast;
        } else {
            oldLast->next = listLast;
        }
    } else {
        struct ListNode* next = list_node(index);
        struct ListNode* prev = next->prev;
        add->prev = prev;
        add->next = next;
        next->prev = add;
        if (prev == NULL) { // index == 0
            listFirst = add;
        } else {
            prev->next = add;
        }
    }
    
    listSize++;
}

void list_add(int element) {
    list_add_(listSize, element);
}

int list_remove(int index) {
    list_rangeCheck(index);
    
    struct ListNode* remove = list_node(index);
    struct ListNode* prev = remove->prev;
    struct ListNode* next = remove->next;
    int element = remove->element;
    if (prev == NULL) { // index == 0
        listFirst = next;
    } else {
        prev->next = next;
    }
    if (next == NULL) { // index == listSize - 1
        listLast = prev;
    } else {
        next->prev = prev;
    }
    free(remove);

    listSize--;

    return element;
}


int list_get(int index) {
    return list_node(index)->element;
}

int list_set(int index, int element) {
    struct ListNode* _node = list_node(index);
    int old = _node->element;
    _node->element = element;
    return old;
}

void list_clear(void) {
    while (listFirst) {
        struct ListNode* tmp = listFirst;
        listFirst = listFirst->next;
        free(tmp);
    }
    listSize = 0;
}

void list_print(void) {
    printf("size = %d, [", listSize);
    struct ListNode* node = listFirst;
    for (int i = 0; i < listSize; i++) {
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
