//
//  main.m
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinaryTreePrintHandler.h"
#import "BST.h"
#import "AVLTree.h"
#import "RBTree.h"
#import "TreeSet.h"
#import "TreeMap.h"
#import "TreeMapSet.h"
#import "HashMap.h"

bool preorder_visit(void* object) {
    NSNumber *n = (__bridge NSNumber *)(object);
    printf("%zd_", n.integerValue);
    if (n.integerValue == 2) {
        printf("\n");
        return true;
    }
    return false;
}
bool inorder_visit(void* object) {
    NSNumber *n = (__bridge NSNumber *)(object);
    printf("%zd_", n.integerValue);
    if (n.integerValue == 3) {
        printf("\n");
        return true;
    }
    return false;
}
bool postorder_visit(void* object) {
    NSNumber *n = (__bridge NSNumber *)(object);
    printf("%zd_", n.integerValue);
    if (n.integerValue == 2) {
        printf("\n");
        return true;
    }
    return false;
}
bool levelorder_visit(void* object) {
    NSNumber *n = (__bridge NSNumber *)(object);
    printf("%zd_", n.integerValue);
    if (n.integerValue == 9) {
        printf("\n");
        return true;
    }
    return false;
}

void testBST(void) {
    int data[] = {7, 4, 9, 2, 5, 8, 11, 3, 12, 1};
    int len = sizeof(data) / sizeof(int);
    BST *bst = [BST tree];
//    BST *bst = [BST treeWithBlock:^int(id _Nonnull e1, id _Nonnull e2) {
//        return (int)[e1 compare:e2];
//    }];
    for (int i = 0; i < len; i++) {
        [bst add:@(data[i])];
    }
    [BinaryTreePrintHandler println:bst];
    printf("---------------------------------\n");
    
    printf("height: %zd\n", [bst height]);
    printf("height2: %zd\n", [bst height2]);
    printf("isComplete: %d\n", [bst isComplete]);
    printf("contains: %d\n", [bst contains:@8]);

//    [bst remove:@1];
//    [bst remove:@3];
//    [bst remove:@12];
//    [bst remove:@5];
//    [bst remove:@11];
//    [bst remove:@9];
//    [bst remove:@7];
//    [BinaryTreePrintHandler println:bst];
    printf("---------------------------------\n");
    
    struct Visitor* visitor = malloc(sizeof(struct Visitor));
    visitor->stop = false;
    visitor->visit = preorder_visit;
    [bst preorder:visitor];
    printf("\n");

    visitor->stop = false;
    visitor->visit = inorder_visit;
    [bst inorder:visitor];
    printf("\n");

    visitor->stop = false;
    visitor->visit = postorder_visit;
    [bst postorder:visitor];
    printf("\n");
    
    visitor->stop = false;
    visitor->visit = levelorder_visit;
    [bst levelOrder:visitor];
    printf("---------------------------------\n");
    free(visitor);
}

void testAVLTree(void) {
//    int data[] = {85, 19, 69, 3, 7, 99, 95, 2, 1, 70, 44, 58, 11, 21, 14, 93, 57, 4, 56};
//    int data[] = {85, 19, 69, 3, 7, 99, 95};
    int data[] = {67, 52, 92, 96, 53, 95, 13, 63, 34, 82, 76, 54, 9, 68, 39};
    int len = sizeof(data) / sizeof(int);
    AVLTree *avl = [AVLTree tree];
    for (int i = 0; i < len; i++) {
//        printf("add: [%d]\n", data[i]);
        [avl add:@(data[i])];
//        [BinaryTreePrintHandler println:avl];
//        printf("\n---------------------------------------------------------\n");
    }
//    [BinaryTreePrintHandler println:avl];

//    [avl remove:@99];
//    [avl remove:@85];
//    [avl remove:@95];
//    [BinaryTreePrintHandler println:avl];
    
    for (int i = 0; i < len; i++) {
        printf("remove: [%d]\n", data[i]);
        [avl remove:@(data[i])];
        [BinaryTreePrintHandler println:avl];
        printf("\n---------------------------------------------------------\n");
    }
    printf("\n\n\n");
}

void testRBTree(void) {
    int data[] = {55, 87, 56, 74, 96, 22, 62, 20, 70, 68, 90, 50};
    int len = sizeof(data) / sizeof(int);
    RBTree *rb = [RBTree tree];
    for (int i = 0; i < len; i++) {
        printf("add: [%d]\n", data[i]);
        [rb add:@(data[i])];
        [BinaryTreePrintHandler println:rb];
        printf("---------------------------\n");
    }
//    [BinaryTreePrintHandler println:rb];
//    printf("\n---------------------------\n");
    
    for (int i = 0; i < len; i++) {
        printf("remove: [%d]\n", data[i]);
        [rb remove:@(data[i])];
        [BinaryTreePrintHandler println:rb];
        printf("\n---------------------------------------------------------\n");
    }
}

void testTreeSet(void) {
    TreeSet *set = [TreeSet set];
    [set add:@12];
    [set add:@10];
    [set add:@11];
    [set add:@9];
    [set add:@10];
    [set add:@11];
    [set add:@12];
    [set add:@7];
    [set add:@10];

    struct Visitor* visitor = malloc(sizeof(struct Visitor));
    visitor->stop = false;
    visitor->visit = inorder_visit;
    [set traversal:visitor];
    free(visitor);
    printf("\n");
}

bool tree_map_visit(void* k, void* v) {
    NSString *key = (__bridge NSString *)(k);
    NSNumber *value = (__bridge NSNumber *)(v);
    printf("%s_%s\n", key.UTF8String, value.stringValue.UTF8String);
    if ([key isEqualToString:@"stop"]) {
        printf("\n");
        return true;
    }
    return false;
}

void testTreeMap(void) {
    TreeMap *map = [TreeMap map];
    [map put:@"c" value:@2];
    [map put:@"a" value:@5];
    [map put:@"b" value:@6];
    [map put:@"a" value:@8];

    struct MapVisitor* visitor = malloc(sizeof(struct MapVisitor));
    visitor->stop = false;
    visitor->visit = tree_map_visit;
    [map traversal:visitor];
    free(visitor);
    printf("\n");
}

void testTreeMapSet(void) {
    TreeMapSet *set = [TreeMapSet set];
    [set add:@"c"];
    [set add:@"a"];
    [set add:@"b"];
    [set add:@"a"];
    [set add:@"b"];
    [set add:@"c"];

    struct MapVisitor* visitor = malloc(sizeof(struct MapVisitor));
    visitor->stop = false;
    visitor->visit = tree_map_visit;
    [set traversal:visitor];
    free(visitor);
    printf("\n");
}


@interface Person : NSObject {
    @public
    NSNumber *_age;
    NSNumber *_height;
    NSString *_name;
}
@end
@implementation Person
- (NSUInteger)hash {
    NSUInteger hashCode = [_age hash];
    hashCode = hashCode * 31 + [_height hash];
    hashCode = hashCode * 31 + (_name.length ? [_name hash] : 0);
    return hashCode;
}
- (BOOL)isEqual:(id)object {
    if (self == object) { return YES; }
    if (self.class != [object class]) { return NO; }
    
    Person *o = (Person *)object;
    if (![_age isEqualToNumber:o->_age]) {
        return NO;
    }
    if (![_height isEqualToNumber:o->_height]) {
        return NO;
    }
    if (![_name isEqualToString:o->_name]) {
        return NO;
    }
    return YES;
}
@end

@interface TestKey : NSObject {
    @public
    NSNumber *_value;
}
@end
@implementation TestKey
- (instancetype)initWithValue:(NSNumber *)value {
    if (self = [super init]) {
        _value = value;
    }
    return self;
}
- (NSUInteger)hash {
    return _value.integerValue / 20;
}
- (BOOL)isEqual:(id)object {
    if (self == object) { return YES; }
    if (self.class != [object class]) { return NO; }
    TestKey *o = (TestKey *)object;
    return [_value isEqualToNumber:o->_value];
}
- (NSString *)description {
    return [NSString stringWithFormat:@"v(%@)", _value];
}
@end


bool hash_map_visit(void* k, void* v) {
    id key = (__bridge id)(k);
    id value = (__bridge id)(v);
    NSLog(@"%@ - %@", key, value);
    return false;
}

void testHashMap(void) {
    Person *p1 = [[Person alloc] init];
    p1->_age = @10;
    p1->_height = @(1.67f);
    p1->_name = @"jack";
    
    Person *p2 = [[Person alloc] init];
    p2->_age = @10;
    p2->_height = @(1.67f);
    p2->_name = @"jack";

    HashMap *map = [HashMap map];
    [map put:p1 value:@1];
    [map put:p2 value:@2];
    [map put:@"jack" value:@3];
    [map put:@"rose" value:@4];
    [map put:@"jack" value:@5];
    [map put:nil value:@6];
    printf("%zd\n", [map size]);
//    printf("jack: %zd\n", [[map get:@"jack"] integerValue]);
//    printf("rose: %zd\n", [[map get:@"rose"] integerValue]);
//    printf("nil: %zd\n", [[map get:nil] integerValue]);
//    printf("p1: %zd\n", [[map get:p1] integerValue]);
    
//    printf("%zd\n", [[map remove:@"jack"] integerValue]);
//    printf("%zd\n", [map size]);
//    NSLog(@"jack: %@", [map get:@"jack"]);
    
    printf("%d\n", [map containsKey:p1]);
    printf("%d\n", [map containsKey:nil]);
    printf("%d\n", [map containsValue:@6]);
    printf("%d\n", [map containsValue:@1]);

    
    struct HashMapVisitor* v = malloc(sizeof(struct HashMapVisitor));
    v->stop = false;
    v->visit = hash_map_visit;
    [map traversal:v];
    free(v);
    printf("\n");
}

void testHashMap2(void) {
    HashMap *map = [HashMap map];
    for (NSUInteger i = 0; i < 19; i++) {
        NSNumber *value = @(i);
        TestKey *key = [[TestKey alloc] initWithValue:value];
        [map put:key value:value];
    }
    TestKey *key = [[TestKey alloc] initWithValue:@4];
    [map put:key value:@100];
//    NSLog(@"%zd", [map size]);
//    NSLog(@"%@", [map get:key]);
//    [map print];
    assert([map size] == 19);
    assert([[map get:key] integerValue] == 100);
    key = [[TestKey alloc] initWithValue:@18];
    assert([[map get:key] integerValue] == 18);
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        testBST();
//        testAVLTree();
//        testRBTree();
//        testTreeSet();
//        testTreeMap();
//        testTreeMapSet();
//        testHashMap();
        testHashMap2();
    }
    return 0;
}
