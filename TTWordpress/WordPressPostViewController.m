//
//  WordPressPostViewController.m
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//
#import "TTWordPress.h"

#import "WordPressPostViewController.h"
#import "WordPressPostDataSource.h"
#import "WordPressPostModel.h"
#import "WordPressPost.h"
#import "WordPressCommentViewController.h"
#import "WordPressCategory.h"
#import "TableItemDisclosure.h"

@implementation WordPressPostViewController
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithPost:(WordPressPost*)post {
	self = [super initWithNibName:nil bundle:nil];
    
    if (self) 
    {
        self.hidesBottomBarWhenPushed = YES;
        
        _postLoaded = YES;

        self.dataSource = [[[WordPressPostDataSource alloc] initWithPost:post] autorelease];

    }
    
	return self;	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithPostId:(NSInteger)postId
{
   	self = [super initWithNibName:nil bundle:nil];
    
    if (self) 
    {
		self.hidesBottomBarWhenPushed = YES;
        
        self.dataSource = [[[WordPressPostDataSource alloc] initWithPostId:postId] autorelease];
    }
    
	return self; 
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithApiUrl:(NSString *)url
{
   	self = [super initWithNibName:nil bundle:nil];
    
    if (self) 
    {
		self.hidesBottomBarWhenPushed = YES;
        
        self.dataSource = [[[WordPressPostDataSource alloc] initWithApiUrl:url] autorelease];
    }
    
	return self; 
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc 
{
    TT_RELEASE_SAFELY(_activityView);
    
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showActivity:(BOOL)show 
{
    if (nil == _activityView) 
    {
        _activityView = [[TTActivityLabel alloc] initWithStyle:TTActivityLabelStyleWhiteBox];
        
    }
    
    if (show) 
    {
        [self.tableView.tableHeaderView addSubview:_activityView];
        
        _activityView.text = @"Loading content";
        _activityView.frame = CGRectMake(0, 150, 320, 40);
        _activityView.hidden = NO;
    } else {
        [_activityView removeFromSuperview];
        
        _activityView.hidden = YES;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView 
{
	[super loadView];
	
}	

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didLoadModel:(BOOL)firstTime 
{
    [super didLoadModel:firstTime];

    if (firstTime || _postLoaded)
    {
        WordPressPostModel* post = (WordPressPostModel *)self.dataSource.model;
        
        _postLoaded = NO;
        
        UIView* headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 304)] autorelease];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 303, 320, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        
        [headerView addSubview:line];
        
        self.tableView.tableHeaderView = headerView;
        
        [line release];
        
        UIWebView* web = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)] autorelease];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:WP_POST_DATE_FORMAT];
        
        NSString* postHtml = [NSString stringWithFormat:@"<html><head><link href='default.css' rel='stylesheet' type='text/css' /></head><body><div id='maincontent' class='content'><div class='post'><div id='title'>%@</div><div>%@</div><div id='singlentry' class='left-justified'>%@</div></div></div></body></html>",
                              post.post.title,
                              [df stringFromDate:post.post.postDate],
                              post.post.content];
        
        [df release];
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        
        [web loadHTMLString:postHtml baseURL:baseURL];
        
        web.delegate = self;
        
        [self.tableView insertSubview:web aboveSubview:self.tableView.tableHeaderView];
        
        [self showActivity:YES];
    } 
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
	{
		[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:[[request URL] absoluteString]] applyAnimated:YES]];
		return NO;
	}
	return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)webViewDidFinishLoad:(UIWebView *)webView 
{	
    [self showActivity:NO];
	
    CGSize webViewSize = [webView sizeThatFits:CGSizeZero];

    CGFloat newHeight = (webViewSize.height > 294) ? webViewSize.height : 304;
    
	UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, newHeight)];
	headerView.opaque = NO;
    headerView.backgroundColor = [UIColor clearColor];
	[headerView setAlpha:0];
    
    webView.frame = CGRectMake(0, 0, 320, newHeight);
    
	for (id subview in webView.subviews){
		if ([[subview class] isSubclassOfClass: [UIScrollView class]])
		{
			((UIScrollView *)subview).bounces = NO;
			((UIScrollView *)subview).scrollsToTop = NO;
			((UIScrollView *)subview).scrollEnabled = NO;
		}
	}	
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, newHeight - 1, 320, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    [webView addSubview:line];
    
	self.tableView.tableHeaderView = headerView;

    [line release];
 }

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath
{
    WordPressPostModel* post = (WordPressPostModel *)self.dataSource.model;
    
	if (indexPath.row == 0)
	{
		if (post.post.commentCount > 0)
		{
			WordPressCommentViewController* commentview = [[WordPressCommentViewController alloc] initWithPost:post.post];
			[self.navigationController pushViewController:commentview animated:YES];
			[commentview release];
		}
		else 
		{
			[[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:[NSString stringWithFormat:@"tt://blog/post/comment/%d", post.post.postId]] 
													applyAnimated:YES]];			
		}

		return;
	}
    else if ([post.post.commentStatus isEqualToString:@"open"] && (indexPath.row == 1) && (post.post.commentCount > 0))
    {
        [[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:[NSString stringWithFormat:@"tt://blog/post/comment/%d", post.post.postId]] 
                                                applyAnimated:YES]]; 
    }
	else 
	{
		[super didSelectObject:object atIndexPath:indexPath];
	}
	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewNetworkEnabledDelegate alloc] initWithController:self 
                                                          withDragRefresh:YES 
                                                       withInfiniteScroll:NO] autorelease];
}
@end
