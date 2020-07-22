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

void bst_preorder_traversal(void);
void bst_inorder_traversal(void);
void bst_postorder_traversal(void);
void bst_levelorder_traversal(void);



void levelorder_traversal(bool(*)(void*));
//void postorder_traversal(bool(*)(void*));
//void inorder_traversal(bool(*)(void*));
//void preorder_traversal(bool(*)(void*));

struct visitor {
    bool stop;
    bool (*visit)(void*);
};

void postorder_traversal(struct visitor*);
void inorder_traversal(struct visitor*);
void preorder_traversal(struct visitor*);


int bst_tree_height(void);
int tree_height(void);

bool tree_isComplete(void);
bool isComplete(void);

struct bst_node* predecessor(struct bst_node*);
struct bst_node* successor(struct bst_node*);


#endif /* binary_search_tree_h */
