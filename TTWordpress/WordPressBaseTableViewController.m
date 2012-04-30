//
//  WordPressBaseTableViewController.m
//  TTWordPress
//
//  Created by Karl Monaghan on 15/09/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressBaseTableViewController.h"

#import "TTWordPress.h"

@implementation WordPressBaseTableViewController
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) 
    {
		self.navigationBarTintColor = WP_NAVIGATION_BAR;
		self.statusBarStyle = WP_STATUS_BAR;		
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewNetworkEnabledDelegate alloc] initWithController:self 
                                                          withDragRefresh:YES 
                                                       withInfiniteScroll:NO] autorelease];
}

@end
