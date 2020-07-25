//
//  main.m
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinaryTreePrintHandler.h"
#import "BinarySearchTree.h"
#import "AVLTree.h"

bool preorder_visit(void* object) {
    NSNumber *n = (__bridge NSNumber *)(object);
    printf("%zd_", n.integerValue);
    if (n.integerValue == 2) {
        printf("\n");
        return true;
    }
    return false;
}
bool inorder_visit(void* object) {
    NSNumber *n = (__bridge NSNumber *)(object);
    printf("%zd_", n.integerValue);
    if (n.integerValue == 3) {
        printf("\n");
        return true;
    }
    return false;
}
bool postorder_visit(void* object) {
    NSNumber *n = (__bridge NSNumber *)(object);
    printf("%zd_", n.integerValue);
    if (n.integerValue == 2) {
        printf("\n");
        return true;
    }
    return false;
}
bool levelorder_visit(void* object) {
    NSNumber *n = (__bridge NSNumber *)(object);
    printf("%zd_", n.integerValue);
    if (n.integerValue == 9) {
        printf("\n");
        return true;
    }
    return false;
}

void testBST() {
    int data[] = {7, 4, 9, 2, 5, 8, 11, 3, 12, 1};
    int len = sizeof(data) / sizeof(int);
    BinarySearchTree *bst = [BinarySearchTree tree];
//    BinarySearchTree *bst = [BinarySearchTree treeWithBlock:^int(id _Nonnull e1, id _Nonnull e2) {
//        return (int)[e1 compare:e2];
//    }];
    for (NSInteger i = 0; i < len; i++) {
        [bst add:@(data[i])];
    }
    [BinaryTreePrintHandler println:bst];
    printf("---------------------------------\n");
    
    printf("height: %zd\n", [bst height]);
    printf("height2: %zd\n", [bst height2]);
    printf("isComplete: %d\n", [bst isComplete]);
    printf("contains: %d\n", [bst contains:@8]);

//    [bst remove:@1];
//    [bst remove:@3];
//    [bst remove:@12];
//    [bst remove:@5];
//    [bst remove:@11];
//    [bst remove:@9];
//    [bst remove:@7];
//    [BinaryTreePrintHandler println:bst];
    printf("---------------------------------\n");
    
    struct Visitor* visitor = malloc(sizeof(struct Visitor));
    visitor->stop = false;
    visitor->visit = preorder_visit;
    [bst preorder:visitor];
    printf("\n");

    visitor->stop = false;
    visitor->visit = inorder_visit;
    [bst inorder:visitor];
    printf("\n");

    visitor->stop = false;
    visitor->visit = postorder_visit;
    [bst postorder:visitor];
    printf("\n");
    
    visitor->stop = false;
    visitor->visit = levelorder_visit;
    [bst levelOrder:visitor];
    printf("---------------------------------\n");
    free(visitor);
}

void testAVLTree() {
//    int data[] = {85, 19, 69, 3, 7, 99, 95, 2, 1, 70, 44, 58, 11, 21, 14, 93, 57, 4, 56};
//    int data[] = {85, 19, 69, 3, 7, 99, 95};
    int data[] = {67, 52, 92, 96, 53, 95, 13, 63, 34, 82, 76, 54, 9, 68, 39};
    int len = sizeof(data) / sizeof(int);
    AVLTree *avl = [AVLTree tree];
    for (NSInteger i = 0; i < len; i++) {
//        printf("add: [%d]\n", data[i]);
        [avl add:@(data[i])];
//        [BinaryTreePrintHandler println:avl];
//        printf("\n---------------------------------------------------------\n");
    }
//    [BinaryTreePrintHandler println:avl];

//    [avl remove:@99];
//    [avl remove:@85];
//    [avl remove:@95];
//    [BinaryTreePrintHandler println:avl];
    
    for (NSInteger i = 0; i < len; i++) {
        printf("remove: [%d]\n", data[i]);
        [avl remove:@(data[i])];
        [BinaryTreePrintHandler println:avl];
        printf("\n---------------------------------------------------------\n");
    }
    printf("\n\n\n");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        testBST();
        testAVLTree();
    }
    return 0;
}
