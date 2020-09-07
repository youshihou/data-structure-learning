//
//  main.m
//  Graph
//
//  Created by Ankui on 8/31/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "ListGraph.h"

void testDirectedListGraph(void) {
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
void testUndirectedListGraph(void) {
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
+ (NSArray *)DFS_01 {
    return @[@[@0, @1],
             @[@1, @3], @[@1, @5], @[@1, @6], @[@1, @2],
             @[@2, @4],
             @[@3, @7],
    ];
}
+ (NSArray *)DFS_02 {
    return @[@[@"a", @"b"], @[@"a", @"e"],
             @[@"b", @"e"],
             @[@"c", @"b"],
             @[@"d", @"a"],
             @[@"e", @"c"], @[@"e", @"f"],
             @[@"f", @"c"],
    ];
}
+ (NSArray *)TOPO {
    return @[@[@0, @2],
             @[@1, @0],
             @[@2, @5],
             @[@2, @6],
             @[@3, @1], @[@3, @5], @[@3, @7],
             @[@5, @7],
             @[@6, @4],
             @[@7, @6],
    ];
}
+ (NSArray *)MST_01 {
    return @[@[@0, @2, @2], @[@0, @4, @7],
             @[@1, @2, @3], @[@1, @5, @1], @[@1, @6, @7],
             @[@2, @4, @4], @[@2, @5, @3], @[@2, @6, @6],
             @[@3, @7, @9],
             @[@4, @6, @8],
             @[@5, @6, @4], @[@5, @7, @5],
    ];
}
+ (NSArray *)MST_02 {
    return @[@[@"A", @"B", @17], @[@"A", @"F", @1], @[@"A", @"E", @16],
             @[@"B", @"C", @6], @[@"B", @"D", @5], @[@"B", @"F", @11],
             @[@"C", @"D", @10],
             @[@"D", @"E", @4], @[@"D", @"F", @14],
             @[@"E", @"F", @33],
    ];
}
+ (NSArray *)SP {
    return @[@[@"A", @"B", @10], @[@"A", @"D", @30], @[@"A", @"E", @100],
             @[@"B", @"C", @50],
             @[@"C", @"E", @10],
             @[@"D", @"C", @20], @[@"D", @"E", @60],
    ];
}
+ (NSArray *)NEGATIVE_WEIGHT1 {
    return @[@[@"A", @"B", @-1], @[@"A", @"C", @4],
             @[@"B", @"C", @3], @[@"B", @"D", @2], @[@"B", @"E", @2],
             @[@"D", @"B", @1], @[@"D", @"C", @5],
             @[@"E", @"D", @-3],
    ];
}
+ (NSArray *)NEGATIVE_WEIGHT2 {
    return @[@[@0, @1, @-1],
             @[@1, @2, @7],
             @[@1, @0, @-2],
    ];
}
@end



@interface GraphWeightManager : NSObject <WeightManagerProtocol>
@end
@implementation GraphWeightManager
- (NSInteger)compare:(nonnull id)e1 with:(nonnull id)e2 {
    return [e1 compare:e2];
}
- (nonnull id)add:(nonnull id)e1 with:(nonnull id)e2 {
    return @([e1 integerValue] + [e2 integerValue]);
}
- (nonnull id)zero {
    return @0;
}
@end

ListGraph* testDirectedGraph(NSArray *data) {
//    ListGraph *graph = [ListGraph graph];
    GraphWeightManager *manager = [[GraphWeightManager alloc] init];
    ListGraph *graph = [ListGraph graphWith:manager];
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
//    ListGraph *graph = [ListGraph graph];
    GraphWeightManager *manager = [[GraphWeightManager alloc] init];
    ListGraph *graph = [ListGraph graphWith:manager];
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

@interface GraphVisitor : NSObject <VisitorProtocol>
@end
@implementation GraphVisitor
+ (instancetype)visitor {
    return [[self alloc] init];
}
// MARK: - VisitorProtocol
- (BOOL)visit:(id)value {
    NSLog(@"%@", value);
    return [value isEqual:@2];
}
@end


void testBfs(void) {
//    ListGraph *graph = testUndirectedGraph([GraphData BFS_01]);
//    [graph bfs:@"A"];
    ListGraph *graph = testDirectedGraph([GraphData BFS_02]);
//    [graph bfs:@5];
    GraphVisitor *v = [GraphVisitor visitor];
    [graph bfs:@0 visitor:v];
}
void testDfs(void) {
//    ListGraph *graph = testUndirectedGraph([GraphData DFS_01]);
//    [graph dfs:@1];
    ListGraph *graph = testDirectedGraph([GraphData DFS_02]);
//    [graph dfs:@"c"];
    GraphVisitor *v = [GraphVisitor visitor];
    [graph dfs:@"a" visitor:v];
}
void testTopo(void) {
    ListGraph *graph = testDirectedGraph([GraphData TOPO]);
    NSArray *list = [graph topologicalSort];
    NSLog(@"%@", list);
}
void testMst(void) {
    ListGraph *graph = testUndirectedGraph([GraphData MST_01]);
    NSSet *set = [graph mst];
    for (EdgeInfo *i in set) {
        NSLog(@"%@", i);
    }
}
void testSp(void) {
//    ListGraph *graph = testDirectedGraph([GraphData SP]);
//    ListGraph *graph = testUndirectedGraph([GraphData SP]);
//    ListGraph *graph = testDirectedGraph([GraphData NEGATIVE_WEIGHT1]);
//    NSDictionary *sp = [graph shortestPath:@"A"];
    ListGraph *graph = testDirectedGraph([GraphData NEGATIVE_WEIGHT2]);
    NSDictionary *sp = [graph shortestPath:@0];
    [sp enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"%@ - %@", key, obj);
    }];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        testDirectedListGraph();
//        testUndirectedListGraph();
//        testBfs();
//        testDfs();
//        testTopo();
//        testMst();
        testSp();
    }
    return 0;
}
