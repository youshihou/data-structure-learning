//
//  main.c
//  data-structure
//
//  Created by Ankui on 6/30/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "ArrayList.h"
#include "SingleLinkedList.h"
#include "LinkedList.h"
#include "SingleCycleLinkedList.h"
#include "CycleLinkedList.h"
#include "stack.h"


void test_array_list() {
    al_createList_();
    al_add(99);
    al_add(88);
    al_add(77);
    al_add(66);
    al_add(10);
    for (int i = 0; i < 20; i++) {
        al_add(i);
    }
    al_print();
    al_remove(0);
    al_remove(al_size() - 1);
    al_remove(2);
    al_add_(0, 100);
    al_add_(1, 100);
    al_add_(al_size(), 100);
    al_add_(al_size() - 1, 100);
    al_set(3, 80);
    al_print();
    assert(al_get(3) == 80);

    al_remove(0);
    assert(al_get(0) == 100);
    assert(al_size() == 25);
    al_print();

//    al_createList_();
//    for (int i = 0; i < 50; i++) {
//        al_add(i);
//    }
//    for (int i = 0; i < 50; i++) {
//        al_remove(0);
//    }
//    al_print();
}

void test_single_list() {
    sl_create();
    sl_add(20);
    sl_add_(0, 10);
    sl_add(30);
    sl_add_(sl_size(), 40);
    sl_print();
    sl_remove(1);
    sl_print();
}

void test_single_cycle_list() {
    sc_create();
    sc_add(11);
    sc_add(22);
    sc_add(33);
    sc_add(44);
    sc_print();

    sc_add_(0, 55);
    sc_print();
    sc_add_(2, 66);
    sc_print();
    sc_add_(sc_size(), 77);
    sc_print();
    
    sc_remove(0);
    sc_print();
    sc_remove(2);
    sc_print();
    sc_remove(sc_size() - 1);
    sc_print();

    assert(sc_indexOf(44) == 3);
    assert(sc_indexOf(22) == -1);
    assert(sc_contains(33));
    assert(sc_get(0) == 11);
    assert(sc_get(1) == 66);
    assert(sc_get(sc_size() - 1) == 44);
}

void test_list() {
    list_add(11);
    list_add(22);
    list_add(33);
    list_add(44);
    
    list_add_(0, 55);
    list_print();
    list_add_(2, 66);
    list_print();
    list_add_(list_size(), 77);
    list_print();
    list_remove(0);
    list_print();
    list_remove(2);
    list_print();
    list_remove(list_size() - 1);
    list_print();
    
    assert(list_indexOf(44) == 3);
    assert(list_indexOf(22) == -1);
    assert(list_contains(33));
    assert(list_get(0) == 11);
    assert(list_get(1) == 66);
    assert(list_get(list_size() - 1) == 44);
}

void test_cycle_list() {
    cl_add(11);
    cl_add(22);
    cl_add(33);
    cl_add(44);
    cl_print();

    cl_add_(0, 55);
    cl_print();
    cl_add_(2, 66);
    cl_print();
    cl_add_(cl_size(), 77);
    cl_print();
    
    cl_remove(0);
    cl_print();
    cl_remove(2);
    cl_print();
    cl_remove(cl_size() - 1);
    cl_print();

    assert(cl_indexOf(44) == 3);
    assert(cl_indexOf(22) == -1);
    assert(cl_contains(33));
    assert(cl_get(0) == 11);
    assert(cl_get(1) == 66);
    assert(cl_get(cl_size() - 1) == 44);
}

void test_josephus() {
    for (int i = 1; i <= 8; i++) {
        cl_add(i);
    }
    
    cl_reset();
    while (!cl_isEmpty()) {
        cl_next();
        cl_next();
        int element = cl_remove_();
        printf("%d\n", element);
    }
}

void test_stack() {
    struct Node* s = NULL;
    
    for (int i = 0; i < 5; i++) {
        printf("push %d\n", i);
        stack_push(&s, i);
        stack_print(&s);
    }
        
    while (!stack_isEmpty(&s)) {
        printf("top gets %d, pop gets %d\n", stack_top(&s), stack_pop(&s));
        stack_print(&s);
    }
}



int main(int argc, const char * argv[]) {
#if 0
    test_array_list();
#endif

#if 0
    test_single_list();
#endif
      
#if 0
    test_single_cycle_list();
#endif

#if 0
    test_list();
#endif

#if 0
    test_cycle_list();
    test_josephus();
#endif

#if 1
    test_stack();
#endif
    
    return 0;
}
