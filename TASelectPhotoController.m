//
//  TASelectPhotoController.m
//  Tohfa
//
//  Created by Anupam Jindal on 4/6/13.
//  Copyright (c) 2013 Tohfa. All rights reserved.
//

#import "TASelectPhotoController.h"
#import "TAUtilities.h"

@implementation TASelectPhotoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [TAUtilities initTitle:@"Tohfa" on:self.navigationItem];
        
        [TAUtilities initBackButtonOn:self withAction:@selector(backButtonClicked)];
        
        /*UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithCustomView:[SPAUIUtils createRightContinueNavButtonWithTitle:@"Next" For:self withAction:@selector(doneEditing)]];*/
        //self.navigationItem.rightBarButtonItem = doneButton;
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self showPicker];
}

- (void) showPicker {
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void) selectPerson:(ABRecordRef)person {
    //[CMUserInfo sharedObj].receiver = person;
    NSLog(@"Receiver selected");
    
}


@end
