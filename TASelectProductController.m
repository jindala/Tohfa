//
//  TASelectProductController.m
//  Tohfa
//
//  Created by Anupam Jindal on 4/6/13.
//  Copyright (c) 2013 Tohfa. All rights reserved.
//

#import "TASelectProductController.h"
#import "TAUtilities.h"
#import "ELCAlbumPickerController.h"
#import "TABillingInfoController.h"

@interface TASelectProductController ()

@property (nonatomic) ABRecordRef receiver;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableArray *thumbnailArray;
@property ( nonatomic, strong) UIImage *selectedImage;
@property (nonatomic) CGRect renderedOverlayImageFrame;


@end

@implementation TASelectProductController

@synthesize renderView = _renderView;
@synthesize photosTableView = _photosTableView;
@synthesize selectAction = _selectAction;
@synthesize selectedImage = _selectedImage;
@synthesize renderingProductImage = _renderingProductImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [TAUtilities initTitle:@"Tohfa" on:self.navigationItem];
        
        [TAUtilities initBackButtonOn:self withAction:@selector(backButtonClicked)];
    
        UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithCustomView:[TAUtilities createRightContinueNavButtonWithTitle:@"Send" For:self withAction:@selector(sendGiftOptions)]];
        self.navigationItem.rightBarButtonItem = sendButton;
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    

    self.photosTableView.separatorColor = [UIColor clearColor];
    self.photosTableView.delegate = self;
    self.photosTableView.dataSource = self;
    
    self.imgArray = [[NSMutableArray alloc] init];
    self.thumbnailArray = [[NSMutableArray alloc] init];

    self.renderingProductImage.image = [UIImage imageNamed:@"snapfish-canvas.png"];
    self.renderedOverlayImageFrame = CGRectMake(20, 20, 205, 205);
}

- (void)viewDidUnload {
    [self setRenderView:nil];
    [self setSelectAction:nil];
    [self setPhotosTableView:nil];
    [super viewDidUnload];
}
- (IBAction)takeAction:(id)sender {
    if([self.selectAction.titleLabel.text isEqualToString:@"Choose a Friend"]) {
        self.selectAction.titleLabel.text = @"Which pictures would your friend like?";
        self.navigationItem.title = @"Choose Pictures";
        [self showPicker];
    }
    else if ([self.selectAction.titleLabel.text isEqualToString:@"Which pictures would your friend like?"]) {
        self.navigationItem.title = @"Choose Upto 4 products";
        
    }
    self.selectAction.hidden = YES;
    
}

- (IBAction)canvasIconClick:(id)sender {
    self.renderingProductImage.image = [UIImage imageNamed:@"snapfish-canvas.png"];
    self.renderedOverlayImageFrame = CGRectMake(20, 20, 205, 205);
}

- (IBAction)necklaceIconClick:(id)sender {
    self.renderingProductImage.image = [UIImage imageNamed:@"snapfish-necklace.png"];
    self.renderedOverlayImageFrame = CGRectMake(80, 100, 85, 85);
}

- (IBAction)tshirtIconClick:(id)sender {
    self.renderingProductImage.image = [UIImage imageNamed:@"snapfish-t.png"];
    self.renderedOverlayImageFrame = CGRectMake(80, 70, 85, 60);
}

- (IBAction)mugIconClick:(id)sender {
    self.renderingProductImage.image = [UIImage imageNamed:@"snapfish-mug.png"];
    self.renderedOverlayImageFrame = CGRectMake(80, 67, 85, 85);
}

-(void) sendGiftOptions {
    [self email];
}


#pragma mark - device people picker

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    [self selectPerson:person];
    [self dismissViewControllerAnimated:YES completion:^{
        [self selectPhoto];
    }];
    
    return NO;
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

#pragma mark ElcImagePicker methods



- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    [self imagesPickerController:picker didFinishPickingMediaWithInfo:info];
    
    
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagesPickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)infoList {
    
    for (NSDictionary *imgInfo in infoList) {
        UIImage *img = [imgInfo objectForKey:UIImagePickerControllerOriginalImage];
        [self.imgArray addObject:img];
        [self.thumbnailArray addObject:[TAUtilities createThumbnail:img]];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.photosTableView reloadData];
}


#pragma mark Private methods

- (void) showPicker {
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void) selectPerson:(ABRecordRef)person {
    NSLog(@"Receiver selected");
    self.receiver = person;
}

- (void) selectPhoto {
    
    ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc] initWithNibName:@"ELCAlbumPickerController" bundle:[NSBundle mainBundle]];
	ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
    [albumController setParent:elcPicker];
	[elcPicker setDelegate:self];
    
	[self presentViewController:elcPicker animated:YES completion:nil];
}

-(void)updateProductWithPhoto {
    UIImage *baseImage = self.renderingProductImage.image;
    UIImage *overlayImage = self.selectedImage;
    CGSize finalSize = [baseImage size];
    UIGraphicsBeginImageContext(finalSize);
    [baseImage drawInRect:CGRectMake(0,0,finalSize.width,finalSize.height)];
    [overlayImage drawInRect:self.renderedOverlayImageFrame];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.renderingProductImage.image = newImage;
}

- (void) email {
    NSLog(@"emailing card");
    
    if ([MFMailComposeViewController canSendMail]) {
        NSLog(@"Mail configured");
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        [mailComposer setModalPresentationStyle:UIModalPresentationFormSheet];
        
        /*ABMutableMultiValueRef multi = ABRecordCopyValue(self.receiver, kABPersonEmailProperty);
        CFStringRef emailRef = ABMultiValueCopyValueAtIndex(multi, 0);
        NSLog(@"sending email to %@", (__bridge NSString *)emailRef);
        */
        [mailComposer setToRecipients:[NSArray arrayWithObject:@"aajkaltak@gmail.com"]];
        NSString *subjectLine = @"Anupam has sent you trivia game";
        [mailComposer setSubject:subjectLine];
        NSString *bodyText = @"Please click on the link below to play";
        
        [mailComposer setMessageBody:bodyText isHTML:NO];
        [self presentViewController:mailComposer animated:YES completion:nil];
    } else {
        NSLog(@"Mail not configured!");
        NSString *dialogText = @"Mail is not configured on your phone";
        
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Mail Error" message:dialogText delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Got it", nil];
        [alerView show];
    }
}

#pragma mark Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [self.thumbnailArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        /*cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.font = [UIFont fontWithName:@"Noteworthy" size:17.0];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor blackColor];*/
    }
    cell.imageView.image = [self.thumbnailArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.selectedImage = [self.imgArray objectAtIndex:indexPath.row];
    
    [self updateProductWithPhoto];
}

#pragma mark email  delegate


- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    if (error)
        NSLog(@"ERROR - mailComposeController: %@", [error localizedDescription]);
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        TABillingInfoController *billingInfoHandle = [[TABillingInfoController alloc] initWithNibName:@"TABillingInfoController" bundle:nil];
        [self.navigationController pushViewController:billingInfoHandle animated:YES];
    }];
    return;
}

@end
