//
//  stack.h
//  data-structure
//
//  Created by Ankui on 7/18/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef stack_h
#define stack_h

#include "common.h"

int stack_size(struct Node**);
bool stack_isEmpty(struct Node**);
void stack_push(struct Node**, int);
int stack_pop(struct Node**);
int stack_top(struct Node**);
void stack_print(struct Node**);

#endif /* stack_h */
