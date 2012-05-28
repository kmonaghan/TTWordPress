//
//  WordPressPostDataSource.h
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//

@class WordPressPostModel;
@class WordPressPost;

@interface WordPressPostDataSource : TTListDataSource {
    WordPressPostModel *_localModel;
}

- (id)initWithPost:(WordPressPost *)post;
- (id)initWithPostId:(NSInteger)postId;
- (id)initWithApiUrl:(NSString *)url;

@end
