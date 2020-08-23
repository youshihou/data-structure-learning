//
//  UnionFind.h
//  UnionFind
//
//  Created by Ankui on 8/23/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnionFind : NSObject {
    @protected
    NSMutableArray *_parents;
}

- (instancetype)initWithCapacity:(NSInteger)capacity;
- (id)find:(id)value;
- (void)unionWith:(id)v1 v2:(id)v2;
- (BOOL)isSameWith:(id)v1 v2:(id)v2;

- (void)rangeCheck:(NSInteger)value;
@end

NS_ASSUME_NONNULL_END
