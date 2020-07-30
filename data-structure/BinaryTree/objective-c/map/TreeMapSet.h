//
//  TreeMapSet.h
//  BinaryTree
//
//  Created by Ankui on 7/30/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "TreeMap.h"

NS_ASSUME_NONNULL_BEGIN

@interface TreeMapSet : NSObject
+ (instancetype)set;
- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)clear;
- (BOOL)contains:(id)element;
- (void)add:(id)element;
- (void)remove:(id)element;
- (void)traversal:(struct MapVisitor *)visitor;
@end

NS_ASSUME_NONNULL_END
