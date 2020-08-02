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
#import "LinkedHashMap.h"

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
    @protected
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
    return _value.integerValue / 10;
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
@interface SubKey1 : TestKey
@end
@interface SubKey2 : TestKey
@end
@implementation SubKey2
- (BOOL)isEqual:(id)object {
    if (self == object) { return YES; }
    if ([object class] != SubKey1.class && [object class] != SubKey2.class) {
        return NO;
    }
    TestKey *o = (TestKey *)object;
    return [_value isEqualToNumber:o->_value];
}
@end
@implementation SubKey1
- (BOOL)isEqual:(id)object {
    if (self == object) { return YES; }
    if ([object class] != SubKey1.class && [object class] != SubKey2.class) {
        return NO;
    }
    TestKey *o = (TestKey *)object;
    return [_value isEqualToNumber:o->_value];
}
@end


bool hash_map_visit(void* k, void* v) {
    id key = (__bridge id)(k);
    id value = (__bridge id)(v);
    NSLog(@"%@ - %@", key, value);
    return false;
}

void testHashMap(HashMap *map) {
    Person *p1 = [[Person alloc] init];
    p1->_age = @10;
    p1->_height = @(1.67f);
    p1->_name = @"jack";
    
    Person *p2 = [[Person alloc] init];
    p2->_age = @10;
    p2->_height = @(1.67f);
    p2->_name = @"jack";

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
}

void testHashMap2(HashMap *map) {
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

void testHashMap3(HashMap *map) {
//    SubKey1 *k1 = [[SubKey1 alloc] initWithValue:@1];
//    [map put:k1 value:@1];
//    SubKey2 *k2 = [[SubKey2 alloc] initWithValue:@1];
//    [map put:k2 value:@2];
//    printf("%zd\n", [map size]);
    for (int i = 1; i <= 20; i++) {
        NSNumber *v = @(i);
        TestKey *k = [[TestKey alloc] initWithValue:v];
        [map put:k value:v];
    }
    for (int i = 5; i <= 7; i++) {
        TestKey *k = [[TestKey alloc] initWithValue:@(i)];
        [map put:k value:@(i + 5)];
    }
    assert([map size] == 20);
    TestKey *k = [[TestKey alloc] initWithValue:@4];
    assert([[map get:k] integerValue] == 4);
    k = [[TestKey alloc] initWithValue:@5];
    assert([[map get:k] integerValue] == 10);
    k = [[TestKey alloc] initWithValue:@6];
    assert([[map get:k] integerValue] == 11);
    k = [[TestKey alloc] initWithValue:@7];
    assert([[map get:k] integerValue] == 12);
    k = [[TestKey alloc] initWithValue:@8];
    assert([[map get:k] integerValue] == 8);
}

void testHashMap4(HashMap *map) {
    [map put:nil value:@1];
    [map put:[[NSObject alloc] init] value:@2];
    [map put:@"jack" value:@3];
    [map put:@10 value:@4];
    [map put:[[NSObject alloc] init] value:@5];
    [map put:@"jack" value:@6];
    [map put:@10 value:@7];
    [map put:nil value:@8];
    [map put:@10 value:nil];
    assert([map size] == 5);
    assert([[map get:nil] integerValue] == 8);
    assert([[map get:@"jack"] integerValue] == 6);
    assert([map get:@10] == nil);
    assert([map get:[[NSObject alloc] init]] == nil);
    assert([map containsKey:@10]);
    assert([map containsKey:nil]);
    assert([map containsValue:nil]);
    assert([map containsValue:@1] == false);
}

void testHashMap5(HashMap *map) {
    [map put:@"jack" value:@1];
    [map put:@"rose" value:@2];
    [map put:@"jim" value:@3];
    [map put:@"jake" value:@4];
    for (int i = 1; i <= 10; i++) {
        NSNumber *v = @(i);
        NSString *s = [NSString stringWithFormat:@"test%d", i];
        [map put:s value:v];
        TestKey *k = [[TestKey alloc] initWithValue:v];
        [map put:k value:v];
    }
    for (int i = 5; i <= 7; i++) {
        TestKey *k = [[TestKey alloc] initWithValue:@(i)];
        assert([[map remove:k] integerValue] == i);
    }
    for (int i = 1; i <= 3; i++) {
        TestKey *k = [[TestKey alloc] initWithValue:@(i)];
        [map put:k value:@(i + 5)];
    }
    assert([map size] == 21);
    TestKey *k = [[TestKey alloc] initWithValue:@1];
    assert([[map get:k] integerValue] == 6);
    k = [[TestKey alloc] initWithValue:@2];
    assert([[map get:k] integerValue] == 7);
    k = [[TestKey alloc] initWithValue:@3];
    assert([[map get:k] integerValue] == 8);
    k = [[TestKey alloc] initWithValue:@4];
    assert([[map get:k] integerValue] == 4);
    k = [[TestKey alloc] initWithValue:@5];
    assert([map get:k] == nil);
    k = [[TestKey alloc] initWithValue:@6];
    assert([map get:k] == nil);
    k = [[TestKey alloc] initWithValue:@7];
    assert([map get:k] == nil);
    k = [[TestKey alloc] initWithValue:@8];
    assert([[map get:k] integerValue] == 8);
    
    struct HashMapVisitor* v = malloc(sizeof(struct HashMapVisitor));
    v->stop = false;
    v->visit = hash_map_visit;
    [map traversal:v];
    free(v);
}

void testHashMap6(HashMap *map) {
    for (int i = 1; i <= 20; i++) {
        NSNumber *v = @(i);
        SubKey1 *k = [[SubKey1 alloc] initWithValue:v];
        [map put:k value:v];
    }
    SubKey2 *k2 = [[SubKey2 alloc] initWithValue:@1];
    [map put:k2 value:@5];
    SubKey1 *k1 = [[SubKey1 alloc] initWithValue:@1];
    assert([[map get:k1] integerValue] == 5);
    k2 = [[SubKey2 alloc] initWithValue:@1];
    assert([[map get:k2] integerValue] == 5);
    assert([map size] == 20);
    [map print];
}

void testLinkedHashMap(LinkedHashMap *map) {
    [map put:@"jack" value:@1];
    [map put:@"rose" value:@2];
    [map put:@"jim" value:@3];
    [map put:@"jake" value:@4];
    [map remove:@"jack"];
    [map remove:@"jim"];
    for (int i = 1; i <= 10; i++) {
        NSNumber *v = @(i);
        NSString *s = [NSString stringWithFormat:@"test%d", i];
        [map put:s value:v];
        TestKey *k = [[TestKey alloc] initWithValue:v];
        [map put:k value:v];
    }
    for (int i = 5; i <= 7; i++) {
        TestKey *k = [[TestKey alloc] initWithValue:@(i)];
        assert([[map remove:k] integerValue] == i);
    }
    for (int i = 1; i <= 3; i++) {
        TestKey *k = [[TestKey alloc] initWithValue:@(i)];
        [map put:k value:@(i + 5)];
    }
    assert([map size] == 19);
    TestKey *k = [[TestKey alloc] initWithValue:@1];
    assert([[map get:k] integerValue] == 6);
    k = [[TestKey alloc] initWithValue:@2];
    assert([[map get:k] integerValue] == 7);
    k = [[TestKey alloc] initWithValue:@3];
    assert([[map get:k] integerValue] == 8);
    k = [[TestKey alloc] initWithValue:@4];
    assert([[map get:k] integerValue] == 4);
    k = [[TestKey alloc] initWithValue:@5];
    assert([map get:k] == nil);
    k = [[TestKey alloc] initWithValue:@6];
    assert([map get:k] == nil);
    k = [[TestKey alloc] initWithValue:@7];
    assert([map get:k] == nil);
    k = [[TestKey alloc] initWithValue:@8];
    assert([[map get:k] integerValue] == 8);
    
    struct HashMapVisitor* v = malloc(sizeof(struct HashMapVisitor));
    v->stop = false;
    v->visit = hash_map_visit;
    [map traversal:v];
    free(v);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        testBST();
//        testAVLTree();
//        testRBTree();
//        testTreeSet();
//        testTreeMap();
//        testTreeMapSet();
        
//        testHashMap([HashMap map]);
//        testHashMap2([HashMap map]);
//        testHashMap3([HashMap map]);
//        testHashMap4([HashMap map]);
//        testHashMap5([HashMap map]);
//        testHashMap6([HashMap map]);
//
//        testHashMap([LinkedHashMap map]);
//        testHashMap2([LinkedHashMap map]);
//        testHashMap3([LinkedHashMap map]);
//        testHashMap4([LinkedHashMap map]);
//        testHashMap5([LinkedHashMap map]);
//        testHashMap6([LinkedHashMap map]);
        
        testLinkedHashMap([LinkedHashMap map]);
    }
    return 0;
}
