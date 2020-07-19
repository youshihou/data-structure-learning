//
//  common.h
//  data-structure
//
//  Created by Ankui on 7/1/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef common_h
#define common_h

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>
#include <stdint.h>
#include <limits.h>
#include <time.h>


static int DEFAULT_CAPACITY = 10;
static int ELEMENT_NOT_FOUND = -1;

struct Node {
    int element;
    struct Node* next;
};

struct ListNode {
    int element;
    struct ListNode* prev;
    struct ListNode* next;
};


#endif /* common_h */
