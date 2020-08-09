//
//  main.m
//  LinkedList
//
//  Created by Ankui on 8/9/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinkedList.h"

void testLinkedList(void) {
    LinkedList *list = [LinkedList list];
    [list add:@20];
    [list add:0 element:@10];
    [list add:@30];
    [list add:[list size] element:@40];
    [list remove:1];
    NSLog(@"%@", list);
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        testLinkedList();
        
    }
    return 0;
}
