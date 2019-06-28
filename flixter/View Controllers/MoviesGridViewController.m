//
//  MoviesGridViewController.m
//  AFNetworking
//
//  Created by jpearl on 6/26/19.
//

#import "MoviesGridViewController.h"
#import "MovieCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "Details2ViewController.h"
#import "SVProgressHUD/SVProgressHUD.h"


@interface MoviesGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UICollectionView *movieGrid;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MoviesGridViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    self.movieGrid.dataSource = self;
    self.movieGrid.delegate = self;
    [self fetchMovies];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.movieGrid insertSubview:self.refreshControl atIndex:0];

    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.movieGrid.collectionViewLayout;

    CGFloat postersPerLine = 3;
    CGFloat itemWidth = self.movieGrid.frame.size.width / postersPerLine;
    CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    // Do any additional setup after loading the view.
}

- (void)fetchMovies {
    // network call here:
    // note** now_playing url called here
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/320288/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // lines inside block called once network call finished
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
           
            //NSLog(@"%@", dataDictionary);
            self.movies = dataDictionary[@"results"];
            
            [self.movieGrid reloadData];
         
            [SVProgressHUD dismiss];

           
            // TODO: Get the array of movies
            // TODO: Store the movies in a property to use elsewhere
            // TODO: Reload your table view data
        }
   
        [self.refreshControl endRefreshing];
       
    }];
    [task resume];
    
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

//#pragma mark - Navigation
//
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UICollectionViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.movieGrid indexPathForCell:tappedCell];
    NSDictionary *movie = self.movies[indexPath.row];
    Details2ViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
    NSLog(@"tapped on a movie");
    
    
    //     Get the new view controller using [segue destinationViewController].
    //     Pass the selected object to the new view controller.
}




- (UICollectionViewCell *)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"MovieCollectionViewCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movies[indexPath.item];
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    cell.moviePic.image = nil;
    [cell.moviePic setImageWithURL:posterURL];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}




@end
