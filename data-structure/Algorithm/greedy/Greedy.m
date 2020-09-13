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
            NSLog(@"weight: %@", weights[i]);
        }
    }
    NSLog(@"total: %zd", count);
}

+ (void)coinChange {
    NSArray *faces = @[@25, @10, @5, @1];
    faces = [faces sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 integerValue] - [obj2 integerValue];
    }];
    NSInteger money = 41;
    NSInteger coins = 0;
    NSInteger count = faces.count - 1;
    for (NSInteger i = count; i >= 0; i--) {
        NSInteger face = [faces[i] integerValue];
        if (money < face) { continue; }
        money -= face;
        coins++;
        i = count + 1;
        NSLog(@"face: %zd", face);
    }
    NSLog(@"total: %zd", coins);
}
@end
