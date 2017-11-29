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
    [[RequestManager manager] getCategoriesWithCompletion:^(id result) {
        NSLog(@"Request succeeded! :)");
    } failer:^(id result) {
        NSLog(@"Request failed! :(");
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.profilesArray = [[Profile allObjects] sortedResultsUsingKeyPath:@"profileID" ascending:YES];
    if (self.profilesArray.count > 0) {
        [self performSegueWithIdentifier:@"main" sender:nil];
    } else {
        [self performSegueWithIdentifier:@"login" sender:nil];
    }
}

@end
