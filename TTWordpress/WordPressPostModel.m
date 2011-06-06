//
//  WordPressPostModel.m
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//

#import "TTWordPress.h"

#import "WordPressPostModel.h"
#import "WordPressPost.h"
#import "WordPressComment.h"
#import "WordPressCategory.h"

#import "GTMNSString+HTML.h"

#import <extThree20JSON/extThree20JSON.h>

@implementation WordPressPostModel
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
- (id) initWithAuthorId:(NSString *)authorId {
	if (self = [self initWithUrl:[NSString stringWithFormat:@"%@?json=get_author_posts&author_id=%d", WP_BASE_URL, authorId]]) {

	}
	return self;	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithCategoryId:(NSString *)categoryId {
	if (self = [self initWithUrl:[NSString stringWithFormat:@"%@?json=get_category_posts&id=%d", WP_BASE_URL, categoryId]]) {
		
	}
	return self;	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithUrl:(NSString *)url {
	if (self = [super init]) {
		_totalResultsRetrieved = 0;
		_totalResultsOnServer = 0;
		_page = 1;
		
		_url = url;
	}
	return self;	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
	TT_RELEASE_SAFELY(_url);
	TT_RELEASE_SAFELY(_items);
	
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	NSString* fetchURL;
	
	if (more == YES) {
		_page++;
		fetchURL = [NSString stringWithFormat:@"%@&page=%d", _url, _page];
	} else {
		TT_RELEASE_SAFELY(_items);
		_totalResultsRetrieved = 0;
		fetchURL = [_url copy];
	}
	
	if (!self.isLoading) {
		
//		NSLog(@"Fetching URL: %@", fetchURL);
		
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
- (void) showError:(NSDictionary*) response {	
	UIAlertView *errorAlert = [[UIAlertView alloc]
							   initWithTitle: @"Error"
							   message: [response objectForKey:@"message"]
							   delegate:nil
							   cancelButtonTitle:@"OK"
							   otherButtonTitles:nil];
    [errorAlert show];
    [errorAlert release];	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) processResponse:(NSDictionary*) response {
	
	NSArray* results = [response objectForKey:@"posts"];
	
	if (_items == nil)
	{
		_items = [[NSMutableArray alloc] initWithCapacity:[results count]];
	}
	
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	
	for (NSDictionary* entry in results) {
		WordPressPost* wpItem = [[WordPressPost alloc] init];
		
		wpItem.postId = [[entry objectForKey:@"id"] intValue];
		wpItem.title = [[entry objectForKey:@"title"] gtm_stringByUnescapingFromHTML];
		wpItem.postDate = [df dateFromString:[entry objectForKey:@"date"]];
		wpItem.content = [entry objectForKey:@"content"];
		wpItem.excerpt = [entry objectForKey:@"excerpt"];
		wpItem.postUrl = [entry objectForKey:@"url"];
		wpItem.author = [[entry objectForKey:@"author"] objectForKey:@"name"];
		wpItem.authorId = [[[entry objectForKey:@"author"] objectForKey:@"id"] intValue];

		wpItem.attachments = [entry objectForKey:@"attachments"];
		
		wpItem.commentCount = [[entry objectForKey:@"comment_count"] intValue];
		
		if (wpItem.commentCount > 0)
		{
			wpItem.comments = [NSMutableArray arrayWithCapacity:wpItem.commentCount];
			
			for (NSDictionary* comment in [entry objectForKey:@"comments"])
			{
				WordPressComment* commentItem = [[WordPressComment alloc] init];

				commentItem.commentId = [[comment objectForKey:@"id"] intValue];
				commentItem.name = [comment objectForKey:@"name"];
				commentItem.url = [comment objectForKey:@"url"];
				commentItem.commentDate = [df dateFromString:[comment objectForKey:@"date"]];
				commentItem.content = [comment objectForKey:@"content"];
				commentItem.parent = [[comment objectForKey:@"parent"] intValue];
				
				[wpItem.comments addObject:commentItem];
				
				TT_RELEASE_SAFELY(commentItem);
			}
		}
		
		wpItem.commentStatus = [entry objectForKey:@"comment_status"];
		
		wpItem.categories = [NSMutableArray arrayWithCapacity:1];
		
		for (NSDictionary* category in [entry objectForKey:@"categories"])
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
		
		[_items addObject:wpItem];
		TT_RELEASE_SAFELY(wpItem);
		
		_totalResultsRetrieved++;
	}
	
	TT_RELEASE_SAFELY(df);
	
	_totalResultsOnServer = [[response objectForKey:@"count_total"] intValue];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLJSONResponse* response = request.response;
	TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
	
	NSDictionary* feed = response.rootObject;
	
	if ([[feed objectForKey:@"status"] isEqualToString:@"ok"]) 
	{
		[self processResponse:feed];
		
	} else {
		[self showError:[feed objectForKey:@"response"]];
	}
	
	[super requestDidFinishLoad:request];
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
