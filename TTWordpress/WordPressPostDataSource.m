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

@implementation WordPressPostDataSource
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
