//
//  LoginViewController.m
//  Smet
//
//  Created by Vahan Grigoryan on 11/24/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import "LoginViewController.h"
#import "Profile.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (nonatomic) Profile *Profile;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillLayoutSubviews {
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) + 264);
    self.emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(6, 0, 0);
    self.passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(6, 0, 0);
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.emailTextField]) {
        [self.emailTextField resignFirstResponder];
        [self.passwordTextField becomeFirstResponder];
    } else {
        [self.passwordTextField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)TextField {
    [TextField resignFirstResponder];
}


#pragma mark - keyboard
- (void)keyboardDidShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat buttonButtomDistance = CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(self.loginButton.frame);
    
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

- (IBAction)loginButtonPressed:(UIButton *)sender {
    if (self.emailTextField.text.length && self.passwordTextField.text.length) {
        Profile *newProfile = [Profile new];
        newProfile.emaleString = self.emailTextField.text;
        newProfile.passwordString = self.passwordTextField.text;
        newProfile.isLogged = @"1";
        newProfile.id = 1;
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [Profile createInRealm:realm withValue:newProfile];
        [realm commitWriteTransaction];
        [self performSegueWithIdentifier:@"loginMain" sender:nil];
    }
}

@end
