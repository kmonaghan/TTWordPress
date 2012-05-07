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
- (id)initWithDetails:(NSDictionary *)details
{
    self = [super init];
    
	if (self)
	{
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.commentId = [[details objectForKey:@"id"] intValue];
        self.name = [details objectForKey:@"name"];
        self.url = [details objectForKey:@"url"];
        self.commentDate = [df dateFromString:[details objectForKey:@"date"]];
        self.content = [details objectForKey:@"content"];
        self.parent = [[details objectForKey:@"parent"] intValue];
        
        [df release];
	}
	return self;    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
	TT_RELEASE_SAFELY(_name);
	TT_RELEASE_SAFELY(_url);
	TT_RELEASE_SAFELY(_commentDate);
	TT_RELEASE_SAFELY(_content);
	
	[super dealloc];
}
@end
