//
//  TTWordPressScrollView.m
//  TTWordpress
//
//  Created by Karl Monaghan on 21/05/2012.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "TTWordPressScrollView.h"

@implementation TTWordPressScrollView
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithImage:(UIImage *)image
{
    self = [self initWithFrame:CGRectMake(0, 0, 320, 480)];
    if (self) 
    {
        self.backgroundColor = [UIColor blackColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        self.clipsToBounds = YES;
        self.scrollEnabled = YES;
        self.bouncesZoom = YES;
        self.maximumZoomScale = 1;
        
        imageView = [[UIImageView alloc] initWithImage:image];
        
        
        if (image.size.width > image.size.height)
        {
            self.minimumZoomScale = 320 / image.size.width;
        }
        else
        {
            self.minimumZoomScale = 480 / image.size.height; 
        }
        
        [self setContentSize:CGSizeMake(image.size.width, image.size.height)];
        [self addSubview:imageView];
        self.zoomScale = self.minimumZoomScale;
    }
    return self;    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc 
{
    TT_RELEASE_SAFELY(imageView);
    
	[super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 see: http://stackoverflow.com/a/3479076/806442
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect mainframe = [[UIScreen mainScreen] applicationFrame];
    
    NSLog(@"main frame: %f %f", mainframe.size.width, mainframe.size.height);
    // center the image as it becomes smaller than the size of the screen
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = imageView.frame;

    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    else
        frameToCenter.origin.x = 0;
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height)
        frameToCenter.origin.y = (boundsSize.height - 20 - frameToCenter.size.height) / 2;
    else
        frameToCenter.origin.y = 0;
    
    imageView.frame = frameToCenter;
}

#pragma mark - UIScrollViewDelegate
///////////////////////////////////////////////////////////////////////////////////////////////////
-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView 
{
    return imageView;
}
@end
