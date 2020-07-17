//
//  main.c
//  data-structure
//
//  Created by Ankui on 6/30/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include <stdio.h>
#include "ArrayList.h"
#include "LinkedList.h"
#include "DoubleLinkedList.h"

int main(int argc, const char * argv[]) {
    {
#if 0
//        _createList();
//        _add(99);
//        _add(88);
//        _add(77);
//        _add(66);
//        _add(10);
//        for (int i = 0; i < 20; i++) {
//            _add(i);
//        }
//        _print();
//        _remove(0);
//        _remove(_size() - 1);
//        _remove(2);
//        __add(0, 100);
//        __add(1, 100);
//        __add(_size(), 100);
//        __add(_size() - 1, 100);
//        _set(3, 80);
//        _print();
//        assert(_get(3) == 80);
//
//        _remove(0);
//        assert(_get(0) == 88);
//        assert(_size() == 4);
        
        _createList();
        for (int i = 0; i < 50; i++) {
            _add(i);
        }
        for (int i = 0; i < 50; i++) {
            _remove(0);
        }
        _print();
#endif
    }
    {
#if 0
        create_();
        add(20);
        add_(0, 10);
        add(30);
        add_(size_(), 40);
        print_();
        remove_(1);
        print_();
#endif
        
    }
    {
#if 1
//        list_create();
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
        printf("---------------------------------------\n");
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

#endif
        
    }
    
    return 0;
}
