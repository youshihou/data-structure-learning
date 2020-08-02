//
//  binary_heap.h
//  data-structure
//
//  Created by Ankui on 8/2/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef binary_heap_h
#define binary_heap_h

#include "common.h"

void create_heap(void);
int heap_size(void);
bool heap_isEmpty(void);
void heap_clear(void);
void heap_add(int);
int heap_get(void);
int heap_remove(void);
int heap_replace(int);

#endif /* binary_heap_h */
