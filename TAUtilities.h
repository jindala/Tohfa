//
//  TAUtilities.h
//  Tohfa
//
//  Created by Anupam Jindal on 4/6/13.
//  Copyright (c) 2013 Tohfa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAUtilities : NSObject

+ (void)initTitle:(NSString *)title on:(UINavigationItem *)navigationItem;
+ (void)initBackButtonOn:(UIViewController *)viewController withAction:(SEL)action;
+ (void)initBackButtonOn:(UIViewController *)viewController withAction:(SEL)action AndparentController:(UIViewController *)parent;
+ (CGSize) getThumbnailSize:(UIImage *)origImage;
+ (UIImage *) createThumbnail:(UIImage *)origImage;
+ (UIButton *) _createBarButtonOnRight:(BOOL)onRight WithTitle:(NSString *)title normalBackground:(UIImage *)normalBack highlightBackground:(UIImage *)highlightBack For:(NSObject *)viewController withAction:(SEL)action;
+ (UIButton *) createRightContinueNavButtonWithTitle:(NSString *)title For:(UIViewController *)viewController withAction:(SEL)action;

@end
