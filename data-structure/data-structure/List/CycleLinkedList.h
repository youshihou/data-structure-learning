//
//  CycleLinkedList.h
//  data-structure
//
//  Created by Ankui on 7/18/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef CycleLinkedList_h
#define CycleLinkedList_h

#include "common.h"

//void cl_create(void);
int cl_size(void);
bool cl_isEmpty(void);
int cl_indexOf(int);
bool cl_contains(int);
void cl_add_(int, int);
void cl_add(int);
int cl_remove(int);
int cl_get(int);
int cl_set(int, int);
void cl_clear(void);
void cl_print(void);

void cl_reset(void);
int cl_next(void);
int cl_remove_(void);

#endif /* CycleLinkedList_h */
