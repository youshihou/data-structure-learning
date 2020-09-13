//
//  Greedy.m
//  Algorithm
//
//  Created by Ankui on 9/12/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "Greedy.h"

@implementation Greedy
+ (void)pirate {
    NSArray *weights = @[@3, @5, @4, @10, @7, @14, @2, @11];
    weights = [weights sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 integerValue] - [obj2 integerValue];
    }];
    NSInteger capacity = 30;
    NSInteger weight = 0;
    NSInteger count = 0;
    for (NSInteger i = 0; i < weights.count && weight < capacity; i++) {
        NSInteger new = weight + [weights[i] integerValue];
        if (new <= capacity) {
            weight = new;
            count++;
            NSLog(@"%@", weights[i]);
        }
    }
    NSLog(@"total: %zd", count);
}
@end
