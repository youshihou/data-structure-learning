//
//  HashMap.h
//  BinaryTree
//
//  Created by Ankui on 7/31/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

struct HashMapVisitor {
    bool stop;
    bool (*visit)(void*, void*);
};


@interface HashNode : NSObject {
    @public
    id _key;
    id _value;
    NSUInteger _hash;
    HashNode *_left;
    HashNode *_right;
    __weak HashNode *_parent;
    BOOL _color;
}
+ (instancetype)nodeWithKey:(id)key value:(id)value parent:(HashNode * _Nullable)parent;
@end


@interface HashMap : NSObject
+ (instancetype)map;
- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)clear;
- (id)put:(id _Nullable)key value:(id _Nullable)value;
- (id)get:(id _Nullable)key;
- (id)remove:(id)key;
- (BOOL)containsKey:(id _Nullable)key;
- (BOOL)containsValue:(id _Nullable)value;
- (void)traversal:(struct HashMapVisitor * _Nullable)visitor;
- (void)print;

- (HashNode *)createNode:(id)key value:(id)value parent:(HashNode * _Nullable)parent;
- (void)afterRemove:(HashNode *)node will:(HashNode *)will;
@end

NS_ASSUME_NONNULL_END
