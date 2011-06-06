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

@implementation WordPressCommentDataSource

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
