//
//  TableCellDisclosure.m
//  TTWordPress
//
//  Created by Karl Monaghan on 07/01/2011.
//  Copyright 2011 Crayons and Brown Paper. All rights reserved.
//

#import "TableCellDisclosure.h"


@implementation TableCellDisclosure
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
	if (_item != object) {
		[super setObject:object];
		
		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}	
}
@end
