//
//  CardViewController.m
//  Smet
//
//  Created by Vahan Grigoryan on 11/26/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import "CardViewController.h"
#import "CardCell.h"
#import "Profile.h"

@interface CardViewController ()

@property (nonatomic) RLMResults <Profile*> *profilesArray;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation CardViewController

static NSString *cellIdentifier = @"cardCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.profilesArray = [[Profile allObjects] sortedResultsUsingKeyPath:@"profileID" ascending:YES];
    [self.collectionView registerClass:[CardCell class] forCellWithReuseIdentifier: cellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.profilesArray = [[Profile allObjects] sortedResultsUsingKeyPath:@"profileID" ascending:YES];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.profilesArray[0].cards count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    Card *currentCard = self.profilesArray[0].cards[indexPath.row];
    [cell initWithCardName:currentCard.cardName];
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.borderWidth = 1;
    cell.layer.cornerRadius = 4;
    return cell;
}

#pragma mark -UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidht = self.view.frame.size.width / 2 - 18;
    return CGSizeMake(cellWidht, cellWidht / 1.4);
}

-(void)viewDidLayoutSubviews {
    self.collectionView.contentInset = UIEdgeInsetsMake(12, 12, 12, 12);
}


- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"addCard" sender:nil];
}

@end
