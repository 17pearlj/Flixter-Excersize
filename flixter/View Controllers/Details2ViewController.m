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

@interface Details2ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleMov;
@property (weak, nonatomic) IBOutlet UILabel *dateMov;
@property (weak, nonatomic) IBOutlet UILabel *descMov;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;
@property (weak, nonatomic) IBOutlet UIImageView *posterImg;
@property (weak, nonatomic) IBOutlet WKWebView *trailerLink;
@property (nonatomic, strong) NSArray *videos;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) NSString* trailerKey;

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
    NSLog(@"about to fetch");
    [self fetchVid];
    NSLog(@"just fetched");
    NSString *urlString = @"https://www.youtube.com/watch?v=";
    NSLog(@"%@", self.trailerKey);
    if (self.trailerKey){
        NSString *fullTrailerURLString = [urlString stringByAppendingString:self.trailerKey];
        NSURL *url = [NSURL URLWithString:fullTrailerURLString];
        
        // Place the URL in a URL Request.
        NSURLRequest *request = [NSURLRequest requestWithURL:url
                                                 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                             timeoutInterval:10.0];
        // Load Request into WebView.
        [self.trailerLink loadRequest:request];
    } else {
        NSLog(@"hi");
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(fetchVid) forControlEvents:UIControlEventValueChanged];
        [self.trailerLink insertSubview:self.refreshControl atIndex:0];
    }
}

- (void)fetchVid {
    // network call here:
    // note** now_playing url called here
    NSString *string1 = @"https://api.themoviedb.org/3/movie/";
    NSString *keyString = [self.movie[@"id"] stringValue];
    NSString *string2 = [string1 stringByAppendingString:keyString];
    NSString *string3 = @"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US";
    NSString *stringFinal = [string2 stringByAppendingString:string3];
   
    NSLog(@"PUT ALL MY STRINGS");
    NSURL *url = [NSURL URLWithString:stringFinal];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // lines inside block called once network call finished
        if (error != nil) {
            [SVProgressHUD dismiss];
            NSString *er = [error localizedDescription];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle: er message:@"" preferredStyle:(UIAlertControllerStyleAlert)];
            // create an OK action
            UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 
                                                                 [self viewDidLoad];
                                                             }];
            [alert addAction:tryAgain];
            [self presentViewController:alert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
                
                [self viewDidLoad];
            }];
            
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //NSLog(@"%@", dataDictionary);
            self.videos = dataDictionary[@"results"];
            [SVProgressHUD dismiss];
            if (self.videos.count != 0){
                NSLog(@"we go options");
                self.trailerKey = self.videos[0][@"key"];
                NSLog(@"%@", self.trailerKey);
                if (self.trailerKey){
                    NSString *urlString = @"https://www.youtube.com/watch?v=";
                    NSString *fullTrailerURLString = [urlString stringByAppendingString:self.trailerKey];
                    NSURL *url = [NSURL URLWithString:fullTrailerURLString];
                    
                    // Place the URL in a URL Request.
                    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                         timeoutInterval:10.0];
                    // Load Request into WebView.
                    [self.trailerLink loadRequest:request];
                }
            } else {
                NSLog(@"nothing here");
                self.trailerKey = nil;
            }
            
            // TODO: Get the array of movies
            // TODO: Store the movies in a property to use elsewhere
            // TODO: Reload your table view data
        }
        [self.refreshControl endRefreshing];
    }];
    [task resume];
    
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
