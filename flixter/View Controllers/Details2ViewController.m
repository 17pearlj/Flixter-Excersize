//
//  Details2ViewController.m
//  flixter
//
//  Created by jpearl on 6/26/19.
//  Copyright © 2019 julia@ipearl.net. All rights reserved.
//

#import "Details2ViewController.h"
#import "UIImageView+AFNetworking.h"

@interface Details2ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleMov;
@property (weak, nonatomic) IBOutlet UILabel *dateMov;
@property (weak, nonatomic) IBOutlet UILabel *descMov;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UIImageView *posterImg;

@end

@implementation Details2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterImg setImageWithURL:posterURL];
    
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    [self.backgroundImg setImageWithURL:backdropURL];
    
    self.titleMov.text = self.movie[@"title"];
    self.descMov.text = self.movie[@"overview"];
    self.dateMov.text = self.movie[@"release_date"];
    
    [self.titleMov sizeToFit];
    [self.descMov sizeToFit];
    [self.dateMov sizeToFit];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
