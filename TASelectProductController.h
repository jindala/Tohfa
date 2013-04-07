//
//  TASelectProductController.h
//  Tohfa
//
//  Created by Anupam Jindal on 4/6/13.
//  Copyright (c) 2013 Tohfa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBookUI/AddressBookUI.h>
#import "ELCImagePickerController.h"
#import <MessageUI/MessageUI.h>

@interface TASelectProductController : UIViewController <ABPeoplePickerNavigationControllerDelegate, ELCImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *renderView;
@property (weak, nonatomic) IBOutlet UIButton *selectAction;
@property (weak, nonatomic) IBOutlet UITableView *photosTableView;
@property (weak, nonatomic) IBOutlet UIImageView *renderingProductImage;



- (IBAction)takeAction:(id)sender;
- (IBAction)canvasIconClick:(id)sender;
- (IBAction)necklaceIconClick:(id)sender;
- (IBAction)tshirtIconClick:(id)sender;
- (IBAction)mugIconClick:(id)sender;

@end
