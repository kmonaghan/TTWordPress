//
//  WordPressCommentTableCell.m
//  TTWordPress
//
//  Created by Karl Monaghan on 05/01/2011.
//  Copyright 2011 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressCommentTableCell.h"
#import "WordPressComment.h"

#import "TTWordPress.h"

// UI
#import "Three20UI/UIViewAdditions.h"
#import "Three20Style/UIFontAdditions.h"

// Style
#import "Three20Style/TTGlobalStyle.h"
#import "Three20Style/TTDefaultStyleSheet.h"

// Core
#import "Three20Core/TTCorePreprocessorMacros.h"
#import "Three20Core/NSDateAdditions.h"   

@implementation WordPressCommentTableCell

@synthesize content = _content;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		
		_content = [[TTStyledTextLabel alloc] init];
		_content.contentMode = UIViewContentModeLeft;
		[self.contentView addSubview:_content];
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_authorLabel);
	TT_RELEASE_SAFELY(_timestampLabel);
	
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell class public


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
	WordPressComment* item = object;
	
	TTStyledText* text = [TTStyledText textFromXHTML:item.content lineBreaks:YES URLs:YES];
	text.font = TTSTYLEVAR(font);
	text.width = tableView.width - (kTableCellSmallMargin * 2);
	
	CGFloat contentHeight = (kTableCellSmallMargin + kTableCellVPadding) + TTSTYLEVAR(tableFont).ttLineHeight + text.height;
	
//	NSLog(@"contentHeight: (%@): %f", item.name, contentHeight);
	
	return contentHeight;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)prepareForReuse {
	[super prepareForReuse];

	_authorLabel.text = nil;
	_timestampLabel.text = nil;
	_content.text = nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGFloat width = self.contentView.width - (kTableCellSmallMargin * 2);
	
	_authorLabel.frame = CGRectMake(kTableCellSmallMargin, kTableCellVPadding, width, TTSTYLEVAR(tableFont).ttLineHeight);
	
	_timestampLabel.alpha = !self.showingDeleteConfirmation;
	[_timestampLabel sizeToFit];
	_timestampLabel.left = self.contentView.width - (_timestampLabel.width + kTableCellSmallMargin);
	_timestampLabel.top = _authorLabel.top;
	_authorLabel.width -= _timestampLabel.width + (kTableCellSmallMargin*2);
	
	_content.frame = CGRectMake(kTableCellSmallMargin, _authorLabel.bottom, width, _content.text.height);
	
//	NSLog(@"self.contentView.width (%@): %f", _authorLabel.text, self.contentView.height);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
	if (_item != object) {
		[_item release];
		_item = [object retain];
		
		WordPressComment* item = object;
		
		NSDateFormatter *df = [[NSDateFormatter alloc] init];
		[df setDateFormat:WP_COMMENT_DATE_FORMAT];
		
		self.authorLabel.text = item.name;
		self.timestampLabel.text = [df stringFromDate:item.commentDate] ;
		
		[df release];
		_content.text = [TTStyledText textFromXHTML:item.content lineBreaks:YES URLs:YES];
		_content.text.font = TTSTYLEVAR(font);
		_content.text.width = self.contentView.width - (kTableCellMargin * 2);
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)authorLabel {
	if (!_authorLabel) {
		_authorLabel = [[UILabel alloc] init];
		_authorLabel.textColor = [UIColor blackColor];
		_authorLabel.highlightedTextColor = [UIColor whiteColor];
		_authorLabel.font = TTSTYLEVAR(tableFont);
		_authorLabel.contentMode = UIViewContentModeLeft;
		[self.contentView addSubview:_authorLabel];
	}
	return _authorLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)timestampLabel {
	if (!_timestampLabel) {
		_timestampLabel = [[UILabel alloc] init];
		_timestampLabel.font = TTSTYLEVAR(tableTimestampFont);
		_timestampLabel.textColor = TTSTYLEVAR(timestampTextColor);
		_timestampLabel.highlightedTextColor = [UIColor whiteColor];
		_timestampLabel.contentMode = UIViewContentModeLeft;
		[self.contentView addSubview:_timestampLabel];
	}
	return _timestampLabel;
}

@end
