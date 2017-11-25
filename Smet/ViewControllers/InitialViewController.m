//
//  InitialViewController.m
//  Smet
//
//  Created by Vahan Grigoryan on 11/24/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import "InitialViewController.h"
#import "Profile.h"

@interface InitialViewController ()

@property (nonatomic) RLMResults *profilesArray;

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.profilesArray = [[Profile allObjects] sortedResultsUsingKeyPath:@"profileID" ascending:YES];
    if (self.profilesArray.count > 0) {
        [self performSegueWithIdentifier:@"login" sender:nil];
    } else {
        [self performSegueWithIdentifier:@"main" sender:nil];
    }
}



@end
