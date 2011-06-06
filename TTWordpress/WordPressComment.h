//
//  WordPressComment.h
//  TTWordPress
//
//  Created by Karl Monaghan on 05/01/2011.
//  Copyright 2011 Crayons and Brown Paper. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WordPressComment : NSObject {
	NSInteger		_commentId;
	NSString*		_name;
	NSString*		_url;
	NSDate*			_commentDate;
	NSString*		_content;
	NSInteger		_parent;
}

@property (nonatomic)   NSInteger		commentId;
@property (nonatomic, copy)   NSString*		name;
@property (nonatomic, copy)   NSString*		url;
@property (nonatomic, copy)   NSDate*		commentDate;
@property (nonatomic, copy)   NSString*		content;
@property (nonatomic)   NSInteger		parent;

@end
