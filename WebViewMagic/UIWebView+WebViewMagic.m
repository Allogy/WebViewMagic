//
//  UIWebView+WebViewMagic.m
//  WebViewMagic
//
//  Created by Richard Venable on 4/15/13.
//  Copyright (c) 2013 Allogy Interactive. All rights reserved.
//

#import "UIWebView+WebViewMagic.h"

@implementation UIWebView (WebViewMagic)

- (void)setViewportSize:(CGSize)size
{
	WVMViewport *viewport = [self currentlyUsedViewport];
	viewport.width = size.width;
	viewport.useDeviceWidth = NO;
	viewport.height = size.height;
	viewport.useDeviceHeight = NO;
	[self useViewport:viewport];
}

- (void)setViewportFixedSize:(CGSize)size
{
	WVMViewport *viewport = [[WVMViewport alloc] init];
	viewport.width = size.width;
	viewport.useDeviceWidth = NO;
	viewport.height = size.height;
	viewport.useDeviceHeight = NO;
	viewport.initialScale = 1.0;
	viewport.minimumScale = 1.0;
	viewport.maximumScale = 1.0;
	viewport.userScalable = NO;
	[self useViewport:viewport];
}

- (void)useViewport:(WVMViewport *)viewport
{
	// TODO: I don't think the querySelector function will work if the viewport meta tag does not already exist
	NSString *javaScript = [NSString stringWithFormat:@"viewport = document.querySelector('meta[name=viewport]'); viewport.setAttribute('content', '%@');", viewport.viewportString];
	[self stringByEvaluatingJavaScriptFromString:javaScript];
}

- (WVMViewport *)currentlyUsedViewport
{
	WVMViewport *viewport = [[WVMViewport alloc] init];
	NSString *viewportString = [self stringByEvaluatingJavaScriptFromString:@"document.querySelector('meta[name=viewport]').getAttribute('content');"];
	viewport.viewportString = viewportString;

	return viewport;
}

- (void)setShadowImagesHidden:(BOOL)hidden
{
	// Remove the shadow images at the top and bottom of the webview when scrolling
	// Modified from http://stackoverflow.com/questions/2238914/how-to-remove-grey-shadow-on-the-top-uiwebview-when-overscroll/2323885#2323885
	[self.scrollView.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger index, BOOL *stop) {
		if ([subview isKindOfClass:[UIImageView class]])
			subview.hidden = hidden;
	}];
}

- (void)makeTransparent
{
	// NOTE: You must also add "body { background-color:transparent; }" as a CSS style rule
	// TODO - we can set the body background color by injecting javascript

	self.backgroundColor = [UIColor clearColor];
	self.opaque = NO;

	[self setShadowImagesHidden:YES];
}

@end
