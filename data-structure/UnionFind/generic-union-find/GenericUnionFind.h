//
//  GenericUnionFind.h
//  UnionFind
//
//  Created by Ankui on 8/25/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GenericUnionFind : NSObject
+ (instancetype)unionFind;
- (void)makeSet:(id)value;
- (id)find:(id)value;
- (void)unionWith:(id)v1 v2:(id)v2;
- (BOOL)isSameWith:(id)v1 v2:(id)v2;
@end

NS_ASSUME_NONNULL_END
