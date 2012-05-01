//
//  WordPressPost.h
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//

@interface WordPressPost : NSObject <TTURLObject> {
	NSInteger		_postId;
	NSString*		_title;
	NSString*		_content;
	NSString*		_excerpt;
	
	NSDate*         _postDate;
	NSString*		_postUrl;
	
	NSString*		_author;
	NSInteger		_authorId;
	
	NSArray*		_attachments;
	
	NSInteger		_commentCount;
	NSMutableArray*	_comments;
	NSString*		_commentStatus;
	
	NSMutableArray*	_categories;
}

@property (nonatomic) NSInteger	postId;
@property (nonatomic, copy)   NSString*		title;
@property (nonatomic, copy)   NSString*		content;
@property (nonatomic, copy)   NSString*		excerpt;

@property (nonatomic, copy)   NSDate*		postDate;
@property (nonatomic, copy)   NSString*		postUrl;

@property (nonatomic, copy)   NSString*		author;
@property (nonatomic)         NSInteger     authorId;

@property (nonatomic, retain) NSArray*      attachments;

@property (nonatomic)         NSInteger		commentCount;
@property (nonatomic, retain) NSMutableArray*	comments;
@property (nonatomic, copy)   NSString*		commentStatus;

@property (nonatomic, retain) NSMutableArray*	categories;

+ (id)initWithDetails:(NSDictionary *)details;

- (NSString *) getThumbnailUrl;
@end
