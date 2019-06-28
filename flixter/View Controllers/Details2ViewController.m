//
//  Details2ViewController.m
//  flixter
//
//  Created by jpearl on 6/26/19.
//  Copyright © 2019 julia@ipearl.net. All rights reserved.
//

#import "Details2ViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import <WebKit/WebKit.h>
#import "TrailerViewController.h"
#import "helperFunctions.m"

@interface Details2ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleMov;
@property (weak, nonatomic) IBOutlet UILabel *dateMov;
@property (weak, nonatomic) IBOutlet UILabel *descMov;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UIImageView *posterImg;
//@property (weak, nonatomic) IBOutlet WKWebView *trailerLink;
//@property (nonatomic, strong) NSArray *videos;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
//@property (weak, nonatomic) NSString* trailerKey;

@end

@implementation Details2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    
    [self fadePic:self.posterImg withURL:posterURL];
    
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    [self fadePic:self.backgroundImg withURL:backdropURL];
    
    
    self.titleMov.text = self.movie[@"title"];
    self.descMov.text = self.movie[@"overview"];
    self.dateMov.text = self.movie[@"release_date"];
    
    [self.titleMov sizeToFit];
    [self.descMov sizeToFit];
    [self.dateMov sizeToFit];
}
-(void)fadePic: (UIImageView *)imgFading withURL: (NSURL *)urlProvided{
    NSURLRequest *request = [NSURLRequest requestWithURL:urlProvided];
    [imgFading setImageWithURLRequest:request placeholderImage:nil
      success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {

          // imageResponse will be nil if the image is cached
          if (imageResponse) {
              NSLog(@"Image was NOT cached, fade in image");
              imgFading.alpha = 0.0;
              imgFading.image = image;

              //Animate UIImageView back to alpha 1 over 0.3sec
              [UIView animateWithDuration:0.8 animations:^{
                  imgFading.alpha = 1.0;
              }];
          }
          else {
              NSLog(@"Image was cached so just update the image");
              imgFading.image = image;
          }
      }
      failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {
          // do something for the failure condition
      }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSDictionary *movie = self.movie;
    NSLog(@"%@", self.movie);
    TrailerViewController *trailerViewController = [segue destinationViewController];
    trailerViewController.movie = movie;
    NSLog(@"tapped on a ddd");
    NSLog(@"%@", self.movie[@"title"]);
    
    
    //     Get the new view controller using [segue destinationViewController].
    //     Pass the selected object to the new view controller.
}

@end
