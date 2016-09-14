//
//  ViewController.m
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-10.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import "ViewController.h"
#import "Location.h"
#import "Direction.h"
#import "LocationCell.h"

@import GooglePlaces;

@interface ViewController () <GMSAutocompleteFetcherDelegate>

@end

@implementation ViewController

int const LATITUDE_BOUND = 0.015;
int const LONGITUDE_BOUND = 0.035;

CLLocation *currentLocation;

NSMutableArray *locations;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(refreshView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.tintColor = UIColor.whiteColor;
    [self.tableView addSubview:self.refreshControl];
    self.tableView.scrollEnabled = YES;
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.delaysContentTouches = NO;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    locations = [[NSMutableArray alloc]init];
    
    [self getLocation];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateTime];
}

- (void)getLocation {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager startUpdatingLocation];
    } else {
        [_locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.firstObject != NULL) {
        //NSLog(@"%@", locations.firstObject);
        [_locationManager stopUpdatingLocation];
        currentLocation = locations.firstObject;
    } else {
        NSLog(@"did not work");
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
    Location *location = [locations objectAtIndex:indexPath.row];
    if (currentLocation != nil) {
        [cell configureCellWithLocation:location currentLocation:currentLocation];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return locations.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)onAddButtonTapped:(id)sender {
    [self showGoogleAutoComplete];
}

- (void)updateTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"hh:mm";
    NSString *time = [formatter stringFromDate:date];
    if ([time hasPrefix:@"0"]) {
        time = [time substringFromIndex:1];
    }
    self.timeLabel.text = time;
}

-(void)refreshView {
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)showGoogleAutoComplete {
    GMSAutocompleteViewController *autocompleteController = [[GMSAutocompleteViewController alloc] init];
    autocompleteController.delegate = self;

    if (currentLocation != nil){
        CLLocationCoordinate2D neBoundsCorner = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude + LATITUDE_BOUND, currentLocation.coordinate.longitude - LONGITUDE_BOUND);
        CLLocationCoordinate2D swBoundsCorner = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude - LATITUDE_BOUND, currentLocation.coordinate.longitude + LONGITUDE_BOUND);
        GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc]initWithCoordinate:neBoundsCorner coordinate:swBoundsCorner];
        autocompleteController.autocompleteBounds = bounds;
    }
    [self presentViewController:autocompleteController animated:YES completion:nil];
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    Location *location = [[Location alloc]initWithPlace:place.name :place.placeID];

    [locations addObject:location];
    
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(locations.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
//    [location getDirectionsFromLocation:currentLocation completion:^(NSMutableArray * directions) {
//        for (Direction *direction in directions){
//            NSLog(direction.busNumber);
//            NSLog(direction.departureTime);
//            NSLog(direction.arrivalTime);
//        }
//    }];
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
