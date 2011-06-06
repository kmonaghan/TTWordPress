//
//  WordPressPostTableCell.m
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressPostTableCell.h"

#import "TTWordPress.h"

// UI
#import "Three20UI/UIViewAdditions.h"
#import "Three20UI/TTNavigator.h"
#import "Three20Style/UIFontAdditions.h"

// UINavigator
#import "Three20UINavigator/TTURLObject.h"
#import "Three20UINavigator/TTURLMap.h"

// Style
#import "Three20Style/TTGlobalStyle.h"
#import "Three20Style/TTDefaultStyleSheet.h"

// Core
#import "Three20Core/TTCorePreprocessorMacros.h"

#import "WordPressPost.h"

@implementation WordPressPostTableCell
@synthesize titleLabel		= _titleLabel;
@synthesize authorLabel		= _authorLabel;
@synthesize timestampLabel	= _timestampLabel;
@synthesize postThumb		= _postThumb;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
		_postThumb = [[TTImageView alloc] init];
		[self.contentView addSubview:_postThumb];
	}
	
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_titleLabel);
	TT_RELEASE_SAFELY(_authorLabel);
	TT_RELEASE_SAFELY(_timestampLabel);
	TT_RELEASE_SAFELY(_postThumb);
	
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell class public


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {
	WordPressPost* item = object;
	
	CGFloat width;
	
	BOOL hasThumb = NO;

	if ([item getThumbnailUrl])
	{
		width = 295 - 100 - (kTableCellSmallMargin * 2) - kTableCellHPadding;
		hasThumb = YES;
	}
	else
	{
		width = 295 - (kTableCellSmallMargin * 2);
	}
	
	CGSize titleLabelSize = [item.title sizeWithFont:TTSTYLEVAR(tableFont)
								   constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
									   lineBreakMode:UILineBreakModeWordWrap];
	
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
	[df setDateFormat:WP_POST_DATE_FORMAT];
	
	CGSize authorLabelSize = [[NSString stringWithFormat:@"Posted at %@ by %@", [df stringFromDate:item.postDate], item.author] sizeWithFont:TTSTYLEVAR(font)
								   constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
									   lineBreakMode:UILineBreakModeWordWrap];
	
	[df release];
	
	CGFloat textHeight = (titleLabelSize.height + authorLabelSize.height); 
	
	CGFloat contentHeight = ((textHeight > 100) || (!hasThumb)) ? textHeight : 100;
	
	return contentHeight + (kTableCellSmallMargin * 2);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)prepareForReuse {
	[super prepareForReuse];
	
	_titleLabel.text = nil;
	_authorLabel.text = nil;
	_timestampLabel.text = nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
	[super layoutSubviews];

	CGFloat left = 0;
	
	if (_postThumb.urlPath) {
		_postThumb.frame = CGRectMake(kTableCellSmallMargin, kTableCellSmallMargin, 100, 100);
		left += 100 + kTableCellSmallMargin + kTableCellHPadding;
	} else {
		_postThumb.frame = CGRectZero;
		left = kTableCellSmallMargin;
	}
	
	CGFloat width = 295 - left - kTableCellSmallMargin;
	CGFloat top = kTableCellSmallMargin;
	
	CGSize titleLabelSize = [_titleLabel.text sizeWithFont:TTSTYLEVAR(tableFont)
										 constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
											 lineBreakMode:UILineBreakModeWordWrap];
	
	_titleLabel.frame = CGRectMake(left, top, width, titleLabelSize.height);
	
	
	CGSize authorLabelSize = [_authorLabel.text sizeWithFont:TTSTYLEVAR(font)
										 constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)
											 lineBreakMode:UILineBreakModeWordWrap];
	
	_authorLabel.frame = CGRectMake(left, _titleLabel.bottom, width, authorLabelSize.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
	if (_item != object) {
		[_item release];
		_item = [object retain];
		
		WordPressPost* item = object;

		NSDateFormatter *df = [[NSDateFormatter alloc] init];
		[df setDateFormat:WP_POST_DATE_FORMAT];
		
		self.titleLabel.text = item.title;
		self.authorLabel.text = [NSString stringWithFormat:@"Posted at %@ by %@", [df stringFromDate:item.postDate], item.author];
		
		[df release];
		
		_postThumb.urlPath = [item getThumbnailUrl];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [[UILabel alloc] init];
		_titleLabel.font = TTSTYLEVAR(tableFont);
		_titleLabel.textColor = TTSTYLEVAR(textColor);
		_titleLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		_titleLabel.textAlignment = UITextAlignmentLeft;
		_titleLabel.contentMode = UIViewContentModeTop;
		_titleLabel.lineBreakMode = UILineBreakModeWordWrap;
		_titleLabel.numberOfLines = 0;
		
		[self.contentView addSubview:_titleLabel];
	}
	return _titleLabel;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UILabel*)authorLabel {
	if (!_authorLabel) {
		_authorLabel = [[UILabel alloc] init];
		_authorLabel.font = TTSTYLEVAR(font);
		_authorLabel.textColor = TTSTYLEVAR(tableSubTextColor);
		_authorLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
		_authorLabel.textAlignment = UITextAlignmentLeft;
		_authorLabel.contentMode = UIViewContentModeTop;
		_authorLabel.lineBreakMode = UILineBreakModeWordWrap;
		_authorLabel.numberOfLines = 0;
		
		[self.contentView addSubview:_authorLabel];
	}
	return _authorLabel;
}

@end
