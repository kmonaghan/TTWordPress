//
//  WordPressBlogViewController.h
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//
#import "WordPressBaseTableViewController.h"

@interface WordPressBlogViewController : WordPressBaseTableViewController {
	NSInteger _authorId;
	NSInteger _categoryId;
}
- (id)initWithAuthorId:(NSInteger)authorId;
- (id)initWithCategoryId:(NSInteger)categoryId;

@end
