//
//  cycle_queue.h
//  data-structure
//
//  Created by Ankui on 7/19/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef cycle_queue_h
#define cycle_queue_h

#include "common.h"

void cycle_queue_create(void);
int cycle_queue_size(void);
bool cycle_queue_isEmpty(void);
void cycle_queue_enqueue(int);
int cycle_queue_dequeue(void);
int cycle_queue_front(void);
void cycle_queue_print(void);

#endif /* cycle_queue */
