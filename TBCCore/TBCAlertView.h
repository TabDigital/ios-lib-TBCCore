//  Copyright (c) 2014 Tabcorp. All rights reserved.

#import <Foundation/Foundation.h>

/**
 `TBCAlertView` provides a block-based interface to native Alert messages.
 
 On iOS this is a wrapper around `UIAlertView`.  On OS X this is a wrapper around `NSAlert`.
 */
@interface TBCAlertView : NSObject

/**
 Creates and shows an Alert with a cancel button.
 
 @param title The title for the Alert
 @param message The message for the Alert
 @param cancelButtonTitle The title for the cancel button
 @param cancelButtonHandler The block to be called when the cancel button is tapped
 */
+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelButtonHandler:(dispatch_block_t)cancelButtonHandler;

/**
 Creates and shows an Alert with a cancel button and one additional button
 
 @param title The title for the Alert
 @param message The message for the Alert
 @param cancelButtonTitle The title for the cancel button
 @param cancelButtonHandler The block to be called when the cancel button is tapped
 @param otherButtonTitle The title for the other button
 @param otherButtonHandler The block to be called when the other button is tapped
 */
+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelButtonHandler:(dispatch_block_t)cancelButtonHandler otherButtonTitle:(NSString *)otherButtonTitle otherButtonHandler:(dispatch_block_t)otherButtonHandler;

/**
 Initializes a TBCAlertView with a cancel button.
 
 @param title The title for the Alert
 @param message The message for the Alert
 @param cancelButtonTitle The title for the cancel button
 @param cancelButtonHandler The block to be called when the cancel button is tapped
 */
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelButtonHandler:(dispatch_block_t)cancelButtonHandler __attribute((objc_designated_initializer));

/**
 Initializes a TBCAlertView with no buttons
 
 @param title The title for the Alert
 @param message The message for the Alert
 */
- (id)initWithTitle:(NSString *)title message:(NSString *)message;

/**
 Adds a button to the TBCAlertView
 
 @param title The title for the button
 @param handler The block to be called when the button is tapped
 
 @return The index of the added button
 */
- (NSInteger)addButtonWithTitle:(NSString *)title handler:(dispatch_block_t)handler;

/**
 Shows the alert
 */
- (void)show;

/**
 Dismisses the alert with the given button index
 */
- (void)dismissWithClickedButtonIndex:(NSInteger)index animated:(BOOL)animated;

/**
 The title of the Alert
 */
@property(nonatomic, copy) NSString *title;

/**
 The message of the Alert
 */
@property(nonatomic, copy) NSString *message;

/**
 Indicates if the Alert is being displayed
 */
@property(nonatomic, readonly, getter=isVisible) BOOL visible;

@end
