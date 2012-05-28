//
//  WordPressPost.m
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressPost.h"
#import "WordPressCategory.h"
#import "WordPressComment.h"

#import "GTMNSString+HTML.h"

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

+ (id)initWithDetails:(NSDictionary *)details
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    WordPressPost* wpItem = [[WordPressPost alloc] init];
    
    wpItem.postId = [[details objectForKey:@"id"] intValue];
    wpItem.title = [[details objectForKey:@"title"] gtm_stringByUnescapingFromHTML];
    wpItem.postDate = [df dateFromString:[details objectForKey:@"date"]];
    wpItem.content = [details objectForKey:@"content"];
    wpItem.excerpt = [details objectForKey:@"excerpt"];
    wpItem.postUrl = [details objectForKey:@"url"];
    wpItem.author = [[details objectForKey:@"author"] objectForKey:@"name"];
    wpItem.authorId = [[[details objectForKey:@"author"] objectForKey:@"id"] intValue];
    
    wpItem.attachments = [details objectForKey:@"attachments"];
    
    wpItem.commentCount = [[details objectForKey:@"comment_count"] intValue];
    
    if (wpItem.commentCount > 0)
    {
        wpItem.comments = [NSMutableArray arrayWithCapacity:wpItem.commentCount];
        
        for (NSDictionary* comment in [details objectForKey:@"comments"])
        {
            [wpItem.comments addObject:[[WordPressComment alloc] initWithDetails:comment]];
        }
    }
    
    wpItem.commentStatus = [details objectForKey:@"comment_status"];
    
    wpItem.categories = [NSMutableArray arrayWithCapacity:1];
    
    for (NSDictionary* category in [details objectForKey:@"categories"])
    {
        WordPressCategory* categoryItem = [[WordPressCategory alloc] init];
        
        categoryItem.categoryId = [[category objectForKey:@"id"] intValue];
        categoryItem.slug = [category objectForKey:@"slug"];
        categoryItem.title = [category objectForKey:@"title"];
        categoryItem.description = [category objectForKey:@"description"];
        categoryItem.parent = [category objectForKey:@"parent"];
        categoryItem.postCount = [[category objectForKey:@"postCount"] intValue];
        
        [wpItem.categories addObject:categoryItem];
        
        TT_RELEASE_SAFELY(categoryItem);
    }
    
    [df release];

    return wpItem;
}

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

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addComment:(NSDictionary *)details
{
    [self.comments addObject:[[WordPressComment alloc] initWithDetails:details]];
    self.commentCount++;
}

@end
