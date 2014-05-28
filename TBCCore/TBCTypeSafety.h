//  Copyright (c) 2014 Tabcorp. All rights reserved.

#import <Foundation/Foundation.h>

/**
 Ensure an object is an instance of a given class or an instance of any class that inherits from that class

 @param klass The class to test against
 @param object The object to test

 @return `object` if it is an instance of, or an instance of a class derived from `klass`, otherwise `nil`
 */
id _TBCEnsureClass(const Class klass, id<NSObject> const object);
#define TBCEnsureClass(type, object) ((type *)_TBCEnsureClass([type class], (object)))

#define DECLARE_TBCEnsure(type) static inline type *TBCEnsure##type(id<NSObject> const object) {return TBCEnsureClass(type,object);};
DECLARE_TBCEnsure(NSArray);
DECLARE_TBCEnsure(NSDictionary);
DECLARE_TBCEnsure(NSNumber);
DECLARE_TBCEnsure(NSString);
#undef DECLARE_TBCEnsure

/**
 Ensure an object is an instance of NSString or an instance of any class that inherits from NSString, and that it is not empty
 
 @param object The object to test
 
 @return `object` if it is a non-empty NSString, otherwise `nil`
 */
NSString *TBCEnsureNSStringNotEmpty(id<NSObject> const object);

/**
 Ensure an object is an instance of NSArray or an instance of any class that inherits from NSArray, and that it is not empty
 
 @param object The object to test
 
 @return `object` if it is a non-empty NSArray, otherwise `nil`
 */
NSArray *TBCEnsureNSArrayNotEmpty(id<NSObject> const object);

/**
 Ensure an object is not NSNull
 
 @param object The object to test
 
 @return `object` if it is not NSNull, otherwise `nil`
 */
id _TBCEnsureNotNSNull(id<NSObject> const object);
#define TBCEnsureNotNSNull(...) ((__typeof(__VA_ARGS__))_TBCEnsureNotNSNull((id)(__VA_ARGS__)))

/**
 Ensure an object conforms to a given protocol
 
 @param protocol The protocol to test against
 @param object The object to test
 
 @return `object` if it conforms to `protocol`, otherwise `nil`
 */
id _TBCEnsureProtocol(Protocol * const protocol, id<NSObject> const object);
#define TBCEnsureProtocol(protocolName, object) ((id<protocolName>)_TBCEnsureProtocol(@protocol(protocolName), (object)))

/**
 Assert an object is an instance of a given class or an instance of any class that inherits from that class
 
 @param klass The class to test against
 @param object The object to test
 
 @return `object` if it is an instance of, or an instance of a class derived from `klass`, otherwise asserts and returns `nil`
 */
id _TBCAssertClass(const Class klass, id<NSObject> const object);
#define TBCAssertClass(type, object) ((type *)_TBCAssertClass([type class], (object)))

/**
 Assert an object is nil, an instance of a given class or an instance of any class that inherits from that class
 
 @param klass The class to test against
 @param object The object to test
 
 @return `object` if it is nil, an instance of `klass`, or an instance of a class derived from `klass`; otherwise asserts and returns `nil`
 */
id _TBCAssertClassOrNil(const Class klass, id<NSObject> const object);
#define TBCAssertClassOrNil(type, object) ((type *)_TBCAssertClassOrNil([type class], (object)))
