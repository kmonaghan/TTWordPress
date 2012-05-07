//
//  WordPressCommentDataSource.h
//  TTWordPress
//
//  Created by Karl Monaghan on 05/01/2011.
//  Copyright 2011 Crayons and Brown Paper. All rights reserved.
//

@class WordPressPostModel;
@class WordPressPost;

@interface WordPressCommentDataSource : TTListDataSource {
    WordPressPostModel *_localModel;
}

- (id)initWithPost:(WordPressPost *)post;

@end
