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

#import <Three20UICommon/UIViewControllerAdditions.h> 

@implementation WordPressCommentViewController
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithPost:(WordPressPost*)post {
	self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
		_post = [post retain];

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
- (void)createModel {
	self.dataSource = [[[WordPressCommentDataSource alloc] initWithPost:_post] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewNetworkEnabledDelegate alloc] initWithController:self 
                                                          withDragRefresh:YES 
                                                       withInfiniteScroll:NO] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    TT_RELEASE_SAFELY(_post);
    
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)makecomment 
{
    WordPressAddCommentViewController *controller = [[[WordPressAddCommentViewController alloc] initWithPost:_post withTarget:self] autorelease];
    UIViewController *topController = [TTNavigator navigator].topViewController; 
    controller.delegate = controller; 
    topController.popupViewController = controller;
    controller.superController = topController; 
    
    [controller showInView:controller.view animated:YES]; 
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)reloadComments
{
    self.dataSource = [[[WordPressCommentDataSource alloc] initWithPost:_post] autorelease];
    [self updateView];
}
@end
