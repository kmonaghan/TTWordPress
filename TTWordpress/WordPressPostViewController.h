//
//  WordPressPostViewController.h
//  TTWordPress
//
//  Created by Karl Monaghan on 26/12/2010.
//  Copyright 2010 Crayons and Brown Paper. All rights reserved.
//

#import "WordPressBaseTableViewController.h"

@class WordPressPost;

@interface WordPressPostViewController : WordPressBaseTableViewController <UIWebViewDelegate> {
    TTActivityLabel *_activityView;
    
    BOOL            _postLoaded;
}

- (id)initWithPost:(WordPressPost*)post;
- (id)initWithPostId:(NSInteger)postId;
- (id)initWithApiUrl:(NSString *)url;

@end
