//
//  WPTabBarController.m
//  TTWordPress
//
//  Created by Karl Monaghan on 05/06/2011.
//  Copyright 2011 None. All rights reserved.
//

#import "WPTabBarController.h"
#import <Three20UI/UITabBarControllerAdditions.h>

@implementation WPTabBarController
- (void)viewDidLoad {
	[self setTabURLs:[NSArray arrayWithObjects:
					  @"tt://examplepostlist",
					  nil]];
}
@end
