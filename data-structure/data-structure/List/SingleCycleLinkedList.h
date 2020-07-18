//
//  SingleCycleLinkedList.h
//  data-structure
//
//  Created by Ankui on 7/18/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef SingleCycleLinkedList_h
#define SingleCycleLinkedList_h

#include "common.h"

void sc_create(void);
int sc_size(void);
bool sc_isEmpty(void);
int sc_indexOf(int);
bool sc_contains(int);
void sc_add_(int, int);
void sc_add(int);
int sc_remove(int);
int sc_get(int);
int sc_set(int, int);
void sc_clear(void);
void sc_print(void);


#endif /* SingleCycleLinkedList_h */
