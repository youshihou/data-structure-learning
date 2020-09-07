//
//  ListGraph.h
//  Graph
//
//  Created by Ankui on 8/31/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "GraphProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class Edge;

@interface Vertex : NSObject <NSCopying> {
    @public
    id _value;
    NSMutableSet<Edge *> *_inEdges;
    NSMutableSet<Edge *> *_outEdges;
}
+ (instancetype)vertexWith:(id)value;
@end


@interface Edge : NSObject {
    @public
    Vertex *_from;
    Vertex *_to;
    id _weight;
}
+ (instancetype)edgeWith:(id)from to:(id)to;
@end


@interface EdgeInfo : NSObject 
+ (instancetype)infoWith:(id)from to:(id)to weight:(id)weight;
@end


@interface PathInfo : NSObject {
    @public
    id _weight;
    NSMutableArray *_edgeInfos;
}
+ (instancetype)path;
+ (instancetype)pathWith:(id)weight;
@end


@interface ListGraph : NSObject <GraphProtocol>
+ (instancetype)graph;
+ (instancetype)graphWith:(id<WeightManagerProtocol>)manager;
- (void)print;


- (void)bfs:(id)begin;
- (void)dfs:(id)begin;
- (void)dfs1:(id)begin;
@end

NS_ASSUME_NONNULL_END
