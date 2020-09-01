//
//  ListGraph.m
//  Graph
//
//  Created by Ankui on 8/31/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import "ListGraph.h"

@implementation Vertex
- (instancetype)init {
    self = [super init];
    if (self) {
        _inEdges = [NSMutableSet set];
        _outEdges = [NSMutableSet set];
    }
    return self;
}
+ (instancetype)vertexWith:(id)value {
    Vertex *v = [[self alloc] init];
    v->_value = value;
    return v;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
//    else if (![super isEqual:other]) {
//        return NO;
//    }
    else {
        Vertex *v = (Vertex *)other;
        return [_value isEqual:v->_value];
    }
}
- (NSUInteger)hash {
    return _value ? [_value hash] : 0;
}
- (NSString *)description {
    return [NSString stringWithFormat:@"%@", _value ?: @"null"];
}
@end

@implementation Edge
+ (instancetype)edgeWith:(id)from to:(id)to {
    Edge *e = [[self alloc] init];
    e->_from = from;
    e->_to = to;
    return e;
}
//- (id)copyWithZone:(nullable NSZone *)zone {
//    Edge *e = [[self.class allocWithZone:zone] init];
//    e->_from = _from;
//    e->_to = _to;
//    e->_weight = _weight;
//    return e;
//}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    }
//    else if (![super isEqual:other]) {
//        return NO;
//    }
    else {
        Edge *e = (Edge *)other;
        return [_from isEqual:e->_from] && [_to isEqual:e->_to];
    }
}
- (NSUInteger)hash {
    NSUInteger fromCode = [_from hash];
    NSUInteger toCode = [_to hash];
    return fromCode * 31 + toCode;
}
- (NSString *)description {
    return [NSString stringWithFormat:@"Edge [from = %@, to = %@, weight = %@]", _from, _to, _weight];
}
@end


@interface ListGraph () {
    NSMutableDictionary *_vertices;
    NSMutableSet *_edges;
}
@end

@implementation ListGraph
- (instancetype)init {
    self = [super init];
    if (self) {
        _vertices = [NSMutableDictionary dictionary];
        _edges = [NSMutableSet set];
    }
    return self;
}
+ (instancetype)graph {
    return [[self alloc] init];
}

- (void)print {
    NSLog(@"[Vertex]:------------------------------");
    [_vertices enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"%@", key);
        Vertex *v = obj;
        NSLog(@"out-----------");
        NSLog(@"%@", v->_outEdges);
        NSLog(@"in------------");
        NSLog(@"%@", v->_inEdges);
    }];
    NSLog(@"[Edge]:------------------------------");
    [_edges enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        NSLog(@"%@", obj);
    }];
}

// MARK: - GraphProtocol
- (NSInteger)edgesSize {
    return _edges.count;
}
- (NSInteger)verticesSize {
    return _vertices.count;
}
- (void)addVertex:(nonnull id)value {
    if (!value) { return; }
    if ([_vertices.allKeys containsObject:value]) { return; }
    _vertices[value] = [Vertex vertexWith:value];
}
- (void)addEdge:(nonnull id)from to:(nonnull id)to {
    [self addEdge:from to:to weight:nil];
}
- (void)addEdge:(nonnull id)from to:(nonnull id)to weight:(id _Nullable)weight {
    if (!from) { return; }
    Vertex *fromVertex = _vertices[from];
    if (!fromVertex) {
        fromVertex = [Vertex vertexWith:from];
        _vertices[from] = fromVertex;
    }
    if (!to) { return; }
    Vertex *toVertex = _vertices[to];
    if (!toVertex) {
        toVertex = [Vertex vertexWith:to];
        _vertices[to] = toVertex;
    }
    
    Edge *edge = [Edge edgeWith:fromVertex to:toVertex];
    edge->_weight = weight;
    if ([fromVertex->_outEdges containsObject:edge]) {
        [fromVertex->_outEdges removeObject:edge];
        [toVertex->_inEdges removeObject:edge];
        [_edges removeObject:edge];
    }
    [fromVertex->_outEdges addObject:edge];
    [toVertex->_inEdges addObject:edge];
    [_edges addObject:edge];
}
- (void)removeEdge:(nonnull id)from to:(nonnull id)to {
    if (!from) { return; }
    Vertex *fromVertex = _vertices[from];
    if (!fromVertex) { return; }
    if (!to) { return; }
    Vertex *toVertex = _vertices[to];
    if (!toVertex) { return; }
    Edge *edge = [Edge edgeWith:fromVertex to:toVertex];
    if ([fromVertex->_outEdges containsObject:edge]) {
        [fromVertex->_outEdges removeObject:edge];
        [toVertex->_inEdges removeObject:edge];
        [_edges removeObject:edge];
    }
}
- (void)removeVertex:(nonnull id)value {
    if (!value) { return; }
    Vertex *vertex = _vertices[value];
    if (!vertex) { return; }
    [vertex->_outEdges enumerateObjectsUsingBlock:^(Edge *obj, BOOL *stop) {
        [obj->_to->_inEdges removeObject:obj];
        [_edges removeObject:obj];
    }];
    [vertex->_inEdges enumerateObjectsUsingBlock:^(Edge *obj, BOOL *stop) {
        [obj->_from->_outEdges removeObject:obj];
        [_edges removeObject:obj];
    }];
    [_vertices removeObjectForKey:value];
    
    
}
@end
