//  Copyright (c) 2014 Tabcorp. All rights reserved.

#import "TBCTypeSafety.h"

id _TBCEnsureClass(const Class klass, id<NSObject> const object) {
    return [object isKindOfClass:klass] ? object : nil;
}

NSString *TBCEnsureNSStringNotEmpty(id<NSObject> const object) {
    NSString * const string = TBCEnsureNSString(object);
    return string.length ? string : nil;
}

NSArray *TBCEnsureNSArrayNotEmpty(id<NSObject> const object) {
    NSArray * const array = TBCEnsureNSArray(object);
    return array.count ? array : nil;
}

id _TBCEnsureNotNSNull(id<NSObject> const object) {
    return object != [NSNull null] ? object : nil;
}

id _TBCEnsureProtocol(Protocol * const protocol, id<NSObject> const object) {
    return [object conformsToProtocol:protocol] ? object : nil;
}

id _TBCAssertNotNil(id<NSObject> const object, char const * const expr) {
    if (object) {
        return object;
    }
    NSCAssert(false, @"Type assertion failed: %s is nil", expr);
    return object;
}

id _TBCAssertClass(const Class klass, id<NSObject> const object, char const * const expr) {
    if ([object isKindOfClass:klass]) {
        return object;
    }
    NSCAssert(false, @"Type assertion failed: %s (%@) not of type %@", expr, object, klass);
    return nil;
}

id _TBCAssertClassOrNil(const Class klass, id<NSObject> const object, char const * const expr) {
    if (object == nil || [object isKindOfClass:klass]) {
        return object;
    }
    NSCAssert(false, @"Type assertion failed: %s (%@) not of type %@ or nil", expr, object, klass);
    return nil;
}

id _TBCAssertProtocol(Protocol * const protocol, id<NSObject> const object, char const * const expr) {
    if ([object conformsToProtocol:protocol]) {
        return object;
    }

    NSCAssert(false, @"Type assertion failed: %s (%@) does not conform to %@", expr, object, protocol);
    return nil;
}

id _TBCAssertProtocolOrNil(Protocol * const protocol, id<NSObject> const object, char const * const expr) {
    if (object == nil || [object conformsToProtocol:protocol]) {
        return object;
    }

    NSCAssert(false, @"Type assertion failed: %s (%@) does not conform to %@", expr, object, protocol);
    return nil;
}
