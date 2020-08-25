//
//  UnionFind.h
//  UnionFind
//
//  Created by Ankui on 8/23/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "UnionFindProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UnionFind : NSObject <UnionFindProtocol> {
    @protected
    NSMutableArray *_parents;
}

- (instancetype)initWithCapacity:(NSInteger)capacity;

- (void)rangeCheck:(NSInteger)value;
@end

NS_ASSUME_NONNULL_END
