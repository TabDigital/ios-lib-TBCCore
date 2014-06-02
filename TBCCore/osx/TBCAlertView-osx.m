//  Copyright (c) 2014 Tabcorp. All rights reserved.

#import "TBCAlertView.h"

#import <AppKit/AppKit.h>

@interface TBCAlertView()
@property(nonatomic, strong, readonly) NSAlert *alert;
@property(nonatomic, strong, readonly) NSMutableArray *handlers;
@property(nonatomic, assign) BOOL visible;
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
        _alert = [[NSAlert alloc] init];
        [_alert setMessageText:title];
        [_alert setInformativeText:message];
        _handlers = [[NSMutableArray alloc] init];
        if (cancelButtonTitle) {
            [[_alert addButtonWithTitle:cancelButtonTitle] setTag:_handlers.count];
            [_handlers addObject:[(cancelButtonHandler?:^{}) copy]];
        }
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message {
    return [self initWithTitle:title message:message cancelButtonTitle:nil cancelButtonHandler:nil];
}

- (NSInteger)addButtonWithTitle:(NSString *)title handler:(dispatch_block_t)handler {
    NSParameterAssert(title);
    
    NSInteger buttonIndex = self.handlers.count;
    [[self.alert addButtonWithTitle:title] setTag:buttonIndex];
    [self.handlers addObject:[handler?:^{} copy]];
    return buttonIndex;
}

- (void)show {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.visible = YES;
        NSInteger buttonIndex = [self.alert runModal];
        self.visible = NO;
        dispatch_block_t handler = self.handlers[buttonIndex];
        if (handler) {
            handler();
        }
    });
}

- (void)dismissWithClickedButtonIndex:(NSInteger)index animated:(BOOL)animated {
    [[self.alert window] orderOut:nil];
    if (index < 0 || (NSUInteger)index >= self.handlers.count) {
        return;
    }
    dispatch_block_t handler = self.handlers[index];
    if (handler) {
        handler();
    }
}

- (NSString *)title {
    return self.alert.messageText;
}

- (void)setTitle:(NSString *)title {
    self.alert.messageText = title;
}

- (NSString *)message {
    return self.alert.informativeText;
}

- (void)setMessage:(NSString *)message {
    self.alert.informativeText = message;
}

- (BOOL)visible {
    return self.visible;
}

@end
