//
//  WordPressComment.m
//  TTWordPress
//
//  Created by Karl Monaghan on 05/01/2011.
//  Copyright 2011 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressComment.h"


@implementation WordPressComment
@synthesize commentId	= _commentId;
@synthesize name		= _name;
@synthesize url			= _url;
@synthesize commentDate		= _commentDate;
@synthesize content		= _content;
@synthesize parent		= _parent;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
	TT_RELEASE_SAFELY(_name);
	TT_RELEASE_SAFELY(_url);
	TT_RELEASE_SAFELY(_commentDate);
	TT_RELEASE_SAFELY(_content);
	
	[super dealloc];
}
@end
