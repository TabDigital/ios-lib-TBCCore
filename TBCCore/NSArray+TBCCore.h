//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

#import <TBCCore/TBCCoreTypes.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSArray<__covariant ObjectType> (TBCCore)

- (NSArray *)tbc_map:(TBCCoreGenericMapObjectToObjectBlock(ObjectType, id))block;
- (NSArray *)tbc_mapWithIndex:(TBCCoreGenericMapObjectAndIndexToObjectBlock(ObjectType, id))block;
- (NSArray *)tbc_flatMap:(TBCCoreGenericMapObjectToArrayBlock(ObjectType))block;

- (NSArray *)tbc_arrayByApplyingMap:(TBCCoreGenericMapObjectToObjectBlock(ObjectType, id))block;
- (NSArray *)tbc_arrayByApplyingMapWithIndex:(TBCCoreGenericMapObjectAndIndexToObjectBlock(ObjectType, id))block;
- (NSArray *)tbc_arrayByApplyingFlatMap:(TBCCoreGenericMapObjectToArrayBlock(ObjectType))block;
- (NSMutableArray *)tbc_mutableArrayByApplyingMap:(TBCCoreGenericMapObjectToObjectBlock(ObjectType, id))block;
- (NSMutableArray *)tbc_mutableArrayByApplyingFlatMap:(TBCCoreGenericMapObjectToArrayBlock(ObjectType))block;
- (NSSet *)tbc_setByApplyingMap:(TBCCoreGenericMapObjectToObjectBlock(ObjectType, id))block;
- (NSMutableSet *)tbc_mutableSetByApplyingMap:(TBCCoreGenericMapObjectToObjectBlock(ObjectType, id))block;
- (NSOrderedSet *)tbc_orderedSetByApplyingMap:(TBCCoreGenericMapObjectToObjectBlock(ObjectType, id))block;
- (NSMutableOrderedSet *)tbc_mutableOrderedSetByApplyingMap:(TBCCoreGenericMapObjectToObjectBlock(ObjectType, id))block;
- (NSCountedSet *)tbc_countedSetByApplyingMap:(TBCCoreGenericMapObjectToObjectBlock(ObjectType, id))block;
- (NSMutableIndexSet *)tbc_mutableIndexSetByApplyingMap:(TBCCoreGenericMapObjectToNSUIntegerBlock(ObjectType))block;

- (NSArray<ObjectType> *)tbc_filter:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;

- (NSArray<ObjectType> *)tbc_arrayByFilteringWithPredicateBlock:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;
- (NSMutableArray<ObjectType> *)tbc_mutableArrayByFilteringWithPredicateBlock:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;
- (NSSet<ObjectType> *)tbc_setByFilteringWithPredicateBlock:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;
- (NSMutableSet<ObjectType> *)tbc_mutableSetByFilteringWithPredicateBlock:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;
- (NSOrderedSet<ObjectType> *)tbc_orderedSetByFilteringWithPredicateBlock:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;
- (NSMutableOrderedSet<ObjectType> *)tbc_mutableOrderedSetByFilteringWithPredicateBlock:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;
- (NSCountedSet<ObjectType> *)tbc_countedSetByFilteringWithPredicateBlock:(TBCGenericObjectPredicateBlock(ObjectType))predicateBlock;

- (ObjectType __nullable)tbc_firstElementMatching:(TBCGenericObjectPredicateBlock(ObjectType))predicate;
- (NSUInteger)tbc_indexOfFirstElementMatching:(TBCGenericObjectPredicateBlock(ObjectType))predicate;
- (ObjectType __nullable)tbc_anyElementMatching:(TBCGenericObjectPredicateBlock(ObjectType))predicate;
- (NSUInteger)tbc_indexOfAnyElementMatching:(TBCGenericObjectPredicateBlock(ObjectType))predicate;

- (NSArray<ObjectType> *)tbc_arrayByRemovingDuplicatesWithEqualityBlock:(TBCGenericObjectObjectPredicateBlock(ObjectType))equalityBlock;

- (NSArray<ObjectType> *)tbc_split:(NSUInteger)splitSize;
- (NSArray<ObjectType> *)tbc_split:(NSUInteger)splitSize maximumNumberOfSplits:(NSUInteger)maximumNumberOfSplits;

@end

NS_ASSUME_NONNULL_END
