//
//  TAOrderConfirmationController.h
//  Tohfa
//
//  Created by Anupam Jindal on 4/7/13.
//  Copyright (c) 2013 Tohfa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface TAOrderConfirmationController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *orderedProductView;
@property (weak, nonatomic) IBOutlet UIButton *sendMoreGiftsButton;


- (IBAction)backToHomePage:(id)sender;

@end
