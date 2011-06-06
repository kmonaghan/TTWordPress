//
//  WordPressCommentViewController.h
//  TTWordPress
//
//  Created by Karl Monaghan on 05/01/2011.
//  Copyright 2011 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressBaseTableViewController.h"

@class WordPressPost;

@interface WordPressCommentViewController : WordPressBaseTableViewController {
	WordPressPost*	_post;
}

-(id)initWithPost:(WordPressPost*)post;

@end
