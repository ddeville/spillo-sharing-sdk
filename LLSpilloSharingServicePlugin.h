//
//  LLSpilloSharingServicePlugin.h
//  Spillo
//
//  Created by Damien DeVille on 5/17/14.
//  Copyright (c) 2014 Damien DeVille. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol LLSpilloSharingServiceOperation <NSObject>

@property (readonly, copy, atomic) NSNumber * (^completionProvider)(NSError **errorRef);

@end

@protocol LLSpilloSharingService <NSObject>

 @required

/*!
	\brief
	The unique identifier for the sharing service.
 */
@property (readonly, copy, nonatomic) NSString *identifier;
extern NSString * const LLSpilloSharingServiceIdentifierKey;

/*!
	\brief
	The display name for the sharing service.
 */
@property (readonly, copy, nonatomic) NSString *displayName;
extern NSString * const LLSpilloSharingServiceDisplayNameKey;

/*!
	\brief
	The display image for the sharing service. It has to be 16x16.
 */
@property (readonly, copy, nonatomic) NSImage *displayImage;
extern NSString * const LLSpilloSharingServiceDisplayImageKey;

/*!
	\brief
	Returns YES if the sharing service is authenticated (or does not need authentication). NO otherwise.
 */
@property (readonly, getter = isAuthenticated, assign, nonatomic) BOOL authenticated;
extern NSString * const LLSpilloSharingServiceAuthenticatedKey;

/*!
	\brief
	Create a sharing operation for given items.
 */
- (NSOperation <LLSpilloSharingServiceOperation> *)createSharingOperationForItems:(NSArray *)items;

 @optional

/*!
	\brief
	Create a login view controller that will invoke the block on completion.
 */
- (NSViewController *)createLoginViewControllerWithCompletion:(void (^)(BOOL authenticated, NSError *authenticationError))completion;

/*!
	\brief
	Logout the sharing service.
 */
- (void)logout;

@end

extern NSString * const LLSpilloSharingServiceErrorDomain;

typedef NS_ENUM(NSInteger, LLSpilloSharingServiceErrorCode) {
	LLSpilloSharingServiceUnknownError = 0,
	
	LLSpilloSharingServiceAuthenticationError = -100,
};