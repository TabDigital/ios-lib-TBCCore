//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TBCCurrencyFormatter <NSObject>
- (nullable NSDecimalNumber *)numberFromString:(NSString *)string;
- (nullable NSString *)stringFromNumber:(NSNumber *)string;
- (nullable NSString *)stringForObjectValue:(id)object;
@end

extern id<TBCCurrencyFormatter> TBCCurrencyFormatterForCurrencyCode(NSString *currencyCode);
extern id<TBCCurrencyFormatter> TBCCurrencyFormatterForCurrencyCodeIntegralValues(NSString *currencyCode);
extern id<TBCCurrencyFormatter> TBCCurrencyFormatterForAustralianCurrency(void);
extern id<TBCCurrencyFormatter> TBCCurrencyFormatterForAustralianCurrencyWholeDollars(void);

NS_ASSUME_NONNULL_END
