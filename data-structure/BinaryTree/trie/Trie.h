//
//  Trie.h
//  BinaryTree
//
//  Created by Ankui on 8/6/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Trie : NSObject
+ (instancetype)trie;
- (NSUInteger)size;
- (BOOL)isEmpty;
- (void)clear;
- (id)get:(NSString *)key;
- (BOOL)contains:(NSString *)key;
- (id)addKey:(NSString *)key value:(id)value;
- (id)remove:(NSString *)key;
- (BOOL)starsWith:(NSString *)prefix;
@end

NS_ASSUME_NONNULL_END
