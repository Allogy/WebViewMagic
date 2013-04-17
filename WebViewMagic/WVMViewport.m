//
//  WVMViewport.m
//  WebViewMagic
//
//  Created by Richard Venable on 4/15/13.
//  Copyright (c) 2013 Allogy Interactive. All rights reserved.
//

#import "WVMViewport.h"

NSString * const WVMViewportDeviceWidthString = @"device-width";
NSString * const WVMViewportDeviceHeightString = @"device-height";

const CGFloat WVMViewportMinimumWidth = 200.0;
const CGFloat WVMViewportMaximumWidth = 10000.0;
const CGFloat WVMViewportDefaultWidth = 980.0;

const CGFloat WVMViewportMinimumHeight = 223.0;
const CGFloat WVMViewportMaximumHeight = 10000.0;
//const CGFloat WVMViewportDefaultHeight; // No such thing, calculated based off screen dimensions

const CGFloat WVMViewportMinimumScale = 0.0;
const CGFloat WVMViewportMaximumScale = 10.0;
const CGFloat WVMViewportDefaultMinimumScale = 0.25;
const CGFloat WVMViewportDefaultMaximumScale = 5.0;

@implementation WVMViewport

- (id)init
{
	self = [super init];
	if (self) {
		[self resetToDefaults];
	}
	return self;
}


- (NSString *)description
{
	return [NSString stringWithFormat:@"%@ <meta name='viewport' content='%@'>", [super description], self.viewportString];
}

- (void)resetToDefaults
{
	self.width = WVMViewportDefaultWidth;
	self.height = 0.0;
	self.useDeviceWidth = NO;
	self.useDeviceHeight = NO;
	self.initialScale = 0.0;
	self.minimumScale = WVMViewportDefaultMinimumScale;
	self.maximumScale = WVMViewportDefaultMaximumScale;
	self.userScalable = YES;
}

- (NSString *)viewportString
{
	return [NSString stringWithFormat:@"width = %@, height = %@, initial-scale = %@, maximum-scale = %@, minimum-scale = %@, user-scalable=%@", self.widthString, self.heightString, self.initialScaleString, self.maximumScaleString, self.minimumScaleString, self.userScalableString];
}

- (void)setViewportString:(NSString *)viewportString
{
	[self resetToDefaults];

	viewportString = [viewportString lowercaseString];
	viewportString = [viewportString stringByReplacingOccurrencesOfString:@";" withString:@","];

	NSArray *attributeValueStrings = [viewportString componentsSeparatedByString:@","];
	[attributeValueStrings enumerateObjectsUsingBlock:^(NSString *attributeValueString, NSUInteger index, BOOL *stop) {
		NSArray *attributeValue = [attributeValueString componentsSeparatedByString:@"="];
		if (attributeValue.count == 2) {
			NSString *attribute = [attributeValue objectAtIndex:0];
			attribute = [attribute stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

			NSString *value = [attributeValue objectAtIndex:1];
			value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

			[self setString:value forAttribute:attribute];
		}

	}];
}

- (void)setString:(NSString *)string forAttribute:(NSString *)attribute
{
	NSString *keyForAttribute = [@{
								 @"width" : @"width",
								 @"height" : @"height",
								 @"initial-scale" : @"initialScale",
								 @"minimum-scale" : @"minimumScale",
								 @"maximum-scale" : @"maximumScale",
								 @"user-scalable" : @"userScalable",
								 } objectForKey:attribute];
	if (!keyForAttribute)
		return;

	keyForAttribute = [keyForAttribute stringByAppendingString:@"String"];

	[self setValue:string forKey:keyForAttribute];
}

- (NSString *)userScalableString
{
	return self.userScalable ? @"yes" : @"no";
}

- (void)setUserScalableString:(NSString *)userScalableString
{
	userScalableString = [userScalableString lowercaseString];
	self.userScalable = ![@[@"no", @"0"] containsObject:userScalableString];
}

- (NSString *)widthString
{
	if (self.useDeviceWidth)
		return @"device-width";

	NSNumberFormatter *numberFormatter = [self numberFormatter];
	NSString *numberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:self.width]];
	return numberString;
}

- (void)setWidthString:(NSString *)widthString
{
	widthString = [widthString lowercaseString];
	if ([widthString isEqualToString:@"device-width"]) {
		self.width = 0.0;
		self.useDeviceWidth = YES;
	}
	else {
		NSNumberFormatter *numberFormatter = [self numberFormatter];
		self.width = [[numberFormatter numberFromString:widthString] doubleValue];
		self.useDeviceWidth = NO;
	}
}

- (NSString *)heightString
{
	if (self.useDeviceHeight)
		return @"device-height";

	NSNumberFormatter *numberFormatter = [self numberFormatter];
	NSString *numberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:self.height]];
	return numberString;
}

- (void)setHeightString:(NSString *)heightString
{
	heightString = [heightString lowercaseString];
	if ([heightString isEqualToString:@"device-height"]) {
		self.height = 0.0;
		self.useDeviceHeight = YES;
	}
	else {
		NSNumberFormatter *numberFormatter = [self numberFormatter];
		self.height = [[numberFormatter numberFromString:heightString] doubleValue];
		self.useDeviceHeight = NO;
	}
}

- (NSString *)initialScaleString
{
	NSNumberFormatter *numberFormatter = [self numberFormatter];
	NSString *numberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:self.initialScale]];
	return numberString;
}

- (void)setInitialScaleString:(NSString *)initialScaleString
{
	NSNumberFormatter *numberFormatter = [self numberFormatter];
	self.initialScale = [[numberFormatter numberFromString:initialScaleString] doubleValue];
}

- (NSString *)minimumScaleString
{
	NSNumberFormatter *numberFormatter = [self numberFormatter];
	NSString *numberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:self.minimumScale]];
	return numberString;
}

- (void)setMinimumScaleString:(NSString *)minimumScaleString
{
	NSNumberFormatter *numberFormatter = [self numberFormatter];
	self.minimumScale = [[numberFormatter numberFromString:minimumScaleString] doubleValue];
}

- (NSString *)maximumScaleString
{
	NSNumberFormatter *numberFormatter = [self numberFormatter];
	NSString *numberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:self.maximumScale]];
	return numberString;
}

- (void)setMaximumScaleString:(NSString *)maximumScaleString
{
	NSNumberFormatter *numberFormatter = [self numberFormatter];
	self.maximumScale = [[numberFormatter numberFromString:maximumScaleString] doubleValue];
}

- (NSNumberFormatter *)numberFormatter
{
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
	return numberFormatter;
}

@end
