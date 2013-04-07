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
        [TAUtilities initBackButtonOn:self withAction:@selector(backButtonClicked)];
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
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

- (IBAction)backToHomePage:(id)sender {
    TASelectProductController *productController = [[TASelectProductController alloc] initWithNibName:@"TASelectProductController" bundle:nil];
    [self.navigationController pushViewController:productController animated:YES];
    
}
@end
