//
//  main.m
//  LinkedList
//
//  Created by Ankui on 8/9/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLinkedList.h"
#import "DLinkedList.h"

void testSLinkedList(List *list) {
    [list add:@20];
    [list add:0 element:@10];
    [list add:@30];
    [list add:[list size] element:@40];
    [list remove:1];
    NSLog(@"%@", list);
    [list clear];
    NSLog(@"%@", list);
}

void testDLinkedList(List *list) {
    [list add:@11];
    [list add:@22];
    [list add:@33];
    [list add:@44];
    [list add:0 element:@55];
    [list add:2 element:@66];
    [list add:list.size element:@77];
    [list remove:0];
    [list remove:2];
    [list remove:list.size - 1];
    
    assert([list indexOf:@44] == 3);
    assert([list indexOf:@22] == ELEMENT_NOT_FOUND);
    assert([list contains:@33]);
    assert([[list get:0] integerValue] == 11);
    assert([[list get:1] integerValue] == 66);
    assert([[list get:list.size - 1] integerValue] == 44);
    NSLog(@"%@", list);
    [list clear];
    NSLog(@"%@", list);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        testSLinkedList([SLinkedList list]);
//        testSLinkedList([VirtualSLinkedList list]);
//        testDLinkedList([DLinkedList list]);
        testDLinkedList([CircleSLinkedList list]);

    }
    return 0;
}
