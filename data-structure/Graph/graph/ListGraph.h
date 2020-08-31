//
//  Graph.h
//  Graph
//
//  Created by Ankui on 8/31/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Vertex : NSObject {
    @public
    NSMutableSet *_inEdges;
    NSMutableSet *_outEdges;
    id _value;
}
@end

@interface Edge : NSObject {
    @public
    Vertex *_from;
    Vertex *_to;
    id _weight;
}
@end

@interface ListGraph : NSObject

@end

NS_ASSUME_NONNULL_END
