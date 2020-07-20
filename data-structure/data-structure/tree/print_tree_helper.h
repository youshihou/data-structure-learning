//
//  print_tree.h
//  data-structure
//
//  Created by Ankui on 7/20/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef print_tree_h
#define print_tree_h

#include "common.h"

//struct node_depth {
//    struct bst_node* node;
//    int level;
//};

struct object_node {
//    struct node_depth* value;
    void* value;
    struct object_node* next;
};

struct object_queue {
    struct object_node* head;
    struct object_node* tail;
};

struct object_queue* object_queue_create(void);
bool object_queue_isEmpty(struct object_queue*);
void object_queue_enqueue(struct object_queue*, void*);
void* object_queue_dequeue(struct object_queue*);
void object_queue_destroy(struct object_queue* q);
int object_queue_size(struct object_queue*);
void* object_queue_front(struct object_queue* q);


#endif /* print_tree_h */
