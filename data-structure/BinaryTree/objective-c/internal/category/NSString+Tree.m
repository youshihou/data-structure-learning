//
//  NSString+Tree.m
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "NSString+Tree.h"

@implementation NSString (Tree)

+ (NSString *)blank:(NSInteger)count {
    return [@" " repeat:count];
}

- (NSString *)repeat:(NSInteger)count {
    NSMutableString *s = [NSMutableString string];
    while (count-- > 0) {
        [s appendString:self];
    }
    return s;
}

@end
