//
//  WordPressCategory.h
//  TTWordPress
//
//  Created by Karl Monaghan on 05/01/2011.
//  Copyright 2011 Crayons and Brown Paper. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WordPressCategory : NSObject {
	NSInteger		_categoryId;
	NSString*		_slug;
	NSString*		_title;
	NSString*		_description;
	NSString*		_parent;
	NSInteger		_postCount;
}

@property (nonatomic)   NSInteger		categoryId;
@property (nonatomic, copy)   NSString*		slug;
@property (nonatomic, copy)   NSString*		title;
@property (nonatomic, copy)   NSString*		description;
@property (nonatomic, copy)   NSString*		parent;
@property (nonatomic)   NSInteger		postCount;

@end
