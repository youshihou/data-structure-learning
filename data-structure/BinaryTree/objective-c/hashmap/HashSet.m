//
//  HashSet.m
//  BinaryTree
//
//  Created by Ankui on 8/2/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "HashSet.h"

@interface HashSet () {
    HashMap *_map;
}
@end

@implementation HashSet
- (instancetype)init {
    if (self = [super init]) {
        _map = [HashMap map];
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
- (void)traversal:(struct HashMapVisitor *)visitor {
    [_map traversal:visitor];
}
@end
