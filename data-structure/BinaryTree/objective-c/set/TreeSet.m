//
//  TreeSet.m
//  BinaryTree
//
//  Created by Ankui on 7/29/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "TreeSet.h"

@interface TreeSet () {
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

- (NSInteger)size {
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
