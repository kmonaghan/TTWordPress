//
//  WordPressPostsModel.m
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//

#import "TTWordPress.h"

#import "WordPressPostsModel.h"
#import "WordPressPost.h"
#import "WordPressComment.h"
#import "WordPressCategory.h"

#import "GTMNSString+HTML.h"

#import <extThree20JSON/extThree20JSON.h>

@implementation WordPressPostsModel
@synthesize items = _items;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init {
	if (self = [super init]) {
		_totalResultsRetrieved = 0;
		_totalResultsOnServer = 0;
		_page = 1;
		
		_url = [NSString stringWithFormat:@"%@?json=get_recent_posts", WP_BASE_URL];
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithAuthorId:(NSInteger)authorId {
	self = [self initWithApiUrl:[NSString stringWithFormat:@"%@?json=get_author_posts&author_id=%d", WP_BASE_URL, authorId]];
    
    if (self)
    {

	}
	return self;	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithCategoryId:(NSInteger)categoryId {
	if (self = [self initWithApiUrl:[NSString stringWithFormat:@"%@?json=get_category_posts&id=%d", WP_BASE_URL, categoryId]]) {
		
	}
	return self;	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithApiUrl:(NSString *)url {
	if (self = [super init]) {
		_totalResultsRetrieved = 0;
		_totalResultsOnServer = 0;
		_page = 1;
		
		_url = [url retain];
	}
	return self;	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
	TT_RELEASE_SAFELY(_items);
	
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	NSString* fetchURL;
	
	if (more == YES) 
    {
		_page++;
		fetchURL = [NSString stringWithFormat:@"%@&page=%d", _url, _page];
	} 
    else 
    {
        _page = 1;
		TT_RELEASE_SAFELY(_items);
		_totalResultsRetrieved = 0;
		fetchURL = [_url copy];
	}
	
	if (!self.isLoading) {
		
		NSLog(@"Fetching URL: %@", fetchURL);
		
		TTURLRequest* request = [TTURLRequest
								 requestWithURL: fetchURL
								 delegate: self];
		
		request.cachePolicy = cachePolicy;
		//request.cacheExpirationAge = TT_DEFAULT_CACHE_INVALIDATION_AGE;
		request.cacheExpirationAge = 0;
		
		TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		[request send];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) processResponse:(NSDictionary*) response 
{
	NSArray* results = [response objectForKey:@"posts"];
	
	if (_items == nil)
	{
		_items = [[NSMutableArray alloc] initWithCapacity:[results count]];
	}
    
	for (NSDictionary* entry in results) 
    {
        [_items addObject:[WordPressPost initWithDetails:entry]];
         
		_totalResultsRetrieved++;
	}
	
	_totalResultsOnServer = [[response objectForKey:@"count_total"] intValue];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (int) totalResultsRetrieved {
	return _totalResultsRetrieved;
};

///////////////////////////////////////////////////////////////////////////////////////////////////
- (int) totalResultsOnServer {
	return _totalResultsOnServer;
};

@end
