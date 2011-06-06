//
//  WordPressAddCommentViewController.m
//  TTWordPress
//
//  Created by Karl Monaghan on 06/01/2011.
//  Copyright 2011 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressAddCommentViewController.h"
#import "WordPressPost.h"
#import "TTWordPress.h"

#import "Three20Core/NSStringAdditions.h"
#import <extThree20JSON/extThree20JSON.h>
#import <extThree20JSON/NSObject+SBJSON.h>
#import "GTMNSString+HTML.h"

@implementation WordPressAddCommentViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithPostId:(NSInteger)postId {
	self = [super initWithNibName:nil bundle:nil];
    
    if (self) 
	{
		_postId = postId;
		self.delegate = self;
        
        _postParams = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(nameField);
	TT_RELEASE_SAFELY(emailField);
	TT_RELEASE_SAFELY(_url);
	TT_RELEASE_SAFELY(_postParams);
	
    if (_request && _request.isLoading)
    {
        [_request cancel];
    }
    
    TT_RELEASE_SAFELY(_request);
    
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)post {
	if (!TTIsStringWithAnyText(_textView.text))
	{
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Submission Error" 
														message:@"You cannot post a blank message!"
													   delegate:nil 
											  cancelButtonTitle:@"Okay"
											  otherButtonTitles:nil];
		[alert show];
		[alert release];		
		
		return;
	}
	
	[super post];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) showUserDetailsDialog
{	
	UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"Name and email" 
													 message:@"\n\n\n" // IMPORTANT
													delegate:nil 
										   cancelButtonTitle:@"Cancel" 
										   otherButtonTitles:@"Enter", nil];
	
	nameField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 50.0, 260.0, 25.0)]; 
	nameField.placeholder = @"name";
	nameField.borderStyle = UITextBorderStyleRoundedRect;
	[prompt addSubview:nameField];
	
	emailField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 85.0, 260.0, 25.0)]; 
	emailField.placeholder = @"email";
	emailField.keyboardType = UIKeyboardTypeEmailAddress;
	emailField.borderStyle = UITextBorderStyleRoundedRect;
	[prompt addSubview:emailField];
	
	prompt.delegate = self;
	
	[prompt show];
    [prompt release];
	
	// set cursor and show keyboard
	[nameField becomeFirstResponder];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) sendComment {	
    _postParams = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSString stringWithFormat:@"%d", _postId], 
                                                       [[NSUserDefaults standardUserDefaults] objectForKey:@"name"],
                                                       [[NSUserDefaults standardUserDefaults] objectForKey:@"email"],
                                                       _textView.text,
                                                       nil] 
                                              forKeys:[NSArray arrayWithObjects:@"post_id", @"name", @"email", @"content", nil]];
	
	_url = [NSString stringWithFormat:@"%@?json=respond.submit_comment", WP_BASE_URL];
    
	TTURLRequest* request = [TTURLRequest
							 requestWithURL: _url
							 delegate: self];
	
	request.cachePolicy = TTURLRequestCachePolicyNoCache; 
	
	request.httpMethod = @"POST";
	
	for (NSString* param in _postParams) 
	{
		[request.parameters setObject:[_postParams objectForKey:param] forKey:param];
	}
	
	TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
	request.response = response;
	TT_RELEASE_SAFELY(response);
    
	[request send];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)postController:(TTPostController*)postController willPostText:(NSString*)text {
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"name"])
	{
		[self sendComment];
	}
	else 
	{
		[self showUserDetailsDialog];
	}

	return NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForActivity {
	return @"Sending";
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)willPostText:(NSString*)text {
	if (text.length > 0)
	{
		return YES;
	};
	
	return NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) submitResult:(NSDictionary *) response {
	[self dismissPopupViewControllerAnimated:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) submitError:(NSDictionary *) response
{
	[super showAnimationDidStop];
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Submission Error" 
													message:[response objectForKey:@"message"] 
												   delegate:nil 
										  cancelButtonTitle:@"Okay"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLJSONResponse* response = request.response;
	TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
	
	NSDictionary* feed = response.rootObject;
	
    //	NSLog(@"Returned from server: %@", feed);
	
	if ([[feed objectForKey:@"status"] intValue] == 1) {
		if ([feed objectForKey:@"response"])
		{
			[self submitResult:[feed objectForKey:@"response"]];
		}
	} else {
		if ([feed objectForKey:@"response"])
		{
			[self submitError:[feed objectForKey:@"response"]];
		}
		else
		{
			[self submitError:feed];
		}
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) {
		case 0:
			[super showAnimationDidStop];
			break;
		case 1:
			if (TTIsStringWithAnyText(emailField.text) && TTIsStringWithAnyText(nameField.text))
			{
				[[NSUserDefaults standardUserDefaults] setValue:nameField.text forKey:@"name"];
				[[NSUserDefaults standardUserDefaults] setValue:emailField.text forKey:@"email"];
			
				[[NSUserDefaults standardUserDefaults] synchronize];
			
				[self sendComment];
			}
			else 
			{
				[super showAnimationDidStop];
			}

			break;
		default:
			break;
	}
}
@end
