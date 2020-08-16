//
//  ListProtocol.h
//  LinkedList
//
//  Created by Ankui on 8/9/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ListProtocol <NSObject>
@required
- (NSUInteger)size;
- (BOOL)isEmpty;
- (BOOL)contains:(id)element;
- (void)add:(id)element;

@optional
- (void)clear;
- (id)get:(NSUInteger)index;
- (id)set:(NSUInteger)index element:(id)element;
- (void)add:(NSUInteger)index element:(id)element;
- (id)remove:(NSUInteger)index;
- (NSUInteger)indexOf:(id)element;
@end

NS_ASSUME_NONNULL_END
