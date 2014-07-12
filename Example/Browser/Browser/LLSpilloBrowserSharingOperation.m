//
//  LLSpilloBrowserSharingOperation.m
//  Browser
//
//  Created by Damien DeVille on 7/12/14.
//  Copyright (c) 2014 Damien DeVille. All rights reserved.
//

#import "LLSpilloBrowserSharingOperation.h"

#import <Cocoa/Cocoa.h>

@interface LLSpilloBrowserSharingOperation ()

@property (strong, nonatomic) NSArray *sharingItems;
@property (readwrite, copy, atomic) NSNumber * (^completionProvider)(NSError **errorRef);

@end

@implementation LLSpilloBrowserSharingOperation

- (id)initWithSharingItems:(NSArray *)sharingItems
{
	self = [self init];
	if (self == nil) {
		return nil;
	}
	
	_sharingItems = sharingItems;
	
	return self;
}

- (void)main
{
	for (NSURL *itemURL in [self sharingItems]) {
		[[NSWorkspace sharedWorkspace] openURL:itemURL];
	}
	
	[self setCompletionProvider:^ NSNumber * (NSError **errorRef) {
		return @YES;
	}];
}

@end
