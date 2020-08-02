//
//  HashSet.h
//  BinaryTree
//
//  Created by Ankui on 8/2/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "HashMap.h"

NS_ASSUME_NONNULL_BEGIN

@interface HashSet : NSObject
+ (instancetype)set;
- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)clear;
- (BOOL)contains:(id _Nullable)element;
- (void)add:(id _Nullable)element;
- (void)remove:(id _Nullable)element;
- (void)traversal:(struct HashMapVisitor * _Nullable)visitor;
@end

NS_ASSUME_NONNULL_END
