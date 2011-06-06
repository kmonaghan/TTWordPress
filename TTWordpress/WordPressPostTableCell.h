//
//  WordPressPostTableCell.h
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//

// UI
#import "Three20UI/TTTableViewCell.h"

@class WordPressPost;

@interface WordPressPostTableCell : TTTableViewCell {
	WordPressPost* _item;
	
	UILabel* _titleLabel;
	UILabel* _authorLabel;
	UILabel* _timestampLabel;
	
	TTImageView* _postThumb;
}

@property (nonatomic, readonly) UILabel* titleLabel;
@property (nonatomic, readonly) UILabel* authorLabel;
@property (nonatomic, readonly) UILabel* timestampLabel;

@property (nonatomic, readonly, retain) TTImageView* postThumb;

@end
