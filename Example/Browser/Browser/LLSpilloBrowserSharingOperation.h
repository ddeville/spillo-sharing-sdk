//
//  LLSpilloBrowserSharingOperation.h
//  Browser
//
//  Created by Damien DeVille on 7/12/14.
//  Copyright (c) 2014 Damien DeVille. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLSpilloSharingServicePlugin.h"

@interface LLSpilloBrowserSharingOperation : NSOperation <LLSpilloSharingServiceOperation>

- (id)initWithSharingItems:(NSArray *)sharingItems;

@end
