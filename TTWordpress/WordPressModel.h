//
//  WordPressModel.h
//  TTWordPress
//
//  Created by Karl Monaghan on 23/04/2012.
//  Copyright (c) 2012 Crayons and Brown Paper. All rights reserved.
//

@interface WordPressModel : TTURLRequestModel {
	NSString* _url;
}

@property(nonatomic, retain) NSString *url;
@end
