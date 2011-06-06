//
//  WordPressDataSource.m
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressDataSource.h"
#import "WordPressPostModel.h"
#import "WordPressPost.h"
#import "WordPressPostTableCell.h"


@implementation WordPressDataSource
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init
{
	if (self = [super init])
	{
		_localModel = [[WordPressPostModel alloc] init];
	}
	
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithAuthorId:(NSInteger)authorId
{
	if (self = [super init])
	{
		_localModel = [[WordPressPostModel alloc] initWithAuthorId:authorId];
	}
	
	return self;
}

- (id) initWithCategoryId:(NSInteger)categoryId
{
	if (self = [super init])
	{
		_localModel = [[WordPressPostModel alloc] initWithCategoryId:categoryId];
	}
	
	return self;	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) initWithUrl:(NSString *)url
{
	if (self = [super init])
	{
		_localModel = [[WordPressPostModel alloc] initWithUrl:url];
	}
	
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_localModel);
	
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
	return _localModel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	self.items = _localModel.items;	
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object {
	if([object isKindOfClass:[WordPressPost class]])
	{
		return [WordPressPostTableCell class];
	}
	else
	{
		return [super tableView:tableView cellClassForObject:object];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	/*
	if ([_localModel totalResultsRetrieved] < [_localModel totalResultsOnServer]) {
		return [_localModel totalResultsRetrieved] + 1;
	} else {
		return [_localModel totalResultsRetrieved];
	}
	 */
	return [_localModel totalResultsRetrieved];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)tableView:(UITableView*)tableView objectForRowAtIndexPath:(NSIndexPath*)indexPath {
	if (indexPath.row < self.items.count) {
		return [self.items objectAtIndex:indexPath.row];
	/*
	} else if (indexPath.row == (self.items.count)) {
		return [TTTableMoreButton itemWithText:@"Load More..."];
	*/
	} else {
		return nil;
	}
}

@end
