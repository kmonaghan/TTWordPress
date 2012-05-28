//
//  WordPressDataSource.h
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//

@class WordPressPostsModel;


@interface WordPressDataSource : TTListDataSource {
	WordPressPostsModel* _localModel;
}

- (id) initWithApiUrl:(NSString *)url;
- (id) initWithAuthorId:(NSInteger)authorId;
- (id) initWithCategoryId:(NSInteger)categoryId;
@end
