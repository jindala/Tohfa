//
//  TABillingInfoController.m
//  Tohfa
//
//  Created by Anupam Jindal on 4/6/13.
//  Copyright (c) 2013 Tohfa. All rights reserved.
//

#import "TABillingInfoController.h"
#import "TAUtilities.h"
#import "TAOrderConfirmationController.h"

@implementation TABillingInfoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [TAUtilities initTitle:@"Billing Info" on:self.navigationItem];
        
        [TAUtilities initBackButtonOn:self withAction:@selector(backButtonClicked)];
        
        UIBarButtonItem *placeOrderButton = [[UIBarButtonItem alloc] initWithCustomView:[TAUtilities createRightContinueNavButtonWithTitle:@"Place Order" For:self withAction:@selector(placeOrder)]];
        self.navigationItem.rightBarButtonItem = placeOrderButton;
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.holderNameField.text = @"Test";
    self.holderCardNumberField.text = @"123456789012";
    self.holderCardExpirationField.text = @"01/01";
    self.holderCVVField.text = @"123";
    
    self.holderStreetAddressOneField.text = @"132 Main St.";
    self.holderStreetAddressTwoField.text = @"";
    self.holderCityField.text = @"San Francisco";
    self.holderStateField.text = @"California";
    self.holderZipField.text = @"12345";
    self.holderCountryField.text = @"USA";
    
    self.holderNameField.enabled = NO;
    self.holderCardNumberField.enabled = NO;
    self.holderCardExpirationField.enabled = NO;
    self.holderCVVField.enabled = NO;
    
    self.holderStreetAddressOneField.enabled = NO;
    self.holderStreetAddressTwoField.enabled = NO;
    self.holderCityField.enabled = NO;
    self.holderStateField.enabled = NO;
    self.holderZipField.enabled = NO;
    self.holderCountryField.enabled = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:self.view.window];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowNotification:) name:UIKeyboardDidShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideNotification:) name:UIKeyboardDidHideNotification object:self.view.window];
}

-(void)placeOrder{
    [self resignFirstResponder];
    
    TAOrderConfirmationController *confirmOrder = [[TAOrderConfirmationController alloc] initWithNibName:@"TAOrderConfirmationController" bundle:nil];
    [self.navigationController pushViewController:confirmOrder animated:YES];
}

//Keyboard will show notification just to get the keyboard height since we use this height to control scrolling
-(void)keyboardWillShowNotification:(NSNotification*)inNotification
{
    NSDictionary* info = [inNotification userInfo];
    CGRect keyboardFrame = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    mKeyBoardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    mKeyBoardSize = keyboardFrame.size;
}

//when the keyboard is hidden set the content offset of the scroll view to zero origin. Animate or not depending on whether the keyboard is hiding as a result of
//popping the view controller
/*-(void)keyboardDidHideNotification:(NSNotification *)inNotification
{
	CGFloat totalHeight = 0;
	totalHeight += self.editView.frame.origin.y + self.editView.frame.size.height + 8;
	CGSize scrollViewSize = self.scrollView.contentSize;
	scrollViewSize.height = totalHeight;
	[self.scrollView setContentSize:scrollViewSize];
	[self.scrollView setContentOffset:CGPointZero animated:!mShouldNotAnimateScrollView];
    self.editing = NO;
}*/

//when the keyboard is shown increase the scroll view content size by the keyaboard height
-(void)keyboardDidShowNotification:(NSNotification *)inNotification
{
	NSValue *keyBoardBoundsValue = (NSValue *)[[inNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect keyBoardBounds;
	[keyBoardBoundsValue getValue:&keyBoardBounds];
	CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    self.editing = YES;
}


@end
