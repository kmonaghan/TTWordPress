//
//  WordPressAddCommentViewController.h
//  TTWordPress
//
//  Created by Karl Monaghan on 06/01/2011.
//  Copyright 2011 Crayons and Brown Paper. All rights reserved.
//

@class WordPressPost;

@interface WordPressAddCommentViewController : TTPostController <TTPostControllerDelegate, TTURLRequestDelegate, UIAlertViewDelegate, UITextFieldDelegate> {
	NSInteger           _postId;
	UITextField         *nameField;
	UITextField         *emailField;
    
	NSMutableDictionary *_postParams;
	
	TTURLRequest        *_request;
    WordPressPost       *_post;
    
    id                  _target;
}

- (id)initWithPostId:(NSInteger)postId;
- (id)initWithPost:(WordPressPost *)post withTarget:(id)target;

@end
