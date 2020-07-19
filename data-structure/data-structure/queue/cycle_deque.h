//
//  cycle_deque.h
//  data-structure
//
//  Created by Ankui on 7/19/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef cycle_deque_h
#define cycle_deque_h

#include "common.h"

void cycle_deque_create(void);
int cycle_deque_size(void);
bool cycle_deque_isEmpty(void);
void cycle_deque_enqueue_back(int);
int cycle_deque_dequeue_back(void);
void cycle_deque_enqueue_front(int);
int cycle_deque_dequeue_front(void);
int cycle_deque_front(void);
int cycle_deque_back(void);
void cycle_deque_print(void);

#endif /* cycle_deque_h */
