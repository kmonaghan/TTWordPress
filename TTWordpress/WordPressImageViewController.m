//
//  WordPressImageViewController.m
//  TTWordpress
//
//  Created by Karl Monaghan on 21/05/2012.
//  Copyright (c) 2012 None. All rights reserved.
//

#import "WordPressImageViewController.h"
#import "TTWordPressScrollView.h"

@implementation WordPressImageViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithUrl:(NSString *)url
{
    self = [self initWithNibName:nil bundle:nil];
    
    if (self)
    {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        _imageView = [[TTImageView alloc] init];
        _imageView.delegate = self;
        _imageView.urlPath = url;
    }
    
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc 
{
	TT_RELEASE_SAFELY(_imageView);
    
	[super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    _activityView = [[TTActivityLabel alloc] initWithStyle:TTActivityLabelStyleWhite];
    
    _activityView.text = @"Loading image";
    _activityView.frame = CGRectMake(0, 210, 320, 40);
    _activityView.hidden = NO;
    _activityView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:_activityView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleNavBar:)];
    [self.view addGestureRecognizer:gesture];
    [gesture release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    _activityView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)toggleNavBar:(UITapGestureRecognizer *)gesture 
{
    BOOL barsHidden = self.navigationController.navigationBar.hidden;
    [self.navigationController setNavigationBarHidden:!barsHidden animated:YES];
    
    [self.view setNeedsDisplay];
}

#pragma mark - 
- (void)imageView:(TTImageView*)imageView didLoadImage:(UIImage*)image;
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [_activityView removeFromSuperview];
    
    TTWordPressScrollView *scroll = [[TTWordPressScrollView alloc] initWithImage:image];
    
    [self.view addSubview:scroll];
    
    [scroll release];    
}

- (void)imageView:(TTImageView*)imageView didFailLoadWithError:(NSError*)error
{
    
}
@end