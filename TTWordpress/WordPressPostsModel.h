//
//  WordPressPostsModel.h
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressModel.h"

@interface WordPressPostsModel : WordPressModel {
	NSMutableArray*  _items;
	
	int _page;
	int _totalResultsRetrieved;
	int _totalResultsOnServer;
}

@property (nonatomic, retain) NSMutableArray*  items;

- (int) totalResultsRetrieved;
- (int) totalResultsOnServer;

- (id) initWithApiUrl:(NSString *)url;
- (id) initWithAuthorId:(NSInteger)authorId;
- (id) initWithCategoryId:(NSInteger)categoryId;

@end

