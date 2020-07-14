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


int main(int argc, const char * argv[]) {
    {
#if 1
        _createList();
        _add(99);
        _add(88);
        _add(77);
        _add(66);
        _add(55);
        _print();
//        _remove(0);
//        _remove(_size() - 1);
//        _remove(2);
//        __add(0, 100);
//        __add(1, 100);
//        __add(_size(), 100);
//        __add(_size() - 1, 100);
        _set(3, 80);
        _print();
        assert(_get(3) == 80);
        
        _remove(0);
        assert(_get(0) == 88);
        assert(_size() == 4);
        
#endif
    }
    

    return 0;
}
