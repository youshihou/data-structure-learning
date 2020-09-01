//
//  main.m
//  Graph
//
//  Created by Ankui on 8/31/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "ListGraph.h"

void testListGraph(void) {
    ListGraph *graph = [ListGraph graph];
    [graph addEdge:@"V1" to:@"V0" weight:@9];
    [graph addEdge:@"V1" to:@"V2" weight:@3];
    [graph addEdge:@"V2" to:@"V0" weight:@2];
    [graph addEdge:@"V2" to:@"V3" weight:@5];
    [graph addEdge:@"V3" to:@"V4" weight:@1];
    [graph addEdge:@"V0" to:@"V4" weight:@6];
//    [graph removeEdge:@"V0" to:@"V4"];
//    [graph removeVertex:@"V0"];
//    [graph print];
    [graph bfs:@"V1"];
}
void testListGraph2(void) {
    ListGraph *graph = [ListGraph graph];
    [graph addEdge:@"V0" to:@"V1"];
    [graph addEdge:@"V1" to:@"V0"];
    
    [graph addEdge:@"V0" to:@"V2"];
    [graph addEdge:@"V2" to:@"V0"];
    
    [graph addEdge:@"V0" to:@"V3"];
    [graph addEdge:@"V3" to:@"V0"];
    
    [graph addEdge:@"V2" to:@"V1"];
    [graph addEdge:@"V1" to:@"V2"];
    
    [graph addEdge:@"V2" to:@"V3"];
    [graph addEdge:@"V3" to:@"V2"];
    [graph print];
}

@interface GraphData : NSObject

@end
@implementation GraphData
+ (NSArray *)BFS_01 {
    return @[@[@"A", @"B"], @[@"A", @"F"],
             @[@"B", @"C"], @[@"B", @"I"], @[@"B", @"G"],
             @[@"C", @"I"], @[@"C", @"D"],
             @[@"D", @"I"], @[@"D", @"G"], @[@"D", @"E"], @[@"D", @"H"],
             @[@"E", @"H"], @[@"E", @"F"],
             @[@"F", @"G"],
             @[@"G", @"H"],
    ];
}
+ (NSArray *)BFS_02 {
    return @[@[@0, @1], @[@0, @4],
             @[@1, @2],
             @[@2, @0], @[@2, @4], @[@2, @5],
             @[@3, @1],
             @[@4, @6], @[@4, @7],
             @[@5, @3], @[@5, @7],
             @[@6, @2], @[@6, @7],
    ];
}
+ (NSArray *)BFS_03 {
    return @[@[@0, @2], @[@0, @3],
             @[@1, @2], @[@1, @3], @[@1, @6],
             @[@2, @4],
             @[@3, @7],
             @[@4, @6],
             @[@5, @6],
             @[@6, @7],
    ];
}
+ (NSArray *)BFS_04 {
    return @[@[@1, @2], @[@1, @3], @[@1, @5],
             @[@2, @0],
             @[@3, @5],
             @[@5, @6], @[@5, @7],
             @[@6, @2],
             @[@7, @6],
    ];
}
@end

ListGraph* testDirectedGraph(NSArray *data) {
    ListGraph *graph = [ListGraph graph];
    for (NSArray *list in data) {
        if (list.count == 1) {
            [graph addVertex:list.firstObject];
        } else if (list.count == 2) {
            [graph addEdge:list.firstObject to:list.lastObject];
        } else if (list.count == 3) {
            [graph addEdge:list.firstObject to:list[1] weight:list.lastObject];
        }
    }
    return graph;
}
ListGraph* testUndirectedGraph(NSArray *data) {
    ListGraph *graph = [ListGraph graph];
    for (NSArray *list in data) {
        if (list.count == 1) {
            [graph addVertex:list.firstObject];
        } else if (list.count == 2) {
            id from = list.firstObject;
            id to = list.lastObject;
            [graph addEdge:from to:to];
            [graph addEdge:to to:from];
        } else if (list.count == 3) {
            id from = list.firstObject;
            id to = list[1];
            id weight = list.lastObject;
            [graph addEdge:from to:to weight:weight];
            [graph addEdge:to to:from weight:weight];
        }
    }
    return graph;
}

void testBfs() {
//    ListGraph *graph = testUndirectedGraph([GraphData BFS_01]);
//    [graph bfs:@"A"];
    ListGraph *graph = testDirectedGraph([GraphData BFS_02]);
    [graph bfs:@5];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        testListGraph();
//        testListGraph2();
        testBfs();
    }
    return 0;
}
