//
//  main.m
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinaryTree.h"
#import "BinarySearchTree.h"

void test1() {
    int data[] = { 38, 18, 4, 69, 85, 71, 34, 36, 29, 100 };
    int len = sizeof(data) / sizeof(int);
    
    BinarySearchTree *bst = [BinarySearchTree tree];
    for (int i = 0; i < len; i++) {
        [bst add:@(data[i])];
    }
    
    [BinaryTree println:bst];
    printf("---------------------------------\n");
    [BinaryTree println:bst style:BinaryTreePrintStyleInorder];
    printf("---------------------------------\n");
}

void test2() {
    int data[] = { 38, 18, 4, 69, 85, 71, 34, 36, 29, 100 };
    int len = sizeof(data) / sizeof(int);
    
    BinarySearchTree *bst = [BinarySearchTree treeWithBlock:^int(id e1, id e2) {
        return (int)[e2 compare:e1];
    }];
    for (int i = 0; i < len; i++) {
        [bst add:@(data[i])];
    }
    
    [BinaryTree println:bst];
    printf("---------------------------------\n");
    [BinaryTree println:bst style:BinaryTreePrintStyleInorder];
    printf("---------------------------------\n");
}

void test3() {
    BinarySearchTree *bst = [BinarySearchTree tree];
    for (int i = 0; i < 20; i++) {
        [bst add:@((arc4random() % 666) + 1)];
    }
    
    [BinaryTree println:bst];
    printf("---------------------------------\n");
    [BinaryTree println:bst style:BinaryTreePrintStyleInorder];
    printf("---------------------------------\n");
//    NSString *str = [BinaryTree printString:bst];
//    NSString *file = @"/Users/Ankui/Desktop/test.txt";
//    [str writeToFile:file atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

void test4() {
    int data[] = {7, 4, 9, 2, 5, 8, 11, 3, 12, 1};
    int len = sizeof(data) / sizeof(int);
    BinarySearchTree *bst = [BinarySearchTree tree];
    for (int i = 0; i < len; i++) {
        [bst add:@(data[i])];
    }
    
    [BinaryTree println:bst];
    printf("---------------------------------\n");
//    [BinaryTree println:bst style:BinaryTreePrintStyleInorder];
//    printf("---------------------------------\n");
    [bst remove:@7];
    [BinaryTree println:bst];
    printf("---------------------------------\n");
    printf("%d\n\n", [bst contains:@8]);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        test1();
//        test2();
//        test3();
        test4();
    }
    return 0;
}
