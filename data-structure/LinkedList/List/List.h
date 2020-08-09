//
//  List.h
//  LinkedList
//
//  Created by Ankui on 8/9/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "ListProtocol.h"

NS_ASSUME_NONNULL_BEGIN

static const NSInteger ELEMENT_NOT_FOUND = -1;

@interface List : NSObject <ListProtocol> {
    @protected
    NSUInteger _size;
}

- (void)outOfBounds:(NSUInteger)index;
- (void)rangeCheck:(NSUInteger)index;
- (void)rangeCheckForAdd:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
