//
//  BinaryTreeProtocol.h
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BinaryTreeProtocol <NSObject>
@required

- (id)root;
- (id)left:(id)object;
- (id)right:(id)object;
- (id)string:(id)object;

@end

NS_ASSUME_NONNULL_END
