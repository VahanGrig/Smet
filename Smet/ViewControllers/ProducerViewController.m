//
//  ProducerViewController.m
//  Smet
//
//  Created by Vahan Grigoryan on 11/26/17.
//  Copyright © 2017 VG. All rights reserved.
//

#import "ProducerViewController.h"

@interface ProducerViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *producersWebView;

@end

@implementation ProducerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *targetURL = [NSURL URLWithString:self.product.productPageURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [self.producersWebView loadRequest:request];
    self.title = self.product.producerName;
}

@end
