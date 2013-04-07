//
//  TAOrderConfirmationController.m
//  Tohfa
//
//  Created by Anupam Jindal on 4/7/13.
//  Copyright (c) 2013 Tohfa. All rights reserved.
//

#import "TAOrderConfirmationController.h"
#import "TAUtilities.h"

@implementation TAOrderConfirmationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [TAUtilities initTitle:@"Confirmation" on:self.navigationItem];
        [TAUtilities initBackButtonOn:self withAction:@selector(backButtonClicked)];
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
}

@end
