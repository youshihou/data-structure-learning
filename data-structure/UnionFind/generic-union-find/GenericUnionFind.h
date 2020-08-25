//
//  GenericUnionFind.h
//  UnionFind
//
//  Created by Ankui on 8/25/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "UnionFindProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface GenericUnionFind : NSObject <UnionFindProtocol>
+ (instancetype)unionFind;
- (void)makeSet:(id)value;
@end

NS_ASSUME_NONNULL_END
