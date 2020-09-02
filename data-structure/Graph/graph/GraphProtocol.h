//
//  GraphProtocol.h
//  Graph
//
//  Created by Ankui on 8/31/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "VisitorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GraphProtocol <NSObject>
@required
- (NSInteger)edgesSize;
- (NSInteger)verticesSize;
- (void)addVertex:(id)value;
- (void)addEdge:(id)from to:(id)to;
- (void)addEdge:(id)from to:(id)to weight:(id _Nullable)weight;
- (void)removeVertex:(id)value;
- (void)removeEdge:(id)from to:(id)to;

@optional
- (void)bfs:(id)begin visitor:(id<VisitorProtocol>)visitor;
- (void)dfs:(id)begin visitor:(id<VisitorProtocol>)visitor;
@end

NS_ASSUME_NONNULL_END
