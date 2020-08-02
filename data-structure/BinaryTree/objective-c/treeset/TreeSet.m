//
//  TreeSet.m
//  BinaryTree
//
//  Created by Ankui on 7/29/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "TreeSet.h"

@interface TreeSet () {
//    int(^_block)(id, id);
//    id<BSTComparator> _comparator;
    RBTree* _tree;
}
@end

@implementation TreeSet
- (instancetype)init {
    self = [super init];
    if (self) {
        _tree = [RBTree tree];
    }
    return self;
}
+ (instancetype)set {
    return [[self alloc] init];
}
//+ (instancetype)setWithComparator:(id<BSTComparator>)comparator {
//    TreeSet *set = [TreeSet set];
//    set->_comparator = comparator;
//    return set;
//}
//+ (instancetype)setWithBlock:(int (^)(id _Nonnull, id _Nonnull))block {
//    TreeSet *set = [TreeSet set];
//    set->_block = block;
//    return set;
//}

- (NSUInteger)size {
    return [_tree size];
}
- (BOOL)isEmpty {
    return [_tree isEmpty];
}
- (void)clear {
    [_tree clear];
}
- (BOOL)contains:(id)element {
    return [_tree contains:element];
}
- (void)add:(id)element {
    [_tree add:element];
}
- (void)remove:(id)element {
    [_tree remove:element];
}
- (void)traversal:(struct Visitor *)visitor {
    if (visitor == NULL) { return; }
    [_tree inorder:visitor];
}
@end
