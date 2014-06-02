//  Copyright (c) 2014 Tabcorp. All rights reserved.

#import "TBCAlertView.h"

#import <UIKit/UIKit.h>

@interface TBCAlertView() <UIAlertViewDelegate>
@property(nonatomic, strong, readonly) UIAlertView *alertView;
@property(nonatomic, strong, readonly) NSMutableDictionary *handlers;
@property(nonatomic, strong) TBCAlertView *keepAliveWhilePresented;
@end

@implementation TBCAlertView

+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelButtonHandler:(dispatch_block_t)cancelButtonHandler {
    NSParameterAssert([cancelButtonTitle length]);
    
    TBCAlertView *alertView = [[TBCAlertView alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle cancelButtonHandler:cancelButtonHandler];
    [alertView show];
    return alertView;
}

+ (instancetype)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelButtonHandler:(dispatch_block_t)cancelButtonHandler otherButtonTitle:(NSString *)otherButtonTitle otherButtonHandler:(dispatch_block_t)otherButtonHandler {
    NSParameterAssert([otherButtonTitle length]);
    
    TBCAlertView *alertView = [[TBCAlertView alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle cancelButtonHandler:cancelButtonHandler];
    [alertView addButtonWithTitle:otherButtonTitle handler:otherButtonHandler];
    [alertView show];
    return alertView;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle cancelButtonHandler:(dispatch_block_t)cancelButtonHandler {
    self = [super init];
    if (self) {
        _alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
        _handlers = [[NSMutableDictionary alloc] init];
        if (cancelButtonTitle) {
            self.handlers[@(self.alertView.cancelButtonIndex)] = [cancelButtonHandler?:^{} copy];
        }
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message {
    return [self initWithTitle:title message:message cancelButtonTitle:nil cancelButtonHandler:nil];
}

- (NSInteger)addButtonWithTitle:(NSString *)title handler:(dispatch_block_t)handler {
    NSParameterAssert(title);

    NSInteger buttonIndex = [self.alertView addButtonWithTitle:title];
    self.handlers[@(buttonIndex)] = [handler?:^{} copy];
    
    return buttonIndex;
}

- (void)show {
    self.keepAliveWhilePresented = self;
    [self.alertView show];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)index animated:(BOOL)animated {
    [self.alertView dismissWithClickedButtonIndex:index animated:animated];
}

- (NSString *)title {
    return self.alertView.title;
}

- (void)setTitle:(NSString *)title {
    self.alertView.title = title;
}

- (NSString *)message {
    return self.alertView.message;
}

- (void)setMessage:(NSString *)message {
    self.alertView.message = message;
}

- (BOOL)visible {
    return self.alertView.isVisible;
}

#pragma mark - UIAlertViewDelegate Methods
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    dispatch_block_t handler = self.handlers[@(buttonIndex)];
    if (handler) {
        handler();
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    self.keepAliveWhilePresented = nil;
}

@end
