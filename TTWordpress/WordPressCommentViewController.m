//
//  WordPressCommentViewController.m
//  TTWordPress
//
//  Created by Karl Monaghan on 05/01/2011.
//  Copyright 2011 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressCommentViewController.h"
#import "WordPressPost.h"
#import "WordPressComment.h"
#import "WordPressCommentDataSource.h"
#import "WordPressAddCommentViewController.h"

#import "GTMNSString+HTML.h"

@implementation WordPressCommentViewController
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithPost:(WordPressPost*)post {
	self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
		_post = [post retain];
		
		self.dataSource = [WordPressCommentDataSource dataSourceWithItems:post.comments];
		
		if ([_post.commentStatus isEqualToString:@"open"])
		{
			self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCompose
																									target: self
																									action: @selector(makecomment)] autorelease];
		}
	}
	return self;	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    TT_RELEASE_SAFELY(_post);
    
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)makecomment {
	[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:[NSString stringWithFormat:@"tt://blog/post/comment/%d", _post.postId]] 
											applyAnimated:YES]];
	
}
@end
