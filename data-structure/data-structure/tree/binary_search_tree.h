//
//  binary_search_tree.h
//  data-structure
//
//  Created by Ankui on 7/20/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef binary_search_tree_h
#define binary_search_tree_h

#include "common.h"

struct bst_node {
    int element;
    struct bst_node* left;
    struct bst_node* right;
    struct bst_node* parent;
};

int bst_size(void);
bool bst_isEmpty(void);
void bst_clear(void);
void bst_add(int element);
void bst_remove(int element);
bool bst_contains(int element);
void bst_print(void);


#endif /* binary_search_tree_h */
