//
//  WordPressPost.m
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressPost.h"
#import "WordPressCategory.h"

@implementation WordPressPost
@synthesize postId			= _postId;
@synthesize title			= _title;
@synthesize content			= _content;
@synthesize excerpt			= _excerpt;

@synthesize postDate		= _postDate;
@synthesize postUrl			= _postUrl;

@synthesize author			= _author;
@synthesize authorId		= _authorId;

@synthesize attachments		= _attachments;

@synthesize commentCount	= _commentCount;
@synthesize comments		= _comments;
@synthesize commentStatus	= _commentStatus;

@synthesize categories		= _categories;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init
{
    self = [super init];
    
	if (self)
	{
		_postId = 0;
		_authorId = 0;
		_commentCount = 0;
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
	TT_RELEASE_SAFELY(_title);
	TT_RELEASE_SAFELY(_content);
	TT_RELEASE_SAFELY(_excerpt);
	
	TT_RELEASE_SAFELY(_postDate);
	TT_RELEASE_SAFELY(_postUrl);
	
	TT_RELEASE_SAFELY(_author);
	
	TT_RELEASE_SAFELY(_attachments);
	
	TT_RELEASE_SAFELY(_comments);
	TT_RELEASE_SAFELY(_commentStatus);
	
	TT_RELEASE_SAFELY(_categories);
	
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *) getThumbnailUrl {
	if ([_attachments count])
	{
		NSDictionary* attachement = [_attachments objectAtIndex:0];
		
		NSDictionary* images = [attachement objectForKey:@"images"];
		
		if (images != nil)
		{
			return [[images objectForKey:@"thumbnail"] objectForKey:@"url"];
		}
	}
	
	return nil;
}
@end
