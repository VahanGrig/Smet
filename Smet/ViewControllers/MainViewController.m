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
#import "Profile.h"

@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) RLMResults <AllProducts *> *allProducts;
@property (nonatomic) RLMResults <Profile*> *profilesArray;
@property (nonatomic) RLMArray *likedProducts;
@property (nonatomic) CGSize frameSize;

@end

@implementation MainViewController

static NSString *cellIdentifier = @"productCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allProducts = [[AllProducts allObjects] sortedResultsUsingKeyPath:@"id" ascending:YES];
    self.profilesArray = [[Profile allObjects] sortedResultsUsingKeyPath:@"profileID" ascending:YES];
    self.likedProducts = self.profilesArray[0].likedProducts;
    [self.collectionView registerClass:[ProductCell class] forCellWithReuseIdentifier: cellIdentifier];
    [self configureNavigationBar];
}

- (void)viewWillLayoutSubviews {
    if (!CGSizeEqualToSize(self.frameSize, self.view.frame.size)) {
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self.collectionView reloadData];
        self.frameSize = self.view.frame.size;
    }
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
    cell.productName = product.producerName;
    cell.productId = product.id;
    
    [cell setLikePressed:^BOOL(NSString *productName, NSInteger productId) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        NSInteger likedProductIndex = [self indexOfProductWithName:productName];
        if (likedProductIndex >= 0) {
        [self.likedProducts removeObjectAtIndex:likedProductIndex];
        } else {
            LikedProduct *likedProduct = [LikedProduct new];
            likedProduct.productName = productName;
            likedProduct.id = productId;
            [realm addOrUpdateObject:likedProduct];
            [self.likedProducts addObject:likedProduct];
        }
        [realm commitWriteTransaction];
        return likedProductIndex >= 0;
    }];
    cell.isLiked = [self indexOfProductWithName:product.producerName] >= 0;
    [cell initCell];
   __block UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.center = cell.imageView.center;
    [cell addSubview:activity];
    [activity startAnimating];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:product.productImageURLString] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [activity stopAnimating];
        [activity removeFromSuperview];
        activity = nil;
        cell.imageView.image = image;
    }];
    cell.layer.cornerRadius = 4;
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    return cell;
}

#pragma mark -UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidht = self.view.frame.size.width / 2 - 18;
    return CGSizeMake(cellWidht, cellWidht * 1.4);
}

-(void)viewDidLayoutSubviews {
    self.collectionView.contentInset = UIEdgeInsetsMake(12, 12, 12, 12);
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

- (NSInteger)indexOfProductWithName:(NSString *)productName {
    
    for (LikedProduct *likedprod in self.likedProducts) {
        if ([likedprod.productName isEqualToString:productName]) {
            return [self.likedProducts indexOfObject:likedprod];
        }
    }
    return -1;
}

@end
