//
//  WordPressPostModel.h
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//

@interface WordPressPostModel : TTURLRequestModel {
	NSString* _url;
	
	NSMutableArray*  _items;
	
	int _page;
	int _totalResultsRetrieved;
	int _totalResultsOnServer;
}

@property (nonatomic, copy) NSMutableArray*  items;

- (int) totalResultsRetrieved;
- (int) totalResultsOnServer;

- (id) initWithUrl:(NSString *)url;
- (id) initWithAuthorId:(NSString *)authorId;
- (id) initWithCategoryId:(NSString *)categoryId;

@end

