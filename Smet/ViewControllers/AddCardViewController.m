//
//  AddCardViewController.m
//  Smet
//
//  Created by Vahan Grigoryan on 11/27/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import "AddCardViewController.h"
#import "Profile.h"

@interface AddCardViewController ()<UITextFieldDelegate>

@property (nonatomic) RLMResults <Profile*> *profilesArray;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *cardNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation AddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profilesArray = [[Profile allObjects] sortedResultsUsingKeyPath:@"profileID" ascending:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillLayoutSubviews {
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) + 264);
    self.cardNameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(6, 0, 0);
    self.cardNumberTextField.layer.sublayerTransform = CATransform3DMakeTranslation(6, 0, 0);
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.cardNameTextField]) {
        [self.cardNameTextField resignFirstResponder];
        [self.cardNumberTextField becomeFirstResponder];
    } else {
        [self.cardNumberTextField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)TextField {
    [TextField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([textField isEqual:self.cardNumberTextField]) {
    if (range.length + range.location > textField.text.length) {
        return NO;
    }
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 9;
    }
    return YES;
}

#pragma mark - keyboard
- (void)keyboardDidShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat buttonButtomDistance = CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(self.saveButton.frame);
    
    if (keyboardSize.height > buttonButtomDistance) {
        CGFloat keyboardButtonGap = keyboardSize.height - buttonButtomDistance;
        CGPoint scrollOffset = CGPointMake(0, keyboardButtonGap + 12);
        self.scrollView.scrollEnabled = YES;
        [self.scrollView setContentOffset:scrollOffset animated:YES];
    }
}

- (void)keyboardDidHide:(NSNotification *)notification {
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    self.scrollView.scrollEnabled = NO;
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
    if (self.cardNameTextField.text.length && self.cardNumberTextField.text.length) {
        Profile *newProfile = [Profile new];
        for (Card *card in self.profilesArray[0].cards) {
            [newProfile.cards addObject:card];
        }
        Card *newCard = [Card new];
        newCard.cardName = self.cardNameTextField.text;
        newCard.cardNumber = self.cardNumberTextField.text;
        newCard.id = newProfile.cards.count;
        [newProfile.cards addObject:newCard];
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [Profile createOrUpdateInRealm:realm withValue:@{@"id": @1, @"cards" : newProfile.cards}];
        [realm commitWriteTransaction];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
