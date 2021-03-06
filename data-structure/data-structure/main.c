//
//  main.c
//  data-structure
//
//  Created by Ankui on 6/30/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#include "ArrayList.h"
#include "SingleLinkedList.h"
#include "LinkedList.h"
#include "SingleCycleLinkedList.h"
#include "CycleLinkedList.h"
#include "stack.h"
#include "queue.h"
#include "deque.h"
#include "cycle_queue.h"
#include "cycle_deque.h"
#include "binary_search_tree.h"
#include "binary_heap.h"

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

void test_single_cycle_list() {
    sc_create();
    sc_add(11);
    sc_add(22);
    sc_add(33);
    sc_add(44);
    sc_print();

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

void test_list() {
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

void test_cycle_list() {
    cl_add(11);
    cl_add(22);
    cl_add(33);
    cl_add(44);
    cl_print();

    cl_add_(0, 55);
    cl_print();
    cl_add_(2, 66);
    cl_print();
    cl_add_(cl_size(), 77);
    cl_print();
    
    cl_remove(0);
    cl_print();
    cl_remove(2);
    cl_print();
    cl_remove(cl_size() - 1);
    cl_print();

    assert(cl_indexOf(44) == 3);
    assert(cl_indexOf(22) == -1);
    assert(cl_contains(33));
    assert(cl_get(0) == 11);
    assert(cl_get(1) == 66);
    assert(cl_get(cl_size() - 1) == 44);
}

void test_josephus() {
    for (int i = 1; i <= 8; i++) {
        cl_add(i);
    }
    
    cl_reset();
    while (!cl_isEmpty()) {
        cl_next();
        cl_next();
        int element = cl_remove_();
        printf("%d\n", element);
    }
}

void test_stack() {
    struct Node* s = NULL;
    
    for (int i = 0; i < 5; i++) {
        printf("push %d\n", i);
        stack_push(&s, i);
        stack_print(&s);
    }
        
    while (!stack_isEmpty(&s)) {
        printf("top gets %d, pop gets %d\n", stack_top(&s), stack_pop(&s));
        stack_print(&s);
    }
    
    stack_destroy(&s);
    stack_print(&s);
}

void test_stack_() {
    struct stack* s = stack_create();
    for (int i = 0; i < 5; i++) {
        printf("push %d\n", i);
        stack_push_(s, i);
        stack_print_(s);
    }
        
    while (!stack_isEmpty_(s)) {
        printf("top gets %d, pop gets %d\n", stack_top_(s), stack_pop_(s));
        stack_print_(s);
    }
    
    stack_destroy_(s);
    stack_print_(s);
}

void test_queue() {
    struct queue* q = queue_create();
    for (int i = 0; i < 5; i++) {
        printf("enq %d\n", i);
        enqueue(q, i);
        queue_print(q);
    }
    
    while (!queue_isEmpty(q)) {
        printf("deq gets %d\n", dequeue(q));
        queue_print(q);
    }
    
    queue_destroy(q);
    queue_print(q);
}

void test_deque(int n) {
    Deque* d = deque_create();
    assert(deque_isEmpty(d));
    for (int i = 0; i < n; i++) {
        deque_push(d, i, DEQUE_FRONT);
        assert(!deque_isEmpty(d));
    }
    for (int i = 0; i < n; i++) {
        assert(deque_pop(d, DEQUE_BACK) == i);
    }
    assert(deque_isEmpty(d));
    for (int i = 0; i < n; i++) {
        deque_push(d, i, DEQUE_BACK);
        assert(!deque_isEmpty(d));
    }
    for (int i = 0; i < n; i++) {
        assert(deque_pop(d, DEQUE_FRONT) == i);
    }
    assert(deque_isEmpty(d));
    
    for (int i = 0; i < n; i++) {
        deque_push(d, i, DEQUE_BACK);
        assert(!deque_isEmpty(d));
    }
    for (int i = n - 1; i >= 0; i--) {
        assert(deque_pop(d, DEQUE_BACK) == i);
    }
    assert(deque_isEmpty(d));
    for (int i = 0; i < n; i++) {
        deque_push(d, i, DEQUE_FRONT);
        assert(!deque_isEmpty(d));
    }
    for (int i = n - 1; i >= 0; i--) {
        assert(deque_pop(d, DEQUE_FRONT) == i);
    }
    assert(deque_isEmpty(d));
    
    assert(deque_pop(d, DEQUE_FRONT) == DEQUE_EMPTY);
    assert(deque_pop(d, DEQUE_BACK) == DEQUE_EMPTY);
    deque_push(d, 12, DEQUE_FRONT);
    deque_destroy(d);
}

void test_cycle_queue() {
    cycle_queue_create();
    for (int i = 0; i < 10; i++) {
        cycle_queue_enqueue(i);
    }
    for (int i = 0; i < 5; i++) {
        cycle_queue_dequeue();
    }
    cycle_queue_print();
    for (int i = 15; i < 23; i++) {
        cycle_queue_enqueue(i);
    }
    cycle_queue_print();
    while (!cycle_queue_isEmpty()) {
        printf("%d ", cycle_queue_dequeue());
    }
    printf("\n");
}

void test_cycle_deque() {
    cycle_deque_create();
    for (int i = 0; i < 10; i++) {
        cycle_deque_enqueue_front(i + 1);
        cycle_deque_enqueue_back(i + 100);
    }
    cycle_deque_print();
    for (int i = 0; i < 3; i++) {
        cycle_deque_dequeue_front();
        cycle_deque_dequeue_back();
    }
    cycle_deque_enqueue_front(11);
    cycle_deque_enqueue_front(12);
    cycle_deque_print();
    while (!cycle_deque_isEmpty()) {
        printf("%d ", cycle_deque_dequeue_front());
    }
    printf("\n");
}

bool levelorder_visitor(void* object) {
    struct bst_node* node = object;
    printf("%d_", node->element);
    if (node->element == 9) {
        return true;
    }
    
    return false;
}

bool postorder_visit(void* object) {
    struct bst_node* node = object;
    printf("%d_", node->element);
    if (node->element == 2) {
        return true;
    }
    
    return false;
}

bool inorder_visit(void* object) {
    struct bst_node* node = object;
    printf("%d_", node->element);
    if (node->element == 3) {
        return true;
    }
    
    return false;
}

bool preorder_visit(void* object) {
    struct bst_node* node = object;
    printf("%d_", node->element);
    if (node->element == 2) {
        return true;
    }
    
    return false;
}


void test_binary_search_tree() {
    int list[] = {7, 4, 9, 2, 5, 8, 11, 3, 12, 1};
//    int list[] = {7, 4, 9, 2, 1, 3, 5, 9, 8, 11, 10, 12};
//    int list[] = {7, 4, 9, 2, 5};
//    int list[] = {7, 4, 9, 2, 1};
    int len = sizeof(list) / sizeof(int);
    for (int i = 0; i < len; i++) {
        bst_add(list[i]);
    }
    bst_print();
//    new_print();
//    bst_preorder_traversal();
//    bst_inorder_traversal();
//    bst_postorder_traversal();
//    bst_levelorder_traversal();
    
//    levelorder_traversal(levelorder_visitor);
//
//    struct visitor* visitor = malloc(sizeof(struct visitor));
//    visitor->stop = false;
//    visitor->visit = postorder_visit;
//    postorder_traversal(visitor);
//
//    visitor->stop = false;
//    visitor->visit = inorder_visit;
//    inorder_traversal(visitor);
//
//    visitor->stop = false;
//    visitor->visit = preorder_visit;
//    preorder_traversal(visitor);
//
//    free(visitor);
    
//    printf("tree_height: %d\n", bst_tree_height());
//    printf("tree_height: %d\n", tree_height());
//
//    printf("tree_isComplete: %d\n", tree_isComplete());
//    printf("tree_isComplete: %d\n\n", isComplete());

//    bst_remove(1);
//    bst_remove(3);
//    bst_remove(12);
//    bst_remove(5);
//    bst_remove(11);
//    bst_remove(9);
    bst_remove(7);
    bst_print();
}


void test_binary_heap(void) {
    create_heap();
    heap_add(68);
    heap_add(72);
    heap_add(43);
    heap_add(50);
    heap_add(38);
    heap_add(10);
    heap_add(90);
    heap_add(65);
//    heap_remove();
    heap_replace(70);
}

void test_binary_heap2(void) {
    int data[] = {88, 44, 53, 41, 16, 6, 70, 18, 85, 98, 81, 23, 36, 43, 37};
    int len = sizeof(data) / sizeof(int);
    create_heap_list(data, len);
    heap_get();
}


typedef struct line {
    int data;
    struct line * prior;
    struct line * next;
}line;
line* initLine(line * head) {
    int i = 0;
    line * list = NULL;
    head = (line*)malloc(sizeof(line));
    head->prior = NULL;
    head->next = NULL;
    head->data = 1;
    list = head;
    for (i = 2; i <= 4; i++) {
        line * body = (line*)malloc(sizeof(line));
        body->prior = NULL;
        body->next = NULL;
        body->data = i;
        list->next = body;
        body->prior = list;
        list = list->next;
    }
    return head;
}
line * insertLine(line * head, int data, int add) {
    //新建数据域为data的结点
    line * temp = (line*)malloc(sizeof(line));
    temp->data = data;
    temp->prior = NULL;
    temp->next = NULL;
    //插入到链表头，要特殊考虑
    if (add == 1) {
        temp->next = head;
        head->prior = temp;
        head = temp;
    }
    else {
        int i = 0;
        line * body = head;
        //找到要插入位置的前一个结点
        for (i = 1; i < add - 1; i++) {
            body = body->next;
            if (body == NULL) {
                printf("插入位置有误\n");
                break;
            }
        }
        if (body) {
            //判断条件为真，说明插入位置为链表尾
            if (body->next == NULL) {
                body->next = temp;
                temp->prior = body;
            }
            else {
                body->next->prior = temp;
                temp->next = body->next;
                body->next = temp;
                temp->prior = body;
            }
        }
    }
    return head;
}
line * delLine(line * head, int data) {
    line * temp = head;
    //遍历链表
    while (temp) {
        //判断当前结点中数据域和data是否相等，若相等，摘除该结点
        if (temp->data == data) {
            temp->prior->next = temp->next;
            temp->next->prior = temp->prior;
            free(temp);
            return head;
        }
        temp = temp->next;
    }
    printf("链表中无该数据元素\n");
    return head;
}
//head为原双链表，elem表示被查找元素
int selectElem(line * head, int elem) {
    //新建一个指针t，初始化为头指针 head
    line * t = head;
    int i = 1;
    while (t) {
        if (t->data == elem) {
            return i;
        }
        i++;
        t = t->next;
    }
    //程序执行至此处，表示查找失败
    return -1;
}
//更新函数，其中，add 表示更改结点在双链表中的位置，newElem 为新数据的值
line *amendElem(line * p, int add, int newElem) {
    int i = 0;
    line * temp = p;
    //遍历到被删除结点
    for (i = 1; i < add; i++) {
        temp = temp->next;
        if (temp == NULL) {
            printf("更改位置有误！\n");
            break;
        }
    }
    if (temp) {
        temp->data = newElem;
    }
    return p;
}
//输出链表的功能函数
void display(line * head) {
    line * temp = head;
    while (temp) {
        if (temp->next == NULL) {
            printf("%d\n", temp->data);
        }
        else {
            printf("%d->", temp->data);
        }
        temp = temp->next;
    }
}
line *reverse(line *head) {
//    line *pre = NULL;
//    line *next = NULL;
//    while (head != NULL) {
//        next = head->next;
//        head->next = pre;
//        head->prior = next;
//        pre = head;
//        head = next;
//    }
//    return pre;
    
    line *tmp = NULL;
    line *cur = head;
    while (cur != NULL) {
        tmp = cur->prior;
        cur->prior = cur->next;
        cur->next = tmp;
        cur = cur->prior;
    }
    if (tmp != NULL) {
        head = tmp->prior;
    }
    return head;
}






struct ListNode *createList() {
    struct ListNode *list = NULL;
    struct ListNode *head = malloc(sizeof(struct ListNode));
    head->prev = NULL;
    head->next = NULL;
    head->element = 1;
    list = head;
    for (int i = 2; i <= 4; i++) {
        struct ListNode *add = malloc(sizeof(struct ListNode));
        add->prev = NULL;
        add->next = NULL;
        add->element = i;
        list->next = add;
        add->prev = list;
        list = list->next;
    }
    return head;
}
struct ListNode *reverseList(struct ListNode *head) {
//    struct ListNode *prev = NULL;
//    struct ListNode *next = NULL;
//    while (head) {
//        next = head->next;
//        head->next = prev;
//        head->prev = next;
//        prev = head;
//        head = next;
//    }
//    return prev;
    
    
    struct ListNode *tmp = NULL;
    struct ListNode *cur = head;
    while (cur) {
        tmp = cur->prev;
        cur->prev = cur->next;
        cur->next = tmp;
        cur = cur->prev; // CARE!!!
    }
    if (tmp) {
        head = tmp->prev; // CARE!!!
    }
    return head;
}
void print(struct ListNode *head) {
    struct ListNode *cur = head;
    while (cur) {
        if (cur->next) {
            printf("%d->", cur->element);
        } else {
            printf("%d\n", cur->element);
        }
        cur = cur->next;
    }
}


int main(int argc, const char * argv[]) {
#if 0
    test_array_list();
    test_single_list();
    test_single_cycle_list();
    test_list();
    test_cycle_list();
    test_josephus();
    test_stack();
    test_stack_();
    test_queue();
    test_deque(10);
    test_cycle_queue();
    test_cycle_deque();
#endif
    
//    test_binary_search_tree();
    
//    test_binary_heap();
//    test_binary_heap2();
    
    
//    line * head = NULL;
    //创建双链表
//    printf("初始链表为：\n");
//    head = initLine(head);
//    display(head);
//    //在表中第 3 的位置插入元素 7
//    printf("在表中第 3 的位置插入新元素 7：\n");
//    head = insertLine(head, 7, 3);
//    display(head);
//    //表中删除元素 2
//    printf("删除元素 2：\n");
//    head = delLine(head, 2);
//    display(head);
//    printf("元素 3 的位置是：%d\n", selectElem(head, 3));
//    //表中第 3 个节点中的数据改为存储 6
//    printf("将第 3 个节点存储的数据改为 6：\n");
//    head = amendElem(head, 3, 6);
//    display(head);
//    printf("---------------\n");
//    head = reverseList(head);
//    display(head);
    
    
    struct ListNode *head = createList();
    print(head);
    printf("---------------\n");
    head = reverseList(head);
    print(head);
    
    return 0;
}
