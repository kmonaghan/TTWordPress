//
//  WordPressPostModel.m
//  TTWordPress
//
//  Created by Karl Monaghan on 23/04/2012.
//  Copyright (c) 2012 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressPostModel.h"
#import "WordPressPost.h"
#import "WordPressComment.h"
#import "TTWordPress.h"

@implementation WordPressPostModel
@synthesize post = _post;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithPostId:(NSInteger)postId
{
    self = [super init];
    
	if (self) 
    {
		self.url = [NSString stringWithFormat:@"?json=get_post&post_id=%d", postId];
	}
	return self;    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithPost:(WordPressPost *)post
{
    self = [self initWithPostId:post.postId];
    
	if (self) 
    {
        _hasPost = YES;
		self.post = post;
        
        [self didFinishLoad];
	}
	return self;     
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithApiUrl:(NSString *)url
{
    self = [super init];
    
	if (self) 
    {
        _hasPost = NO;
        
		self.url = url;
	}
    
	return self;     
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc 
{
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoaded {
    if (_hasPost)
    {
        return YES;
    }
    
    return !!_loadedTime;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) processResponse:(NSDictionary*) response 
{
    NSLog(@"response: %@", response);
    
    if ([response objectForKey:@"post"])
    {
        _post = [WordPressPost initWithDetails:[response objectForKey:@"post"]];
    }
    else if ([response objectForKey:@"page"])
    {
        _post = [WordPressPost initWithDetails:[response objectForKey:@"page"]];
    }
}
@end
