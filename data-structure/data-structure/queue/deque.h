//
//  deque.h
//  data-structure
//
//  Created by Ankui on 7/19/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef deque_h
#define deque_h

#include "common.h"

typedef struct deque Deque;

#define DEQUE_FRONT (0)
#define DEQUE_BACK (1)

#define DEQUE_EMPTY (-1)


Deque* deque_create(void);
void deque_push(Deque*, int, int);
int deque_pop(Deque*, int);
int deque_isEmpty(Deque*);
void deque_destroy(Deque*);


#endif /* deque_h */
