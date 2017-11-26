//
//  MainViewController.m
//  Smet
//
//  Created by Vahan Grigoryan on 11/26/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import "MainViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ProducerViewController.h"
#import "ProductCell.h"
#import "AllProducts.h"

@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (nonatomic) RLMResults <AllProducts *> *allProducts;

@end

@implementation MainViewController

static NSString *cellIdentifier = @"productCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allProducts = [[AllProducts allObjects] sortedResultsUsingKeyPath:@"id" ascending:YES];
    [self.collection registerClass:[ProductCell class] forCellWithReuseIdentifier: cellIdentifier];
    [self configureNavigationBar];
}

- (void)configureNavigationBar {
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    self.title = @"Folder";
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.allProducts[0].products count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    Product *product = self.allProducts[0].products[indexPath.row];
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [cell initViewImageView];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:product.productImageURLString]];
    return cell;
}

#pragma mark -UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidht = self.view.frame.size.width / 2 - 18;
    return CGSizeMake(cellWidht, cellWidht * 1.4);
}

-(void)viewDidLayoutSubviews {
    self.collection.contentInset = UIEdgeInsetsMake(12, 12, 12, 12);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Product *product = self.allProducts[0].products[indexPath.row];
    [self performSegueWithIdentifier:@"producer" sender:product];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(Product *)sender {
    if ([segue.identifier isEqualToString:@"producer"]) {
    ProducerViewController *vc = [segue destinationViewController];
    vc.product = sender;
    }
}

- (IBAction)moreButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"card" sender:nil];
}

@end
