//
//  TreeMap.h
//  BinaryTree
//
//  Created by Ankui on 7/29/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

struct MapVisitor {
    bool stop;
    bool (*visit)(void *, void*);
};


@protocol TreeMapComparator <NSObject>
@required
- (int)compare:(id)k1 with:(id)k2;
@end


@interface TreeMap : NSObject 
+ (instancetype)map;
+ (instancetype)mapWithComparator:(id<TreeMapComparator> _Nullable)comparator;
+ (instancetype)mapWithBlock:(int(^_Nullable)(id, id))block;
- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)clear;
- (id)put:(id)key value:(id _Nullable)value;
- (id)get:(id)key;
- (id)remove:(id)key;
- (BOOL)containsKey:(id)key;
- (BOOL)containsValue:(id)value;
- (void)traversal:(struct MapVisitor *)visitor;
@end

NS_ASSUME_NONNULL_END
