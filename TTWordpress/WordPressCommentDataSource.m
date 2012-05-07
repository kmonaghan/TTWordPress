//
//  WordPressCommentDataSource.m
//  TTWordPress
//
//  Created by Karl Monaghan on 05/01/2011.
//  Copyright 2011 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressCommentDataSource.h"
#import "WordPressCommentTableCell.h"
#import "WordPressComment.h"
#import "WordPressPostModel.h"
#import "WordPressPost.h"

@implementation WordPressCommentDataSource
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithPost:(WordPressPost *)post
{
    self = [super init];
    
    if (self)
    {
        _localModel = [[WordPressPostModel alloc] initWithPost:post];
    }
    
    return self;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc 
{
	TT_RELEASE_SAFELY(_localModel);
    
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
	return _localModel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView 
{	
    self.items = _localModel.post.comments;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	return [_localModel.post.comments count];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object {
	if([object isKindOfClass:[WordPressComment class]])
	{
		return [WordPressCommentTableCell class];
	}
	else
	{
		return [super tableView:tableView cellClassForObject:object];
	}
}
@end
