//
//  WordPressBlogViewController.m
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//
#import "TTWordPress.h"

#import "WordPressBlogViewController.h"
#import "WordPressDataSource.h"
#import "WordPressPostViewController.h"
#import "WordPressPost.h"

@implementation WordPressBlogViewController
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) 
    {
		self.variableHeightRows = YES;
        
		self.title = WP_POST_LIST_TITLE;

		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:WP_POST_LIST_BAR_TITLE 
                                                         image:[UIImage imageNamed:@"166-newspaper.png"] 
                                                           tag:12348] autorelease];
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithAuthorId:(NSInteger)authorId {
	self = [self initWithNibName:nil bundle:nil];
    
    if (self) {
		_authorId = authorId;
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithCategoryId:(NSInteger)categoryId {
	self = [self initWithNibName:nil bundle:nil];
    
    if (self) {
		_categoryId = categoryId;
	}
	return self;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createModel {
	if (_authorId)
	{
		self.dataSource = [[[WordPressDataSource alloc] initWithAuthorId:_authorId] autorelease];
	}
	else if (_categoryId)
	{
		self.dataSource = [[[WordPressDataSource alloc] initWithCategoryId:_categoryId] autorelease];
	}
	else 
	{
		self.dataSource = [[[WordPressDataSource alloc] init] autorelease];
	}

}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath
{
	if([object isKindOfClass:[WordPressPost class]])
	{
		WordPressPostViewController* postview = [[WordPressPostViewController alloc] initWithPost:object];
		[self.navigationController pushViewController:postview animated:YES];
		[postview release];

	}
	else 
	{
		[super didSelectObject:object atIndexPath:indexPath];
	}

}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewNetworkEnabledDelegate alloc] initWithController:self withDragRefresh:YES withInfiniteScroll:YES] autorelease];
}
@end
