//
//  ArrayList.h
//  data-structure
//
//  Created by Ankui on 7/13/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#ifndef ArrayList_h
#define ArrayList_h

#include "common.h"

void al_createList(int);
void al_createList_(void);
int al_size(void);
bool al_isEmpty(void);
int al_indexOf(int);
bool al_contains(int);
void al_add_(int, int);
void al_add(int);
int al_remove(int);
int al_get(int);
int al_set(int, int);
void al_clear(void);
void al_print(void);

#endif /* ArrayList_h */
