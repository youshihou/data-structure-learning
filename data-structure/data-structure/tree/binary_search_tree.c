//
//  binary_search_tree.c
//  data-structure
//
//  Created by Ankui on 7/20/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "binary_search_tree.h"
#include "print_tree_helper.h"


int bst_szie_ = 0;
struct bst_node* root = NULL;

int print_list[100] = {0};

// MARK: - private
static int bst_compare(int v1, int v2) {
    return v1 - v2;
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
            node->element = element; // CARE custom object
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

void bst_print(void) {
//    bst_print_helper(root, 0);
//    bst_print_internal(root, 0);

    int depth = get_max_depth(root);
    int last_level = 0;
    char buffer[1024];
    int offset = (1 << depth) - 1;
    struct node_depth {
        struct bst_node* node;
        int level;
    };
        
    struct object_queue* q = object_queue_create();
    struct node_depth* root_nd = malloc(sizeof(struct node_depth));
    root_nd->node = root;
    root_nd->level = last_level;
    object_queue_enqueue(q, root_nd);
    printf("\n");
    while (object_queue_size(q)) {
        struct node_depth* nd = (struct node_depth *)object_queue_front(q);
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
    printf("\n\n");
    object_queue_destroy(q);
}


void internal_preorder_traversal(struct bst_node* root) {
    if (root == NULL) { return; }
    
    printf("%d->", root->element);
    internal_preorder_traversal(root->left);
    internal_preorder_traversal(root->right);
}

void bst_preorder_traversal(void) {
    printf("preorder: ");
    internal_preorder_traversal(root);
    printf("\n\n");
}

void internal_inorder_traversal(struct bst_node* root) {
    if (root == NULL) { return; }
    
    internal_inorder_traversal(root->left);
    printf("%d->", root->element);
    internal_inorder_traversal(root->right);
}

void bst_inorder_traversal(void) {
    printf("inorder: ");
    internal_inorder_traversal(root);
    printf("\n\n");
}

void internal_postorder_traversal(struct bst_node* root) {
    if (root == NULL) { return; }
    internal_postorder_traversal(root->left);
    internal_postorder_traversal(root->right);
    printf("%d->", root->element);
}

void bst_postorder_traversal(void) {
    printf("postorder: ");
    internal_postorder_traversal(root);
    printf("\n\n");
}

void bst_levelorder_traversal(void) {
    if (root == NULL) { return; }
    
    printf("levelorder: ");
    struct object_queue* q = object_queue_create();
    object_queue_enqueue(q, root);
    while (!object_queue_isEmpty(q)) {
        struct bst_node* node = object_queue_dequeue(q);
        printf("%d->", node->element);
        if (node->left) {
            object_queue_enqueue(q, node->left);
        }
        if (node->right) {
            object_queue_enqueue(q, node->right);
        }
    }
    object_queue_destroy(q);
    printf("\n\n");
}





void levelorder_traversal(bool(*visitor)(void*)) {
    if (root == NULL || visitor == NULL) { return; }
    
    printf("levelorder: ");
    struct object_queue* q = object_queue_create();
    object_queue_enqueue(q, root);
    while (!object_queue_isEmpty(q)) {
        struct bst_node* node = object_queue_dequeue(q);
        if (visitor(node)) {
            object_queue_destroy(q);
            printf("\n\n");
            return;
        }
        if (node->left) {
            object_queue_enqueue(q, node->left);
        }
        if (node->right) {
            object_queue_enqueue(q, node->right);
        }
    }
    object_queue_destroy(q);
    printf("\n\n");
}

void postorder_internal(struct bst_node* node, struct visitor* visitor) {
    if (node == NULL || visitor->stop) { return; }
    
    postorder_internal(node->left, visitor);
    postorder_internal(node->right, visitor);
    
    if (visitor->stop) { return; }
    visitor->stop = visitor->visit(node);
}

void postorder_traversal(struct visitor* visitor) {
    if (visitor == NULL) { return; }
    
    printf("postorder: ");
    postorder_internal(root, visitor);
    printf("\n\n");
}

void inorder_internal(struct bst_node* node, struct visitor* visitor) {
    if (node == NULL || visitor->stop) { return; }

    inorder_internal(node->left, visitor);
    if (visitor->stop) { return; }
    visitor->stop = visitor->visit(node);
    inorder_internal(node->right, visitor);
}

void inorder_traversal(struct visitor* visitor) {
    if (visitor == NULL) { return; }

    printf("inorder: ");
    inorder_internal(root, visitor);
    printf("\n\n");
}

void preorder_internal(struct bst_node* node, struct visitor* visitor) {
    if (node == NULL || visitor->stop) { return; }

//    if (visitor->stop) { return; }
    visitor->stop = visitor->visit(node);
    preorder_internal(node->left, visitor);
    preorder_internal(node->right, visitor);
}

void preorder_traversal(struct visitor* visitor) {
    if (visitor == NULL) { return; }

    printf("preorder: ");
    preorder_internal(root, visitor);
    printf("\n\n");
}




int internal_tree_height(struct bst_node* node) {
    if (node == NULL) { return 0; }
    
    return 1 + fmax(internal_tree_height(node->left), internal_tree_height(node->right));
}

int bst_tree_height(void) {
    return internal_tree_height(root);
}

int tree_height(void) {
    if (root == NULL) { return 0; }
    
    int height = 0;
    int level_size = 1;
    struct object_queue* q = object_queue_create();
    object_queue_enqueue(q, root);
    while (!object_queue_isEmpty(q)) {
        struct bst_node* node = object_queue_dequeue(q);
        level_size--;
        if (node->left) {
            object_queue_enqueue(q, node->left);
        }
        if (node->right) {
            object_queue_enqueue(q, node->right);
        }
        
        if (level_size == 0) {
            level_size = object_queue_size(q);
            height++;
        }
    }
    object_queue_destroy(q);
    
    return height;
}


bool tree_isComplete(void) {
    if (root == NULL) { return false; }
    
    bool leaf = false;
    struct object_queue* q = object_queue_create();
    object_queue_enqueue(q, root);
    while (!object_queue_isEmpty(q)) {
        struct bst_node* node = object_queue_dequeue(q);
        bool is_leaf = node->left == NULL && node->right == NULL;
        bool has_twoChild = node->left && node->right;
        if (leaf && !is_leaf) { return false; }
        
        if (has_twoChild) {
            object_queue_enqueue(q, node->left);
            object_queue_enqueue(q, node->right);
        } else if (node->left == NULL && node->right) {
            return false;
        } else {
            // (node->left != NULL && node->right == NULL) || (node->left == NULL && node->right == NULL)
            leaf = true;
            
            if (node->left) { // CARE!!! MUST
                object_queue_enqueue(q, node->left);
            }
        }
    }
    object_queue_destroy(q);
    
    return true;
}

bool isComplete(void) {
    if (root == NULL) { return false; }
    
    bool leaf = false;
    struct object_queue* q = object_queue_create();
    object_queue_enqueue(q, root);
    while (!object_queue_isEmpty(q)) {
        struct bst_node* node = object_queue_dequeue(q);
        bool is_leaf = node->left == NULL && node->right == NULL;
        if (leaf && !is_leaf) { return false; }
        
        if (node->left) {
            object_queue_enqueue(q, node->left);
        } else if (node->right) {
            // node->left == NULL && node->right != NULL
            return false;
        }
        
        if (node->right) {
            object_queue_enqueue(q, node->right);
        } else { // node->right = NULL
            // (node->left != NULL && node->right == NULL) || (node->left == NULL && node->right == NULL)
            leaf = true;
        }
    }
    object_queue_destroy(q);
    
    return true;
}
