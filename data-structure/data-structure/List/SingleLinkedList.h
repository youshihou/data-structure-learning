//
//  SingleLinkedList.h
//  data-structure
//
//  Created by Ankui on 7/13/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef SingleLinkedList_h
#define SingleLinkedList_h

#include "common.h"

void sl_create(void);
int sl_size(void);
bool sl_isEmpty(void);
int sl_indexOf(int);
bool sl_contains(int);
void sl_add_(int, int);
void sl_add(int);
int sl_remove(int);
int sl_get(int);
int sl_set(int, int);
void sl_clear(void);
void sl_print(void);

#endif /* SingleLinkedList_h */
