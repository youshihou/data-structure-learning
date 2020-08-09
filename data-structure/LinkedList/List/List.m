//
//  List.m
//  LinkedList
//
//  Created by Ankui on 8/9/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "List.h"

@implementation List

- (void)outOfBounds:(NSUInteger)index {
    NSLog(@"Index: %zd, Size: %zd", index, _size);
    assert(__func__);
}
- (void)rangeCheck:(NSUInteger)index {
    if (index < 0 || index >= _size) {
        [self outOfBounds:index];
    }
}
- (void)rangeCheckForAdd:(NSUInteger)index {
    if (index < 0 || index > _size) {
        [self outOfBounds:index];
    }
}

// MARK: - ListProtocol
- (NSUInteger)size {
    return _size;
}
- (BOOL)isEmpty {
    return _size == 0;
}
- (BOOL)contains:(id)element {
    return [self indexOf:element] != ELEMENT_NOT_FOUND;
}
- (void)add:(id)element {
    [self add:_size element:element];
}
@end
