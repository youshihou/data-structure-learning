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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        testListGraph();
//        testListGraph2();
        
    }
    return 0;
}
