//
//  TTWordPressScrollView.h
//  TTWordpress
//
//  Created by Karl Monaghan on 21/05/2012.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTWordPressScrollView : UIScrollView <UIScrollViewDelegate>
{
    UIImageView *imageView;
}

- (id)initWithImage:(UIImage *)image;
@end
