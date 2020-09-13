//
//  Greedy.m
//  Algorithm
//
//  Created by Ankui on 9/12/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "Greedy.h"

@interface Article : NSObject {
    @public
    NSInteger _weight;
    NSInteger _value;
    NSNumber *_density;
}
@end
@implementation Article
- (instancetype)initWith:(NSInteger)weight value:(NSInteger)value {
    if (self = [super init]) {
        _weight = weight;
        _value = value;
        _density = @(value * 1.0 / weight);
    }
    return self;
}
- (NSString *)description {
    return [NSString stringWithFormat:@"Article [weight = %zd, value = %zd, density = %@", _weight, _value, _density];
}
@end


@implementation Greedy
// MARK: - pirate
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

// MARK: - coinChange
+ (void)coinChange1:(NSArray *)faces total:(NSInteger)money {
    faces = [faces sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 integerValue] - [obj2 integerValue];
    }];
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
+ (void)coinChange:(NSArray *)faces total:(NSInteger)money {
    faces = [faces sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj2 integerValue] - [obj1 integerValue];
    }];
    NSInteger coins = 0;
    NSInteger i = 0;
    while (i < faces.count) {
        NSInteger face = [faces[i] integerValue];
        if (money < face) {
            i++;
            continue;
        }
        money -= face;
        coins++;
        NSLog(@"face: %zd", face);
    }
    NSLog(@"total: %zd", coins);
}

// MARK: - knapsack
+ (void)knapsack {
    [self _select:@"Value" comparator:^NSComparisonResult(Article *obj1, Article *obj2) {
        return obj2->_value - obj1->_value;
    }];
    [self _select:@"Weight" comparator:^NSComparisonResult(Article *obj1, Article *obj2) {
        return obj1->_weight - obj2->_weight;
    }];
    [self _select:@"Density" comparator:^NSComparisonResult(Article *obj1, Article *obj2) {
        return [obj2->_density compare:obj1->_density];
    }];
}
+ (void)_select:(NSString *)title comparator:(NSComparator)cmptr {
    NSMutableArray<Article *> *array = [NSMutableArray array];
    Article *a = [[Article alloc] initWith:35 value:10];
    [array addObject:a];
    a = [[Article alloc] initWith:30 value:40];
    [array addObject:a];
    a = [[Article alloc] initWith:60 value:30];
    [array addObject:a];
    a = [[Article alloc] initWith:50 value:50];
    [array addObject:a];
    a = [[Article alloc] initWith:40 value:35];
    [array addObject:a];
    a = [[Article alloc] initWith:10 value:40];
    [array addObject:a];
    a = [[Article alloc] initWith:25 value:30];
    [array addObject:a];
    [array sortUsingComparator:cmptr];
    
    NSInteger capacity = 150;
    NSInteger weight = 0;
    NSInteger value = 0;
    NSMutableArray<Article *> *selected = [NSMutableArray array];
    for (NSInteger i = 0; i < array.count && weight < capacity; i++) {
        Article *article = array[i];
        NSInteger new = weight + article->_weight;
        if (new <= capacity) {
            weight = new;
            value += article->_value;
            [selected addObject:article];
        }
    }
    NSLog(@"[%@]", title);
    NSLog(@"total value: %zd", value);
    for (Article *a in selected) {
        NSLog(@"%@", a);
    }
    NSLog(@"--------------------------------------------------------------");
}
@end
