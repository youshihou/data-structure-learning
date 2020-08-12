//
//  LinkedList.h
//  LinkedList
//
//  Created by Ankui on 8/9/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "List.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListNode : NSObject {
    @public
    id _element;
    ListNode *_next;
}
+ (instancetype)nodeWithElement:(id _Nullable)element next:(ListNode * _Nullable)next;
@end

@interface LinkedList : List 

@end

NS_ASSUME_NONNULL_END
