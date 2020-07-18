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

bool stack_isEmpty(struct Node**);
void stack_push(struct Node**, int);
int stack_pop(struct Node**);
int stack_top(struct Node**);
void stack_destroy(struct Node**);
void stack_print(struct Node**);
int stack_size(struct Node**);



struct stack {
    struct Node* head;
};

struct stack* stack_create(void);
bool stack_isEmpty_(struct stack*);
void stack_push_(struct stack*, int);
int stack_pop_(struct stack*);
int stack_top_(struct stack*);
void stack_destroy_(struct stack*);
void stack_print_(struct stack*);
int stack_size_(struct stack*);


#endif /* stack_h */
