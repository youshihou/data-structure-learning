//
//  BinaryTreePrintInorder.m
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BinaryTreePrintInorder.h"
#import "NSString+Tree.h"

@implementation BinaryTreePrintInorder

static NSString *rightAppend;
static NSString *leftAppend;
static NSString *blankAppend;
static NSString *lineAppend;

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        int length = 2;
        rightAppend = [NSString stringWithFormat:@"┌%@", [@"─" repeat:length]];
        leftAppend = [NSString stringWithFormat:@"└%@", [@"─" repeat:length]];
        blankAppend = [NSString blank:length + 1];
        lineAppend = [NSString stringWithFormat:@"│%@", [NSString blank:length]];

    });
}
- (NSString *)printString {
    NSMutableString *string = [NSMutableString string];
    [string appendString:[self _printString:[self.tree root] prefix:[NSMutableString string] left:[NSMutableString string] right:[NSMutableString string]]];
    [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
    return string;
}
- (NSString *)_printString:(id)node prefix:(NSMutableString *)prefix left:(NSMutableString *)leftPrefix right:(NSMutableString *)rightPrefix {
    id left = [self.tree left:node];
    id right = [self.tree right:node];
    NSString *string = [[self.tree string:node] description];
    NSUInteger length = string.length;
    if (length >> 1 == 0) {
        length--;
    }
    length >>= 1;
    
    NSMutableString *nodeString = [NSMutableString string];
    if (right) {
        [rightPrefix appendString:[NSString blank:length]];
        [nodeString appendString:[self _printString:right prefix:[NSMutableString stringWithFormat:@"%@%@", rightPrefix, rightAppend] left:[NSMutableString stringWithFormat:@"%@%@", rightPrefix, lineAppend] right:[NSMutableString stringWithFormat:@"%@%@", rightPrefix, blankAppend]]];
    }
    [nodeString appendString:prefix];
    [nodeString appendString:string];
    [nodeString appendString:@"\n"];
    if (left) {
        [leftPrefix appendString:[NSString blank:length]];
        [nodeString appendString:[self _printString:left prefix:[NSMutableString stringWithFormat:@"%@%@", leftPrefix, leftAppend] left:[NSMutableString stringWithFormat:@"%@%@", leftPrefix, blankAppend] right:[NSMutableString stringWithFormat:@"%@%@", leftPrefix, lineAppend]]];
    }
    return nodeString;
}
@end
