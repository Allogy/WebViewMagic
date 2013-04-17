//
//  UIWebView+WebViewMagic.h
//  WebViewMagic
//
//  Created by Richard Venable on 4/15/13.
//  Copyright (c) 2013 Allogy Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WVMViewport.h"

@interface UIWebView (WebViewMagic)

- (void)setViewportSize:(CGSize)size;
- (void)setViewportFixedSize:(CGSize)size;

- (void)useViewport:(WVMViewport *)viewport;
- (WVMViewport *)currentlyUsedViewport;

- (void)setShadowImagesHidden:(BOOL)hidden;
- (void)makeTransparent;

@end
