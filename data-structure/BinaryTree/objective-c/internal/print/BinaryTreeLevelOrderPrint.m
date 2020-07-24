//
//  BinaryTreeLevelOrderPrint.m
//  BinaryTree
//
//  Created by Ankui on 7/24/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "BinaryTreeLevelOrderPrint.h"
#import "NSString+Tree.h"

// MARK: - TreeNode begin
@interface TreeNode : NSObject {
    @public
    NSUInteger _x;
    NSUInteger _y;
    NSUInteger _width;
    NSUInteger _height;
    NSString *_string;
    __weak id _node;
    TreeNode *_left;
    TreeNode *_right;
    __weak TreeNode *_parent;
}
- (NSUInteger)rightBound;
- (NSUInteger)leftBound;
@end

// MARK: - LevelInfo begin
@interface LevelInfo : NSObject {
    @public
    NSUInteger _leftX;
    NSUInteger _rightX;
}
@end
@implementation LevelInfo
+ (instancetype)levelInfoWith:(TreeNode *)left right:(TreeNode *)right {
    LevelInfo *i = [[self alloc] init];
    i->_leftX = [left leftBound];
    i->_rightX = [right rightBound];
    return i;
}
@end
// MARK: - LevelInfo end


@implementation TreeNode
static NSUInteger const TOP_LINE_SPACE = 1;
+ (instancetype)nodeWithString:(NSString *)string {
    string = !string ? @"null" : string;
    string = string.length ? string : @" ";
    
    TreeNode *n = [[self alloc] init];
    n->_string = string;
    n->_width = string.length;
    return n;
}
+ (instancetype)nodeWithNode:(id)node tree:(id<BinaryTreeProtocol>)tree {
    TreeNode *n = [self nodeWithString:[[tree string:node] description]];
    n->_node = node;
    return n;
}
- (NSUInteger)rightX {
    return _x + _width;
}
- (NSUInteger)topX {
    NSUInteger delta = _width;
    if (delta >> 1 == 0) {
        delta--;
    }
    delta >>= 1;
    
    if (_parent && self == _parent->_left) {
        return [self rightX] - 1 - delta;
    } else {
        return _x + delta;
    }
}
- (NSUInteger)leftBound {
    if (!_left) { return _x; }
    return [_left topX];
}
- (NSUInteger)rightBound {
    if (!_right) { return [self rightX]; }
    return [_right topX] + 1;
}
- (NSUInteger)leftBoundLength {
    return _x - [self leftBound];
}
- (NSUInteger)rightBoundLength {
    return [self rightBound] - [self rightX];
}
- (NSUInteger)leftBoundEmptyLength {
    return [self leftBoundLength] - 1 - TOP_LINE_SPACE;
}
- (NSUInteger)rightBoundEmptyLength {
    return [self rightBoundLength] - 1 - TOP_LINE_SPACE;
}
- (void)translateX:(NSUInteger)deltaX {
    if (!deltaX) { return; }
    _x += deltaX;
    
    if (!_node) { return; }
    if (_left) {
        [_left translateX:deltaX];
    }
    if (_right) {
        [_right translateX:deltaX];
    }
}
- (void)balance:(TreeNode *)left right:(TreeNode *)right {
    if (!left || !right) { return; }
    NSUInteger deltaLeft = _x + [left rightX];
    NSUInteger deltaRight = right->_x - [self rightX];
    NSUInteger delta = MAX(deltaLeft, deltaRight);
    NSUInteger rightX = [self rightX] + delta;
    [right translateX:rightX - right->_x];
    NSUInteger leftX = _x - delta - left->_width;
    [left translateX:leftX - left->_x];
}
- (NSUInteger)treeHeight:(TreeNode *)root {
    if (!root) { return 0; }
    if (root->_height) { return root->_height; }
    root->_height = 1 + MAX([self treeHeight:root->_left], [self treeHeight:root->_right]);
    return root->_height;
}
- (LevelInfo *)levelInfo:(NSUInteger)level {
    if (level < 0) { return nil; }
    NSUInteger levelY = _y + level;
    if (level >= [self treeHeight:self]) { return nil; }
    NSMutableArray *list = [NSMutableArray array];
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:self];
    while (queue.count) {
        TreeNode *node = queue.firstObject;
        [queue removeObjectAtIndex:0];
        if (levelY == node->_y) {
            [list addObject:node];
        } else if (node->_y > levelY) {
            break;
        }
        
        if (node->_left) {
            [queue addObject:node->_left];
        }
        if (node->_right) {
            [queue addObject:node->_right];
        }
    }
    TreeNode *left = list.firstObject;
    TreeNode *right = list.lastObject;
    return [LevelInfo levelInfoWith:left right:right];
}
- (NSUInteger)minLevelSpaceToRight:(TreeNode *)right {
    NSUInteger height = [self treeHeight:self];
    NSUInteger rightHeight = [self treeHeight:right];
    NSUInteger minSpace = NSUIntegerMax;
    for (NSUInteger i = 0; i < height && i < rightHeight; i++) {
        NSUInteger space = [right levelInfo:i]->_leftX - [self levelInfo:i]->_rightX;
        minSpace = MIN(minSpace, space);
    }
    return minSpace;
}
@end
// MARK: - TreeNode end





@interface BinaryTreeLevelOrderPrint () {
    TreeNode *_root;
    NSUInteger _maxWidth;
    NSUInteger _minX;
    NSMutableArray<NSMutableArray<TreeNode *> *> *_nodes;
}

@end

@implementation BinaryTreeLevelOrderPrint

static NSUInteger const MIN_SPACE = 1;

+ (instancetype)printWithTree:(id<BinaryTreeProtocol>)tree {
    BinaryTreeLevelOrderPrint *p = [super printWithTree:tree];
    p->_root = [TreeNode nodeWithNode:[tree root] tree:tree];
    p->_maxWidth = p->_root->_width;
    return p;
}
- (NSString *)printString {
    _nodes = [NSMutableArray array];
    [self _fillNodes];
    [self _cleanNodes];
    [self _compressNodes];
    [self _addLineNodes];
    
    NSUInteger rowCount = _nodes.count;
    NSMutableString *string = [NSMutableString string];
    for (NSUInteger i = 0; i < rowCount; i++) {
        if (i) {
            [string appendString:@"\n"];
        }
        NSMutableArray *rowNodes = _nodes[i];
        NSMutableString *rowString = [NSMutableString string];
        for (TreeNode *node in rowNodes) {
            NSUInteger leftSpace = node->_x - rowString.length - _minX;
            [rowString appendString:[NSString blank:leftSpace]];
            [rowString appendString:node->_string];
        }
        [string appendString:rowString];
    }
    return string;
}
- (TreeNode *)_add:(NSMutableArray *)nodes node:(id)node {
    TreeNode *n = nil;
    if (node) {
        n = [TreeNode nodeWithNode:node tree:self.tree];
        _maxWidth = MAX(_maxWidth, n->_width);
        [nodes addObject:n];
    } else {
        [nodes addObject:[NSNull null]];
    }
    return n;
}
- (void)_fillNodes {
    NSMutableArray *firstRowNodes = [NSMutableArray array];
    [firstRowNodes addObject:_root];
    [_nodes addObject:firstRowNodes];
    
    while (YES) {
        NSMutableArray *prevRowNodes = _nodes.lastObject;
        NSMutableArray *rowNodes = [NSMutableArray array];
        BOOL notNull = NO;
        for (TreeNode *node in prevRowNodes) {
            if ([node isEqual:[NSNull null]]) {
                [rowNodes addObject:[NSNull null]];
                [rowNodes addObject:[NSNull null]];
            } else {
                TreeNode *left = [self _add:rowNodes node:[self.tree left:node->_node]];
                if (left) {
                    node->_left = left;
                    left->_parent = node;
                    notNull = YES;
                }
                TreeNode *right = [self _add:rowNodes node:[self.tree right:node->_node]];
                if (right) {
                    node->_right = right;
                    right->_parent = node;
                    notNull = YES;
                }
            }
        }

        if (!notNull) { break; }
        [_nodes addObject:rowNodes];
    }
}
- (void)_cleanNodes {
    NSUInteger rowCount = _nodes.count;
    if (rowCount < 2) { return; }
    
    NSUInteger lastRowNodeCount = _nodes.lastObject.count;
    NSUInteger nodeSpace = _maxWidth + 2;
    NSUInteger lastRowLength = lastRowNodeCount * _maxWidth + nodeSpace * (lastRowNodeCount - 1);
    for (NSUInteger i = 0; i < rowCount; i++) {
        NSMutableArray *rowNodes = _nodes[i];
        NSUInteger rowNodeCount = rowNodes.count;
        NSUInteger allSpace = lastRowLength - (rowNodeCount - 1) * nodeSpace;
        NSUInteger cornerSpace = allSpace / rowNodeCount - _maxWidth;
        cornerSpace >>= 1;
        NSUInteger rowLength = 0;
        for (NSUInteger j = 0; j < rowNodeCount; j++) {
            if (j) {
                rowLength += nodeSpace;
            }
            rowLength += cornerSpace;
            TreeNode *node = rowNodes[j];
            if (node) {
                NSUInteger deltaX = (_maxWidth - node->_width) >> 1;
                node->_x = rowLength + deltaX;
                node->_y = i;
            }
            rowLength += _maxWidth;
            rowLength += cornerSpace;
        }
        [rowNodes removeObject:[NSNull null]];
    }
}
- (void)_compressNodes {
    NSUInteger rowCount = _nodes.count;
    if (rowCount < 2) { return; }
    for (int i = (int)(rowCount - 2); i >= 0; i--) {
        NSMutableArray *rowNodes = _nodes[i];
        for (TreeNode *node in rowNodes) {
            TreeNode *left = node->_left;
            TreeNode *right = node->_right;
            if (!left && !right) { continue; }
            if (left && right) {
                [node balance:left right:right];
                NSUInteger leftEmpty = [node leftBoundEmptyLength];
                NSUInteger rightEmpty = [node rightBoundEmptyLength];
                NSUInteger empty = MIN(leftEmpty, rightEmpty);
                empty = MIN(empty, (right->_x - [left rightX]) >> 1);
                NSUInteger space = [left minLevelSpaceToRight:right] - MIN_SPACE;
                space = MIN(space >> 1, empty);
                if (space > 0) {
                    [left translateX:space];
                    [right translateX:-space];
                }
                space = [left minLevelSpaceToRight:right] - MIN_SPACE;
                if (space < 1) { continue; }
                leftEmpty = [node leftBoundEmptyLength];
                rightEmpty = [node rightBoundEmptyLength];
                if (leftEmpty < 1 && rightEmpty < 1) { continue; }
                if (leftEmpty > rightEmpty) {
                    [left translateX:MIN(leftEmpty, space)];
                } else {
                    [right translateX:-MIN(rightEmpty, space)];
                }
            } else if (left) {
                [left translateX:[node leftBoundEmptyLength]];
            } else {
                [right translateX:-[node rightBoundEmptyLength]];
            }
        }
    }
}
- (void)_addXLineNode:(NSMutableArray *)row parent:(TreeNode *)parent x:(NSUInteger)x {
    TreeNode *node = [TreeNode nodeWithString:@"─"];
    node->_x = x;
    node->_y = parent->_y;
    [row addObject:node];
}
- (TreeNode *)_addLineNode:(NSMutableArray *)row next:(NSMutableArray *)next parent:(TreeNode *)parent child:(TreeNode *)child {
    if (!child) { return nil; }
    TreeNode *top = nil;
    NSUInteger topX = [child topX];
    if (child == parent->_left) {
        top = [TreeNode nodeWithString:@"┌"];
        [row addObject:top];
        for (NSUInteger x = topX + 1; x < parent->_x; x++) {
            [self _addXLineNode:row parent:parent x:x];
        }
    } else {
        for (NSUInteger x = [parent rightX]; x < topX; x++) {
            [self _addXLineNode:row parent:parent x:x];
        }
        top = [TreeNode nodeWithString:@"┐"];
        [row addObject:top];
    }
    top->_x = topX;
    top->_y = parent->_y;
    child->_y = parent->_y + 2;
    _minX = MIN(_minX, child->_x);
    
    TreeNode *bottom = [TreeNode nodeWithString:@"│"];
    bottom->_x = topX;
    bottom->_y = parent->_y + 1;
    [next addObject:bottom];
    
    return top;
}
- (void)_addLineNodes {
    NSMutableArray *newNodes = [NSMutableArray array];
    NSUInteger rowCount = _nodes.count;
    if (rowCount < 2) { return; }
    _minX = _root->_x;
    for (NSUInteger i = 0; i < rowCount; i++) {
        NSMutableArray *rowNodes = _nodes[i];
        if (i == rowCount - 1) {
            [newNodes addObject:rowNodes];
            continue;
        }
        NSMutableArray *newRowNodes = [NSMutableArray array];
        [newNodes addObject:newRowNodes];
        NSMutableArray *lineNodes = [NSMutableArray array];
        [newNodes addObject:lineNodes];
        for (TreeNode *node in rowNodes) {
            [self _addLineNode:newRowNodes next:lineNodes parent:node child:node->_left];
            [newRowNodes addObject:node];
            [self _addLineNode:newRowNodes next:lineNodes parent:node child:node->_right];
        }
    }
    [_nodes removeAllObjects];
    [_nodes addObjectsFromArray:newNodes];
}
@end
