//
//  LinkedList.h
//  data-structure
//
//  Created by Ankui on 7/13/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef LinkedList_h
#define LinkedList_h

#include "common.h"


struct Node {
    int element;
    struct Node* next;
};

int size;
struct Node* first;


int size_(void);
bool isEmpty(void);
int indexOf(int);
bool contains(int);
void add_(int, int);
void add(int);
int remove_(int);
int get(int);
int set(int, int);
void clear_(void);


#endif /* LinkedList_h */
