//
//  TAOrderConfirmationController.m
//  Tohfa
//
//  Created by Anupam Jindal on 4/7/13.
//  Copyright (c) 2013 Tohfa. All rights reserved.
//

#import "TAOrderConfirmationController.h"
#import "TAUtilities.h"
#import "TASelectProductController.h"
#import "TACommonState.h"

@implementation TAOrderConfirmationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [TAUtilities initTitle:@"Confirmation" on:self.navigationItem];
        //[TAUtilities initBackButtonOn:self withAction:@selector(backButtonClicked)];
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton=YES;
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:backgroundImageView];
    [self.view sendSubviewToBack:backgroundImageView];
    
    [self.sendMoreGiftsButton  setBackgroundImage:[UIImage imageNamed:@"btn_add.png"]
                                   forState:UIControlStateNormal];
    
    
    [self.sendMoreGiftsButton setTitle: @"Send more Gift" forState:UIControlStateNormal];
    
    if ([TACommonState sharedObj].orderProducts) {
        int count = [[TACommonState sharedObj].orderProducts count];
        for (int i=0; i<count; i++) {
            int x;int y;
            if (i<2) {
                x = i*140;
                y=0;
            }
            else {
                x = (i-2)*140;
                y= 140;
            }
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 140, 140)];
            imageView.image = [TACommonState sharedObj].orderProducts[i];
            imageView.layer.cornerRadius = 3;
            imageView.layer.borderWidth = 1;
            imageView.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0].CGColor;
            [self.orderedProductView addSubview:imageView];
        }
    }
}

-(void) backButtonClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backToHomePage:(id)sender {
    TASelectProductController *productController = [[TASelectProductController alloc] initWithNibName:@"TASelectProductController" bundle:nil];
    [self.navigationController pushViewController:productController animated:YES];
    
}
@end
