//
//  LLSpilloBrowserSharingService.m
//  Browser
//
//  Created by Damien DeVille on 7/12/14.
//  Copyright (c) 2014 Damien DeVille. All rights reserved.
//

#import "LLSpilloBrowserSharingService.h"

#import <Cocoa/Cocoa.h>

#import "LLSpilloBrowserSharingOperation.h"

#import "Browser-Constants.h"

static BOOL LLSpilloBrowserSharingServiceRetrieveDefaultBrowserInfo(NSString **nameRef, NSImage **iconRef)
{
	NSURL *defaultBrowserLocation = [[NSWorkspace sharedWorkspace] URLForApplicationToOpenURL:[NSURL URLWithString:@"http://google.com"]];
	if (defaultBrowserLocation == nil) {
		return NO;
	}
	
	NSString *defaultBrowserName = [[NSFileManager defaultManager] displayNameAtPath:[defaultBrowserLocation path]];
	if (defaultBrowserName == nil) {
		defaultBrowserName = NSLocalizedStringFromTableInBundle(@"Browser", nil, [NSBundle bundleWithIdentifier:LLSpilloBrowserSharingServiceBundleIdentifier], @"LLSpilloOpenInDefaultBrowserSharingService default browser title");
	}
	
	NSImage *defaultBrowserImage = [[NSWorkspace sharedWorkspace] iconForFile:[defaultBrowserLocation path]];
	
	if (nameRef != NULL) {
		*nameRef = defaultBrowserName;
	}
	if (iconRef != NULL) {
		*iconRef = defaultBrowserImage;
	}
	
	return YES;
}

@interface LLSpilloBrowserSharingService ()

@property (readwrite, copy, nonatomic) NSString *displayName;
@property (readwrite, copy, nonatomic) NSImage *displayImage;

@end

@implementation LLSpilloBrowserSharingService

- (id)init
{
	self = [super init];
	if (self == nil) {
		return nil;
	}
	
	NSString *title = nil;
	NSImage *image = nil;
	
	LLSpilloBrowserSharingServiceRetrieveDefaultBrowserInfo(&title, &image);
	
	_displayName = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"Open in %@", nil, [NSBundle bundleWithIdentifier:LLSpilloBrowserSharingServiceBundleIdentifier], @"LLSpilloOpenInDefaultBrowserSharingService open in browser sharing service name"), title];
	_displayImage = [image copy];
	
	return self;
}

- (NSString *)identifier
{
	return LLSpilloBrowserSharingServiceBundleIdentifier;
}

- (BOOL)isAuthenticated
{
	return YES;
}

- (NSOperation <LLSpilloSharingServiceOperation> *)createSharingOperationForItems:(NSArray *)items
{
	return [[LLSpilloBrowserSharingOperation alloc] initWithSharingItems:items];
}

@end
