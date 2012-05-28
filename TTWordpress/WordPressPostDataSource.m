//
//  WordPressPostDataSource.m
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//
#import "WordPressPostDataSource.h"
#import "TableItemDisclosure.h"
#import "TableCellDisclosure.h"
#import "WordPressPostModel.h"
#import "WordPressPost.h"
#import "WordPressCategory.h"

@implementation WordPressPostDataSource
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
- (id)initWithPostId:(NSInteger)postId
{
    self = [super init];
    
    if (self)
    {
        _localModel = [[WordPressPostModel alloc] initWithPostId:postId];
    }
    
    return self;    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithApiUrl:(NSString *)url
{
    self = [super init];
    
    if (self)
    {
        _localModel = [[WordPressPostModel alloc] initWithApiUrl:url];
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
    NSMutableArray* items = [NSMutableArray arrayWithCapacity:1];
    
    if (_localModel.post.commentCount > 0)
    {
        [items addObject:[TableItemDisclosure itemWithText:[NSString stringWithFormat:@"View comments (%d)", _localModel.post.commentCount] URL:nil]];
    }
    
    if ([_localModel.post.commentStatus isEqualToString:@"open"])
    {
        [items addObject:[TableItemDisclosure itemWithText:@"Make a comment" URL:nil]];
    }
        
    [items addObject:[TTTableTextItem itemWithText:[NSString stringWithFormat:@"More posts by %@", _localModel.post.author] 
                                               URL:[NSString stringWithFormat:@"tt://blog/author/%d", _localModel.post.authorId]]];
    
    for (WordPressCategory* category in _localModel.post.categories){
        [items addObject:[TTTableTextItem itemWithText:[NSString stringWithFormat:@"More posts in %@", category.title] 
                                                   URL:[NSString stringWithFormat:@"tt://blog/category/%d", category.categoryId]]];
    }

    self.items = items;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object {
	if([object isKindOfClass:[TableItemDisclosure class]])
	{
		return [TableCellDisclosure class];
	}
	else
	{
		return [super tableView:tableView cellClassForObject:object];
	}
}
@end
