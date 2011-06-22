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
	}
	
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(nameField);
	TT_RELEASE_SAFELY(emailField);
	
    /*
    if (_request && _request.isLoading)
    {
        [_request cancel];
    }
    */
    
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
- (void) sendComment 
{	
    TTURLRequest* request = [TTURLRequest
							 requestWithURL:[NSString stringWithFormat:@"%@?json=respond.submit_comment", WP_BASE_URL]
							 delegate: self];
	
	request.cachePolicy = TTURLRequestCachePolicyNoCache; 
	
	request.httpMethod = @"POST";

    [request.parameters setObject:[NSString stringWithFormat:@"%d", _postId] forKey:@"post_id"];
    [request.parameters setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"name"] forKey:@"name"];
    [request.parameters setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"email"] forKey:@"email"];
    [request.parameters setObject:_textView.text forKey:@"content"];
	
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
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLJSONResponse* response = request.response;
	TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
	
	NSDictionary* feed = response.rootObject;
	
	if (([[feed objectForKey:@"status"] isEqualToString:@"pending"])
        || ([[feed objectForKey:@"status"] isEqualToString:@"ok"]))
    {
		[self dismissPopupViewControllerAnimated:YES];
	} else {
        [super showAnimationDidStop];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Submission Error" 
                                                        message:@"There was a problem submitting your comment" 
                                                       delegate:nil 
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];	
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
