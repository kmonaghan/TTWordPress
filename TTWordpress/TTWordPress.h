//
//  TTWordPress.h
//  TTWordPress
//
//  Created by Karl Monaghan on 20/01/2011.
//  Copyright 2011 Crayons and Brown Paper. All rights reserved.
//

#define WP_BASE_URL				@"http://ttwordpress.karlmonaghan.com/"

#define WP_POST_LIST_TITLE		@"Latest Posts"

#define WP_POST_LIST_BAR_TITLE	@"Blog"

#define WP_POST_DATE_FORMAT		@"HH:mm, MMMM d, yyyy"

#define WP_COMMENT_DATE_FORMAT	@"HH:mm, MMMM d, yyyy"

#define WP_NAVIGATION_BAR		[UIColor blackColor];
#define WP_STATUS_BAR			UIStatusBarStyleBlackOpaque;

/**
 *  If you are only displaying extracts on a post list page, set this to
 *  YES so the app knows to retrieve the full post from the site.
 */
#define WP_LOAD_POST            NO