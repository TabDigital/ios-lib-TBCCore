//  Copyright (c) 2014 Tabcorp Pty. Ltd. All rights reserved.

#import <Foundation/Foundation.h>


// only implemented for iOS for now
#if __has_include(<UIKit/UIKit.h>)

#import <UIKit/UIKit.h>


/**
 `TBCActionSheet` provides a block-based interface to native Action messages.

 On iOS this is a wrapper around `UIActionSheet`.
 */
@interface TBCActionSheet : NSObject

/**
 Initializes a TBCAlertView with a title

 @param title The title for the Alert
 */
- (id)initWithTitle:(NSString *)title;

/**
 Adds a button to the TBCActionSheet

 @param title The title for the button
 @param handler The block to be called when the button is tapped

 @return The index of the added button
 */
- (NSInteger)addButtonWithTitle:(NSString *)title handler:(dispatch_block_t)handler;

/**
 Adds a button to the TBCActionSheet and registers it as the cancel button

 @param title The title for the button
 @param handler The block to be called when the button is tapped

 @return The index of the added button
 */
- (NSInteger)addCancelButtonWithTitle:(NSString *)title handler:(dispatch_block_t)handler;

/**
 Adds a button to the TBCActionSheet and registers it as the destructive button

 @param title The title for the button
 @param handler The block to be called when the button is tapped

 @return The index of the added button
 */
- (NSInteger)addDestructiveButtonWithTitle:(NSString *)title handler:(dispatch_block_t)handler;

/**
 Presents the TBCActionSheet
 */
#if !defined(TARGET_OS_TV) || TARGET_OS_TV == 0
- (void)showFromToolbar:(UIToolbar *)view;
#endif
- (void)showFromTabBar:(UITabBar *)view;
- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;
- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated;
- (void)showInView:(UIView *)view;

/**
 Dismisses the alert with the given button index
 */
- (void)dismissWithClickedButtonIndex:(NSInteger)index animated:(BOOL)animated;


/**
 The title of the ActionSheet
 */
@property(nonatomic, copy) NSString *title;

/**
 Indicates if the ActionSheet is being displayed
 */
@property(nonatomic, readonly, getter=isVisible) BOOL visible;

@end

#endif
