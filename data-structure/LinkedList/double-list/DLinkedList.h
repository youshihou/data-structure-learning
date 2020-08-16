//
//  DLinkedList.h
//  LinkedList
//
//  Created by Ankui on 8/13/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "List.h"

NS_ASSUME_NONNULL_BEGIN

@interface DLinkedList : List

@end


@interface CircleDLinkedList : List
- (void)reset;
- (id)next;
- (id)remove;
@end

NS_ASSUME_NONNULL_END
