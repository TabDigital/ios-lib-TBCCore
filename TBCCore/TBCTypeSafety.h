//  Copyright (c) 2014 Tabcorp. All rights reserved.

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/**
 Ensure an object is an instance of a given class or an instance of any class that inherits from that class

 @param klass The class to test against
 @param object The object to test

 @return `object` if it is an instance of, or an instance of a class derived from `klass`, otherwise `nil`
 */
id __nullable _TBCEnsureClass(const Class klass, id<NSObject> const __nullable object);
#define TBCEnsureClass(type, object) ((type *)_TBCEnsureClass([type class], (object)))

#define DECLARE_TBCEnsure(type) static inline type * __nullable TBCEnsure##type(id<NSObject> const __nullable object) {return TBCEnsureClass(type,object);};
DECLARE_TBCEnsure(NSArray);
DECLARE_TBCEnsure(NSDecimalNumber);
DECLARE_TBCEnsure(NSDictionary);
DECLARE_TBCEnsure(NSNumber);
DECLARE_TBCEnsure(NSString);
#undef DECLARE_TBCEnsure

/**
 Ensure an object is an instance of NSString or an instance of any class that inherits from NSString, and that it is not empty
 
 @param object The object to test
 
 @return `object` if it is a non-empty NSString, otherwise `nil`
 */
NSString * __nullable TBCEnsureNSStringNotEmpty(id<NSObject> const __nullable object);

/**
 Ensure an object is an instance of NSArray or an instance of any class that inherits from NSArray, and that it is not empty
 
 @param object The object to test
 
 @return `object` if it is a non-empty NSArray, otherwise `nil`
 */
NSArray * __nullable TBCEnsureNSArrayNotEmpty(id<NSObject> const __nullable object);

/**
 Ensure an object is not NSNull
 
 @param object The object to test
 
 @return `object` if it is not NSNull, otherwise `nil`
 */
id __nullable _TBCEnsureNotNSNull(id<NSObject> const __nullable object);
#define TBCEnsureNotNSNull(...) ((__typeof__(__VA_ARGS__))_TBCEnsureNotNSNull((id)(__VA_ARGS__)))

/**
 Ensure an object conforms to a given protocol
 
 @param protocol The protocol to test against
 @param object The object to test
 
 @return `object` if it conforms to `protocol`, otherwise `nil`
 */
id __nullable _TBCEnsureProtocol(Protocol * const protocol, id<NSObject> const __nullable object);
#define TBCEnsureProtocol(protocolName, object) ((id<protocolName>)_TBCEnsureProtocol(@protocol(protocolName), (object)))

/**
 Assert that a variable is not nil

 @param object The object to test

 @return `object`, asserting that it is not `nil`
 */
id __nullable _TBCAssertNotNil(id<NSObject> const __nullable object, char const * const expr);
#define TBCAssertNotNil(...) ((__typeof__(__VA_ARGS__))_TBCAssertNotNil((id)(__VA_ARGS__), #__VA_ARGS__))

/**
 Assert an object is an instance of a given class or an instance of any class that inherits from that class
 
 @param klass The class to test against
 @param object The object to test
 
 @return `object` if it is an instance of, or an instance of a class derived from `klass`, otherwise asserts and returns `nil`
 */
id __nullable _TBCAssertClass(const Class klass, id<NSObject> const __nullable object, char const * const expr);
#define TBCAssertClass(type, object) ((type * __nullable)_TBCAssertClass([type class], (object), #object))

#define DECLARE_TBCAssert(type) static inline type * __nullable TBCAssert##type(id<NSObject> const __nullable object) {return TBCAssertClass(type,object);};
DECLARE_TBCAssert(NSArray);
DECLARE_TBCAssert(NSDecimalNumber);
DECLARE_TBCAssert(NSDictionary);
DECLARE_TBCAssert(NSNumber);
DECLARE_TBCAssert(NSString);
#undef DECLARE_TBCAssert

/**
 Assert an object is nil, an instance of a given class or an instance of any class that inherits from that class
 
 @param klass The class to test against
 @param object The object to test
 
 @return `object` if it is nil, an instance of `klass`, or an instance of a class derived from `klass`; otherwise asserts and returns `nil`
 */
id __nullable _TBCAssertClassOrNil(const Class klass, id<NSObject> const __nullable object, char const * const expr);
#define TBCAssertClassOrNil(type, object) ((type * __nullable)_TBCAssertClassOrNil([type class], (object), #object))

#define DECLARE_TBCAssertOrNil(type) static inline type * __nullable TBCAssert##type##OrNil(id<NSObject> const __nullable object) {return TBCAssertClassOrNil(type,object);};
DECLARE_TBCAssertOrNil(NSArray);
DECLARE_TBCAssertOrNil(NSDecimalNumber);
DECLARE_TBCAssertOrNil(NSDictionary);
DECLARE_TBCAssertOrNil(NSNumber);
DECLARE_TBCAssertOrNil(NSString);
#undef DECLARE_TBCAssertOrNil

/**
 Assert an object conforms to a given protocol

 @param protocol The protocol to test against
 @param object The object to test

 @return `object` if it conforms to `protocol`, otherwise asserts and returns `nil`
 */
id __nullable _TBCAssertProtocol(Protocol * const protocol, id<NSObject> const __nullable object, char const * const expr);
#define TBCAssertProtocol(protocolName, object) ((id<protocolName> __nullable)_TBCAssertProtocol(@protocol(protocolName), (object), #object))

/**
 Assert an object is nil or conforms to a given protocol

 @param protocol The protocol to test against
 @param object The object to test

 @return `object` if it is nil or conforms to `protocol`, otherwise asserts and returns `nil`
 */
id __nullable _TBCAssertProtocolOrNil(Protocol * const protocol, id<NSObject> const __nullable object, char const * const expr);
#define TBCAssertProtocolOrNil(protocolName, object) ((id<protocolName> __nullable)_TBCAssertProtocolOrNil(@protocol(protocolName), (object), #object))

NS_ASSUME_NONNULL_END
