//
//  TreeMapSet.m
//  BinaryTree
//
//  Created by Ankui on 7/30/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "TreeMapSet.h"

@interface TreeMapSet () {
    TreeMap *_map;
}
@end

@implementation TreeMapSet
- (instancetype)init {
    self = [super init];
    if (self) {
        _map = [TreeMap map];
    }
    return self;
}

+ (instancetype)set {
    return [[self alloc] init];
}
- (NSUInteger)size {
    return [_map size];
}
- (BOOL)isEmpty {
    return [_map isEmpty];
}
- (void)clear {
    [_map clear];
}
- (BOOL)contains:(id)element {
    return [_map containsKey:element];
}
- (void)add:(id)element {
    [_map put:element value:nil];
}
- (void)remove:(id)element {
    [_map remove:element];
}
- (void)traversal:(struct MapVisitor *)visitor {
    [_map traversal:visitor];
}
@end
