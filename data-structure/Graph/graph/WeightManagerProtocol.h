//
//  WeightManagerProtocol.h
//  Graph
//
//  Created by Ankui on 9/3/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WeightManagerProtocol <NSObject>
@required
- (NSInteger)compare:(id)e1 with:(id)e2;
- (id)add:(id)e1 with:(id)e2;
@end

NS_ASSUME_NONNULL_END
