//
//  WordPressModel.m
//  TTWordPress
//
//  Created by Karl Monaghan on 23/04/2012.
//  Copyright (c) 2012 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressModel.h"

#import <extThree20JSON/extThree20JSON.h>

@implementation WordPressModel
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
	TT_RELEASE_SAFELY(_url);
	
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more 
{
    NSLog(@"_url: %@", _url);
    
	if (!self.isLoading) 
    {
		TTURLRequest* request = [TTURLRequest
								 requestWithURL: _url
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
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) showError:(NSDictionary*) response 
{	
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
- (void)requestDidFinishLoad:(TTURLRequest*)request 
{
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
@end
