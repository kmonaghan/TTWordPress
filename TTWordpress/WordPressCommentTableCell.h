//
//  WordPressCommentTableCell.h
//  TTWordPress
//
//  Created by Karl Monaghan on 05/01/2011.
//  Copyright 2011 Crayons and Brown Paper. All rights reserved.
//

#import "Three20UI/TTTableViewCell.h"

@class WordPressComment;

@interface WordPressCommentTableCell : TTTableViewCell {
	WordPressComment*	_item;
	
	UILabel*			_authorLabel;
	UILabel*			_timestampLabel;
	TTStyledTextLabel*	_content;
}

@property (nonatomic, readonly, retain) UILabel*			authorLabel;
@property (nonatomic, readonly, retain) UILabel*			timestampLabel;
@property (nonatomic, readonly)			TTStyledTextLabel*	content;

@end
