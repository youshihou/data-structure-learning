//
//  binary_search_tree.c
//  data-structure
//
//  Created by Ankui on 7/20/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "binary_search_tree.h"

// MARK: - object_queue
struct node_depth {
    struct bst_node* node;
    int level;
};

struct object_node {
    struct node_depth* value;
    struct object_node* next;
};

struct object_queue {
    struct object_node* head;
    struct object_node* tail;
};

struct object_queue* object_queue_create(void) {
    struct object_queue* q = malloc(sizeof(struct object_queue));
    assert(q);
    q->head = q->tail = NULL;
    return q;
}

bool object_queue_isEmpty(struct object_queue* q) {
    return q->head == NULL;
}

void object_queue_enqueue(struct object_queue* q, void* value) {
    struct object_node* e = malloc(sizeof(struct object_node));
    assert(e);
    e->value = value;
    e->next = NULL;
    if (q->head == NULL) {
        q->head = e;
    } else {
        q->tail->next = e;
    }
    q->tail = e;
}

struct node_depth* object_queue_dequeue(struct object_queue* q) {
    assert(!object_queue_isEmpty(q));
    struct object_node* e = q->head;
    struct node_depth* ret = e->value;
    q->head = e->next;
    free(e);
    return ret;
}

void object_queue_destroy(struct object_queue* q) {
    while (!object_queue_isEmpty(q)) {
        object_queue_dequeue(q);
    }
    free(q);
}

int object_queue_size(struct object_queue* q) {
    int size = 0;
    struct object_node* e = q->head;
    while (e) {
        size++;
        e = e->next;
    }
    return size;
}

struct node_depth* object_queue_front(struct object_queue* q) {
    assert(!object_queue_isEmpty(q));
    return q->head->value;
}




int bst_szie_ = 0;
struct bst_node* root = NULL;

int print_list[100] = {0};

// MARK: - private
static int bst_compare(int v1, int v2) {
    return v1 - v2;
}

#if 0
static void bst_print_helper(struct bst_node* root, int depth) {
    if (root) {
        bst_print_helper(root->left, depth + 1);
        for (int i = 0; i < 2 * depth; i++) {
            putchar(' ');
        }
        printf("%d (%p)\n", root->element, (void*)root);
        bst_print_helper(root->right, depth + 1);
    }
}

static void bst_print_internal(struct bst_node* root, int depth) {
    if (depth > 0) {
        for (int i = 0; i < depth - 1; i++) {
            printf(print_list[i] ? "│   " : "    ");
        }
        printf(print_list[depth - 1] ? "├── " : "└── ");
    }
    if (root == NULL) {
        printf("(NULL)\n");
        return;
    }
    printf("%d\n", root->element);
    if (root->left == NULL && root->right == NULL) { return; }
    
    print_list[depth] = 1;
    bst_print_internal(root->left, depth + 1);
    print_list[depth] = 0;
    bst_print_internal(root->right, depth + 1);
}
#endif

int get_max_depth(struct bst_node* root) {
    if (root == NULL) { return 0; }
    int left_max = get_max_depth(root->left);
    int right_max = get_max_depth(root->right);
    return 1 + fmax(left_max, right_max);
}

void internal_bas_print() {
    int depth = get_max_depth(root);
    int last_level = 0;
    char buffer[1024];
    int offset = (1 << depth) - 1;
        
    struct object_queue* q = object_queue_create();
    struct node_depth* root_nd = malloc(sizeof(struct node_depth));
    root_nd->node = root;
    root_nd->level = last_level;
    object_queue_enqueue(q, root_nd);
    while (object_queue_size(q)) {
        struct node_depth* nd = object_queue_front(q);
        if (last_level != nd->level) {
            printf("\n\n");
            last_level = nd->level;
            offset = (1 << (depth - nd->level)) - 1;
        }
        
        if (nd->node) {
            sprintf(buffer, " %*s%d%*s", offset, " ", nd->node->element, offset, " ");
        } else {
            sprintf(buffer, " %*s", offset << 1, " ");
        }
        printf("%s", buffer);
        
        if (nd->node) {
            struct node_depth* left_nd = malloc(sizeof(struct node_depth));
            left_nd->node = nd->node->left;
            left_nd->level = last_level + 1;
            object_queue_enqueue(q, left_nd);
            struct node_depth* right_nd = malloc(sizeof(struct node_depth));
            right_nd->node = nd->node->right;
            right_nd->level = last_level + 1;
            object_queue_enqueue(q, right_nd);
        }
        object_queue_dequeue(q);
    }
    printf("\n\n\n");
}




// MARK: - public
int bst_size(void) {
    return bst_szie_;
}

bool bst_isEmpty(void) {
    return bst_szie_ == 0;
}

void bst_clear(void) {
    
}

void bst_add(int element) {
    if (root == NULL) { // add the first node
        root = malloc(sizeof(struct bst_node));
        root->element = element;
        root->left = NULL;
        root->right = NULL;
        root->parent = NULL;
        bst_szie_++;
        return;
    }
    
    struct bst_node* parent = root;
    struct bst_node* node = root;
    int cmp = 0;
    while (node) {
        parent = node;
        cmp = bst_compare(element, node->element);
        if (cmp > 0) {
            node = node->right;
        } else if (cmp < 0) {
            node = node->left;
        } else {
            return;
        }
    }
    
    struct bst_node* add = malloc(sizeof(struct bst_node));
    add->element = element;
    add->left = NULL;
    add->right = NULL;
    if (cmp > 0) { // add to parent node right
        parent->right = add;
    } else { // add to parent node left
        parent->left = add;
    }
    bst_szie_++;
}

void bst_remove(int element) {
    
}

bool bst_contains(int element) {
    return false;
}

void bst_print(void) {
//    bst_print_helper(root, 0);
//    bst_print_internal(root, 0);
    internal_bas_print();
}
