//
//  main.m
//  TTWordPress
//
//  Created by Karl Monaghan on 03/06/2011.
//  Copyright 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv,  @"UIApplication", @"TTWordpressAppDelegate");
    [pool release];
    return retVal;
}
