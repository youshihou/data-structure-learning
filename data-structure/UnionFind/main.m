//
//  main.m
//  UnionFind
//
//  Created by Ankui on 8/23/20.
//  Copyright © 2020 Ankui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnionFind.h"
#import "QuickFind.h"
#import "QuickUnion.h"
#import "QuickUnionSize.h"
#import "QuickUnionRank.h"
#import "QuickUnionRankPathCompression.h"
#import "QuickUnionRankPathSpliting.h"
#import "QuickUnionRankPathHalving.h"
#import "GenericUnionFind.h"

void testUnionFind(UnionFind *uf, NSInteger count) {
    CFTimeInterval begin = CFAbsoluteTimeGetCurrent();
    for (NSInteger i = 0; i < count; i++) {
        NSInteger v1 = arc4random() % count;
        NSInteger v2 = arc4random() % count;
        [uf unionWith:@(v1) v2:@(v2)];
    }
    for (NSInteger i = 0; i < count; i++) {
        NSInteger v1 = arc4random() % count;
        NSInteger v2 = arc4random() % count;
        [uf isSameWith:@(v1) v2:@(v2)];
    }
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    NSString *time = [[NSString alloc] initWithFormat:@"time:  %fs(%f)ms", end - begin, (end - begin) * 1000.0];
    NSString *name = NSStringFromClass(uf.class);
    NSString *line = @"---------------------------------------------------------";
    NSLog(@"\n[%@]\nbegin: %f\nend:   %f\n%@\n%@", name, begin, end, time, line);
}

void testUF(void) {
    NSInteger count = 10000;
//    testUnionFind([[QuickFind alloc] initWithCapacity:count], count);
//    testUnionFind([[QuickUnion alloc] initWithCapacity:count], count);
//    testUnionFind([[QuickUnionSize alloc] initWithCapacity:count], count);
    testUnionFind([[QuickUnionRank alloc] initWithCapacity:count], count);
    testUnionFind([[QuickUnionRankPathCompression alloc] initWithCapacity:count], count);
    testUnionFind([[QuickUnionRankPathSpliting alloc] initWithCapacity:count], count);
    testUnionFind([[QuickUnionRankPathHalving alloc] initWithCapacity:count], count);
}


@interface Student : NSObject<NSCopying> {
    @public
    NSNumber *_age;
    NSString *_name;
}
@end
@implementation Student
- (id)copyWithZone:(nullable NSZone *)zone {
    Student *s = [[self.class allocWithZone:zone] init];
    s->_age = _age;
    s->_name = [_name copy];
    return s;
}
- (NSUInteger)hash {
    NSUInteger hashCode = [_age hash];
    hashCode = hashCode * 31 + (_name.length ? [_name hash] : 0);
    return hashCode;
}
- (BOOL)isEqual:(id)object {
    if (self == object) { return YES; }
    if (self.class != [object class]) { return NO; }
    
    Student *o = (Student *)object;
    if (![_age isEqualToNumber:o->_age]) {
        return NO;
    }
    if (![_name isEqualToString:o->_name]) {
        return NO;
    }
    return YES;
}

@end

void testGenericUF(void) {
    GenericUnionFind *uf = [GenericUnionFind unionFind];
    Student *s1 = [[Student alloc] init];
    s1->_age = @1;
    s1->_name = @"jack";
    Student *s2 = [[Student alloc] init];
    s2->_age = @2;
    s2->_name = @"rose";
    Student *s3 = [[Student alloc] init];
    s3->_age = @3;
    s3->_name = @"jack";
    Student *s4 = [[Student alloc] init];
    s4->_age = @4;
    s4->_name = @"rose";
    [uf makeSet:s1];
    [uf makeSet:s2];
    [uf makeSet:s3];
    [uf makeSet:s4];
    [uf unionWith:s1 v2:s2];
    [uf unionWith:s3 v2:s4];
    assert([uf isSameWith:s1 v2:s2]);
    assert([uf isSameWith:s3 v2:s4]);
    assert(![uf isSameWith:s1 v2:s3]);
    [uf unionWith:s1 v2:s4];
    assert([uf isSameWith:s2 v2:s3]);
}

void testGenericUnionFind(id<UnionFindProtocol> uf, NSInteger count) {
    CFTimeInterval begin = CFAbsoluteTimeGetCurrent();
    for (NSInteger i = 0; i < count; i++) {
        NSInteger v1 = arc4random() % count;
        NSInteger v2 = arc4random() % count;
        [uf unionWith:@(v1) v2:@(v2)];
    }
    for (NSInteger i = 0; i < count; i++) {
        NSInteger v1 = arc4random() % count;
        NSInteger v2 = arc4random() % count;
        [uf isSameWith:@(v1) v2:@(v2)];
    }
    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    NSString *time = [[NSString alloc] initWithFormat:@"time:  %fs(%f)ms", end - begin, (end - begin) * 1000.0];
    NSString *name = NSStringFromClass(uf.class);
    NSString *line = @"---------------------------------------------------------";
    NSLog(@"\n[%@]\nbegin: %f\nend:   %f\n%@\n%@", name, begin, end, time, line);
}

void testGUF(void) {
    NSInteger count = 10000;
    testGenericUnionFind([[QuickUnionRank alloc] initWithCapacity:count], count);
    testGenericUnionFind([[QuickUnionRankPathCompression alloc] initWithCapacity:count], count);
    testGenericUnionFind([[QuickUnionRankPathSpliting alloc] initWithCapacity:count], count);
    testGenericUnionFind([[QuickUnionRankPathHalving alloc] initWithCapacity:count], count);
    
    GenericUnionFind *guf = [GenericUnionFind unionFind];
    for (NSInteger i = 0; i < count; i++) {
        [guf makeSet:@(i)];
    }
    testGenericUnionFind(guf, count);
}


@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
@end
@implementation Person
- (instancetype)init {
    self = [super init];
    if (self) {
        NSNotificationCenter *__weak center = [NSNotificationCenter defaultCenter];
        id __block token = [center addObserverForName:@"Person" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [self test];
            [center removeObserver:token];
        }];
    }
    return self;
}
- (void)test {
    NSLog(@"%s", __func__);
}
- (void)dealloc {
    NSLog(@"%s", __func__);
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        testUF();
//        testGenericUF();
//        testGUF();
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Person" object:nil];
        
        Person *p = [[Person alloc] init];
        p.name = @"zhangsan";
//        NSArray *a = @[p];
//        NSArray *b = [a copy];
//        NSArray *c = [a mutableCopy];
//
//        Person *p2 = [c firstObject];
//        p2.name = @"lisi";
//        NSLog(@"----");
        
    }
    return 0;
}
