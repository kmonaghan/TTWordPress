//
//  WordPressImageViewController.h
//  TTWordpress
//
//  Created by Karl Monaghan on 21/05/2012.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordPressImageViewController : UIViewController <TTImageViewDelegate> 
{
    TTActivityLabel *_activityView;
    TTImageView     *_imageView;
}

- (id)initWithUrl:(NSString *)url;
@end
