//
//  BinaryHeap.h
//  BinaryTree
//
//  Created by Ankui on 8/2/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "Heap.h"

NS_ASSUME_NONNULL_BEGIN

@interface BinaryHeap : Heap
- (void)clear;
- (void)add:(id)element;
- (id)get;
- (id)remove;
- (id)replace:(id)element;
- (void)print;
@end

NS_ASSUME_NONNULL_END
