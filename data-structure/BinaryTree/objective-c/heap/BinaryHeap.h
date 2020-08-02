//
//  Heap.h
//  BinaryTree
//
//  Created by Ankui on 8/2/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BinaryHeap : NSObject
- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)clear;
- (void)add:(id)element;
- (id)get;
- (id)remove;
- (id)replace:(id)element;
@end

NS_ASSUME_NONNULL_END
