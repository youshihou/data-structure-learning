//
//  LinkedList.h
//  data-structure
//
//  Created by Ankui on 7/17/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef LinkedList_h
#define LinkedList_h

#include "common.h"

struct ListNode {
    int element;
    struct ListNode* prev;
    struct ListNode* next;
};

void list_create(void);
int list_size(void);
bool list_isEmpty(void);
int list_indexOf(int);
bool list_contains(int);
void list_add_(int, int);
void list_add(int);
int list_remove(int);
int list_get(int);
int list_set(int, int);
void list_clear(void);
void list_print(void);


#endif /* LinkedList_h */
