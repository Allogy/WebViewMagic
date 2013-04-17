//
//  WVMViewport.h
//  WebViewMagic
//
//  Created by Richard Venable on 4/15/13.
//  Copyright (c) 2013 Allogy Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const WVMViewportDeviceWidthString;
extern NSString * const WVMViewportDeviceHeightString;

extern const CGFloat WVMViewportMinimumWidth;
extern const CGFloat WVMViewportMaximumWidth;
extern const CGFloat WVMViewportDefaultWidth;

extern const CGFloat WVMViewportMinimumHeight;
extern const CGFloat WVMViewportMaximumHeight;
//extern const CGFloat WVMViewportDefaultHeight; // No such thing, calculated based off screen dimensions

extern const CGFloat WVMViewportMinimumScale;
extern const CGFloat WVMViewportMaximumScale;
extern const CGFloat WVMViewportDefaultMinimumScale;
extern const CGFloat WVMViewportDefaultMaximumScale;

/**
 A class for describing the properties of Apple's custom viewport HTML meta tag
 
 Documentation for the viewport meta tag: http://developer.apple.com/library/safari/documentation/AppleApplications/Reference/SafariHTMLRef/Articles/MetaTags.html#//apple_ref/doc/uid/TP40008193-SW6
 */
@interface WVMViewport : NSObject

@property (nonatomic, strong) NSString *viewportString;

@property (nonatomic, strong) NSString *widthString;
@property (nonatomic, strong) NSString *heightString;
@property (nonatomic, strong) NSString *initialScaleString;
@property (nonatomic, strong) NSString *minimumScaleString;
@property (nonatomic, strong) NSString *maximumScaleString;
@property (nonatomic, strong) NSString *userScalableString;

@property (nonatomic) CGFloat width;
@property (nonatomic) BOOL useDeviceWidth;

@property (nonatomic) CGFloat height;
@property (nonatomic) BOOL useDeviceHeight;

@property (nonatomic) CGFloat initialScale;
@property (nonatomic) CGFloat minimumScale;
@property (nonatomic) CGFloat maximumScale;

@property (nonatomic) BOOL userScalable;

- (void)resetToDefaults;

@end
