//
//  InitialViewController.m
//  Smet
//
//  Created by Vahan Grigoryan on 11/24/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import "InitialViewController.h"
#import "Profile.h"
#import "RequestManager.h"

@interface InitialViewController ()

@property (nonatomic) RLMResults *profilesArray;

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Requesting for data
    [self requestProducts];
}

- (void)requestProducts {
    [[RequestManager manager] getCategoriesWithCompletion:^(id result) {
        NSLog(@"Request succeeded! :)");
        [self moveToNextView];
    } failer:^(NSError *error) {
        NSLog(@"Request failed! :(");
        [self showErrorDialogString:error.description];
    }];
}

- (void)moveToNextView {
    self.profilesArray = [[Profile allObjects] sortedResultsUsingKeyPath:@"profileID" ascending:YES];
    if (self.profilesArray.count > 0) {
        [self performSegueWithIdentifier:@"main" sender:nil];
    } else {
        [self performSegueWithIdentifier:@"login" sender:nil];
    }
}

- (void)showErrorDialogString:(NSString *)string {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:string preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *positiveAction = [UIAlertAction actionWithTitle:@"Reload"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               [self requestProducts];
    }];
    
    UIAlertAction *negativeAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:positiveAction];
    [alert addAction:negativeAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
