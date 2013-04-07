//
//  TABillingInfoController.h
//  Tohfa
//
//  Created by Anupam Jindal on 4/6/13.
//  Copyright (c) 2013 Tohfa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TABillingInfoController : UIViewController {
    CGSize mKeyBoardSize;
}
@property (weak, nonatomic) IBOutlet UITextField *holderNameField;
@property (weak, nonatomic) IBOutlet UITextField *holderCardNumberField;
@property (weak, nonatomic) IBOutlet UITextField *holderCardExpirationField;
@property (weak, nonatomic) IBOutlet UITextField *holderCVVField;

@property (weak, nonatomic) IBOutlet UITextField *holderStreetAddressOneField;
@property (weak, nonatomic) IBOutlet UITextField *holderStreetAddressTwoField;
@property (weak, nonatomic) IBOutlet UITextField *holderCityField;
@property (weak, nonatomic) IBOutlet UITextField *holderStateField;
@property (weak, nonatomic) IBOutlet UITextField *holderZipField;
@property (weak, nonatomic) IBOutlet UITextField *holderCountryField;
@end
