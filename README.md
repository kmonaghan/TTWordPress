DEPRECIATED use [KMWordPress](https://github.com/kmonaghan/KMWordPress) instead
TTWordPress
===========

TTWordPress is a library I wrote to easily display a WordPress blog in an iOS app.  I originally wrote it for the Visionary.ie app (http://itunes.apple.com/ie/app/visionary-photography/id427412034?mt=8) and was then able to expand on that to create the Broadsheet.ie app (http://itunes.apple.com/ie/app/broadsheet-ie/id413093424?mt=8). Since I found it useful, I thought I'd release it into the wild and see what happens.

To provide the data from a WordPress blog is a nice machine readable format, the excellent JSON API (http://wordpress.org/extend/plugins/json-api/) plugin is used.  Obviously, it needs to be installed for the iOS to be able to retrieve anything but that's a trivial matter.  If you want users to be able to comment on posts, you need to activate the 'Respond' controller in the API settings.  On the iOS side of things, the library uses Three20 (http://three20.info/) for the consuming the JSON and displaying the information in tables.

Usage
-----

To use the library in your own app, you first need to add Three20 to your project (if you're not already using it).  Open the example TTWordPress project and copy the WordPress folder and all its contents to your project.

To point the library at your own blog, you need to edit the following line in TTWordPress.h:
```
#define WP_BASE_URL				@"http://ttwordpress.karlmonaghan.com/"
```

In this file, you can also change the default title for the latest posts view and the way dates are displayed for posts and comments.

Then in your AppDelegate, add the following includes:

```
#import "WordPressBlogViewController.h"
#import "WordPressAddCommentViewController.h"
```

Then add the following lines:
```
[map from:@"tt://examplepostlist" toSharedViewController:[WordPressBlogViewController class]];
[map from:@"tt://blog/author/(initWithAuthorId:)" toViewController:[WordPressBlogViewController class]];
[map from:@"tt://blog/category/(initWithCategoryId:)" toViewController:[WordPressBlogViewController class]];
[map from:@"tt://blog/post/comment/(initWithPostId:)" toModalViewController:[WordPressAddCommentViewController class]];
````

The first line sets the path to a view controller that will list the latest posts from your blog, the second shows the posts belong to a particular author, the third from a particular category and the fourth is the modal pop up for making a comment.  The assumption here is that the list of posts from your blog will be a tab in your app hence being a shared view controller as opposed to the other two which are created and destroyed on demand.

The final step is to call the latest post view controller from somewhere.  In the sample project, it's added to the UITabViewController.  Once you've done that, compile and run your app and you should see your blog posts.

The code is available via a Git repo at <a href="https://github.com/kmonaghan/TTWordPress">https://github.com/kmonaghan/TTWordPress</a>.

If you do use it, I'd love to hear from you: http://www.karlmonaghan.com/contact/.

The icon used is from the excellent Glyphish (http://glyphish.com/) set.
