//
//  Sort.h
//  Sort
//
//  Created by Ankui on 8/16/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sort : NSObject {
    NSMutableArray *_array;
    @public
    NSUInteger _cmpCount;
    NSUInteger _swapCount;
    CFTimeInterval _time;
}
+ (instancetype)sort;
- (void)sort:(NSMutableArray *)array;
- (void)sorting;
- (NSInteger)cmp:(NSUInteger)i1 with:(NSUInteger)i2;
- (NSInteger)cmpElement:(id)e1 with:(id)e2;
- (void)swap:(NSUInteger)i1 with:(NSUInteger)i2;
@end

NS_ASSUME_NONNULL_END
