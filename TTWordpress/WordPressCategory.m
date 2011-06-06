//
//  WordPressCategory.m
//  TTWordPress
//
//  Created by Karl Monaghan on 05/01/2011.
//  Copyright 2011 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressCategory.h"


@implementation WordPressCategory
@synthesize categoryId	= _categoryId;
@synthesize slug		= _slug;
@synthesize title		= _title;
@synthesize description	= _description;
@synthesize parent		= _parent;
@synthesize postCount	= _postCount;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
	TT_RELEASE_SAFELY(_slug);
	TT_RELEASE_SAFELY(_title);
	TT_RELEASE_SAFELY(_description);
	TT_RELEASE_SAFELY(_parent);
	
	[super dealloc];
}
@end
