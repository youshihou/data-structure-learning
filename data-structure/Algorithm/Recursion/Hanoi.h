//
//  Hanoi.h
//  Algorithm
//
//  Created by Ankui on 9/9/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Hanoi : NSObject
+ (void)hanoi:(NSInteger)n a:(NSString *)p1 b:(NSString *)p2 c:(NSString *)p3;
@end

NS_ASSUME_NONNULL_END
