//
//  main.c
//  data-structure
//
//  Created by Ankui on 6/30/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include <stdio.h>
#include "ArrayList.h"
#include "SingleLinkedList.h"
#include "SingleCycleLinkedList.h"
#include "LinkedList.h"


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

void test_list() {
//    list_create();
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

void test_sc_list() {
    sc_create();
    sc_add(11);
    sc_add(22);
    sc_add(33);
    sc_add(44);

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



int main(int argc, const char * argv[]) {
#if 1
    test_array_list();
#endif

#if 0
    test_single_list();
#endif

#if 0
    test_list();
#endif
      
#if 0
    test_sc_list();
#endif
    
    return 0;
}
