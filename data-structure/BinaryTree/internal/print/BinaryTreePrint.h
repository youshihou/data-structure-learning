//
//  BinaryTreePrint.h
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinaryTreeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BinaryTreePrint : NSObject

@property (nonatomic, strong) id<BinaryTreeProtocol> tree;

+ (instancetype)printWithTree:(id<BinaryTreeProtocol>)tree;
- (void)println;
- (void)print;
- (NSString *)printString;

@end

NS_ASSUME_NONNULL_END
