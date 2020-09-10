//
//  Hanoi.m
//  Algorithm
//
//  Created by Ankui on 9/9/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "Hanoi.h"

@implementation Hanoi
+ (void)hanoi:(NSInteger)n a:(NSString *)p1 b:(NSString *)p2 c:(NSString *)p3 {
    if (n == 1) {
        [self _move:n from:p1 to:p3];
        return;
    }
    
    [self hanoi:n - 1 a:p1 b:p3 c:p2];
    [self _move:n from:p1 to:p3];
    [self hanoi:n - 1 a:p2 b:p1 c:p3];
}
+ (void)_move:(NSInteger)n from:(NSString *)from to:(NSString *)to {
    NSLog(@"Move %zd from %@ to %@", n, from, to);
}
@end
