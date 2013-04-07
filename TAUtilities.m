//
//  TAUtilities.m
//  Tohfa
//
//  Created by Anupam Jindal on 4/6/13.
//  Copyright (c) 2013 Tohfa. All rights reserved.
//

#import "TAUtilities.h"

@implementation TAUtilities

#define PHONE_THUMBNAIL_IMAGE_SIZE 60

+ (void)initTitle:(NSString *)title on:(UINavigationItem *)navigationItem
{
    UILabel *titleView = (UILabel *)navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor  clearColor];
        titleView.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
        
        titleView.textColor = [[UIColor alloc] initWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.f];
        titleView.shadowColor = [[UIColor alloc] initWithRed:50/255.f green:93/255.f blue:115/255.f alpha:1.f];
        
        
        navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

+ (void)initBackButtonOn:(UIViewController *)viewController withAction:(SEL)action
{
    [TAUtilities initBackButtonOn:viewController withAction:action AndparentController:nil];
}

+ (void)initBackButtonOn:(UIViewController *)viewController withAction:(SEL)action AndparentController:(UIViewController *)parent
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backButtonOffImage;
    
    backButtonOffImage = [UIImage imageNamed:@"back_off"];
    [backButton setImage:backButtonOffImage forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"back_on"] forState:UIControlStateHighlighted];
    backButton.frame = CGRectMake(0.0, 0.0, backButtonOffImage.size.width, backButtonOffImage.size.height);
    if(parent)
    {
        [backButton addTarget:parent action:action forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        [backButton addTarget:viewController action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [viewController.navigationItem setLeftBarButtonItem:backButtonItem animated:YES];
}

+ (UIImage *) createThumbnail:(UIImage *)origImage
{
    UIImage *thumbnailImage = [[UIImage alloc] init];
    CGSize thumbnailSize = [self getThumbnailSize:origImage];
    CGImageRef imageRef = origImage.CGImage;
    
    // create context, keeping original image properties
	CGColorSpaceRef colorspace = CGColorSpaceRetain(CGImageGetColorSpace(imageRef));
	CGContextRef context = CGBitmapContextCreate(NULL, thumbnailSize.width,thumbnailSize.height,
												 CGImageGetBitsPerComponent(imageRef),
												 CGImageGetBytesPerRow(imageRef),
												 colorspace,
												 CGImageGetAlphaInfo(imageRef));
	CGColorSpaceRelease(colorspace);
	
	if(context != NULL) {
        // draw image to context (resizing it)
        CGContextDrawImage(context, CGRectMake(0, 0, thumbnailSize.width,thumbnailSize.height), imageRef);
        // extract resulting image from context
        CGImageRef imgRef = CGBitmapContextCreateImage(context);
        CGContextRelease(context);
        
        thumbnailImage = [UIImage imageWithCGImage:imgRef];
        NSLog(@"thumbnail image width %f image height %f ", thumbnailImage.size.width, thumbnailImage.size.height);
        CGImageRelease(imgRef);
    }
    
    return thumbnailImage;
}

/* Given a image return thumbnail size for it*/
+ (CGSize) getThumbnailSize:(UIImage *)origImage
{
    CGFloat maxValue = PHONE_THUMBNAIL_IMAGE_SIZE;
    
    CGSize thumbnailSize = CGSizeMake(maxValue, maxValue);
    
    
    CGFloat initWidth = origImage.size.width;
    CGFloat initHeight = origImage.size.height;
    NSLog(@"original image width %f image height %f ", initWidth, initHeight);
    
    // Case 1: height is more than maxValue and its portrait
    if(initHeight>initWidth && initHeight>maxValue)
    {
        thumbnailSize.height = maxValue;
        
        if(initWidth>maxValue)
            thumbnailSize.width = initWidth*maxValue/initHeight;
        else
            thumbnailSize.width = initWidth;
    }
    // Case 2: width is more than maxValue and its landscape
    else if (initWidth>initHeight && initWidth>maxValue)
    {
        thumbnailSize.width = maxValue;
        
        if(initHeight>maxValue)
        {
            thumbnailSize.height = initHeight*maxValue/initWidth;
        }
        else
        {
            thumbnailSize.height = initHeight;
        }
    }
    // Case 3: both height and widht are less than maxValue
    else if (initWidth<maxValue && initHeight<maxValue)
    {
        thumbnailSize.height = initHeight;
        thumbnailSize.width = initWidth;
    }
    return thumbnailSize;
}

+ (UIButton *) createRightContinueNavButtonWithTitle:(NSString *)title For:(UIViewController *)viewController withAction:(SEL)action
{
    UIImage *buttonOff;
    UIImage *buttonOn;
    buttonOff = [UIImage imageNamed:@"nav_blank_off"];
    buttonOn   = [UIImage imageNamed:@"nav_blank_on"];
    
    UIImage *buttonOffSizable;
    UIImage *buttonOnSizable;
    
    buttonOffSizable = [buttonOff resizableImageWithCapInsets:UIEdgeInsetsMake(4.0, 4.0, 4.0, 4.0)];
    buttonOnSizable = [buttonOn resizableImageWithCapInsets:UIEdgeInsetsMake(4.0, 4.0, 4.0, 4.0)];
    
    
    return [self _createBarButtonOnRight:YES WithTitle:title normalBackground: buttonOffSizable highlightBackground:buttonOnSizable For:viewController withAction:action];
}

+ (UIButton *) _createBarButtonOnRight:(BOOL)onRight WithTitle:(NSString *)title normalBackground:(UIImage *)normalBack highlightBackground:(UIImage *)highlightBack For:(NSObject *)viewController withAction:(SEL)action
{
    UIButton *barButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    if (onRight) {
        [barButton setFrame:CGRectMake(240, 0, 60, normalBack.size.height)];
    } else {
        [barButton setFrame:CGRectMake(10, 0, 60, normalBack.size.height)];
    }
    
    UIFont *font = [UIFont fontWithName:@"Arial-BoldMT" size:14.0f];
    CGFloat adjustedWidth = [title sizeWithFont:font].width + 20.0;
    if (adjustedWidth < 60) {
        adjustedWidth = 60;
    }
    else if (adjustedWidth > 100) {
        adjustedWidth = 90;
    }
    
    [barButton setFrame:CGRectMake(240, 12, adjustedWidth, 31)];
    [barButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 2.0, 0.0, 2.0)];
    
    [barButton setTitleColor:[[UIColor alloc] initWithRed:18/255.f green:121/255.f blue:172/255.f alpha:1.f] forState:UIControlStateNormal];
    
    [barButton setTitleColor:[[UIColor alloc] initWithRed:255/255.f green:255/255.f blue:255/255.f alpha:1.f] forState:UIControlStateHighlighted];
    
    [barButton setTitle:title forState:UIControlStateNormal];
    barButton.titleLabel.font = font;
    [barButton.titleLabel sizeToFit];
    [barButton setBackgroundImage:normalBack forState:UIControlStateNormal];
    [barButton setBackgroundImage:highlightBack forState:UIControlStateHighlighted];
    [barButton addTarget:viewController action:action forControlEvents:UIControlEventTouchDown];
    return barButton;
}

@end
