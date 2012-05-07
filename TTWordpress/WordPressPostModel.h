//
//  WordPressPostModel.h
//  TTWordPress
//
//  Created by Karl Monaghan on 23/04/2012.
//  Copyright (c) 2012 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressModel.h"

@class WordPressPost;

@interface WordPressPostModel : WordPressModel {
	WordPressPost *_post;
    BOOL          _hasPost;
}

@property (nonatomic, retain) WordPressPost*  post;

- (id) initWithPostId:(NSInteger)postId;
- (id) initWithPost:(WordPressPost *)post;
- (id) initWithApiUrl:(NSString *)url;
@end
