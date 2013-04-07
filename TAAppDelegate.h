//
//  TAAppDelegate.h
//  Tohfa
//
//  Created by Anupam Jindal on 4/6/13.
//  Copyright (c) 2013 Tohfa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TASelectProductController;

@interface TAAppDelegate : UIResponder <UIApplicationDelegate> {
    UINavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TASelectProductController *viewController;


@end
