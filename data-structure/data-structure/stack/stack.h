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






struct old_stack {
    char* book;
    struct old_stack* next;
};

struct old_stack* old_stack_create(void);
struct old_stack* old_stack_push(struct old_stack*, const char*);
struct old_stack* old_stack_pop(struct old_stack*, char**);
void old_stack_destroy(struct old_stack*);




struct object_stack {
    char* book;
    struct object_stack* next;
};

struct object_stack** object_stack_create(void);
bool object_stack_isEmpty(struct object_stack**);
int object_stack_push(struct object_stack**, const char*);
char* object_stack_pop(struct object_stack**);
void object_stack_destroy(struct object_stack**);


#endif /* stack_h */
