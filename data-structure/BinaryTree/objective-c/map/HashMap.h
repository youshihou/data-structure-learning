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
- (void)traversal:(struct HashMapVisitor *)visitor;
- (void)print;
@end

NS_ASSUME_NONNULL_END
