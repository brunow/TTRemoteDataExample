//
//  TTURLRequestAppDelegate.h
//  TTURLRequest
//
//  Created by cesar4 on 10/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTURLRequestViewController;

@interface TTURLRequestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TTURLRequestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TTURLRequestViewController *viewController;

@end

