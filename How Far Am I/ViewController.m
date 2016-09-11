//
//  ViewController.m
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-10.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import "ViewController.h"
#import "Location.h"

@import GooglePlaces;

@interface ViewController () <GMSAutocompleteFetcherDelegate>

@end

@implementation ViewController

CLLocation *currentLocation;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.scrollEnabled = YES;
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.delaysContentTouches = NO;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    [self getLocation];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateTime];
}

- (void)getLocation {
    NSLog(@"hi");
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
        NSLog(@"%@", locations.firstObject);
        [_locationManager stopUpdatingLocation];
        currentLocation = locations.firstObject;
    } else {
        NSLog(@"did not work");
    }
}

- (void)onAddButtonTapped:(id)sender {
    NSLog(@"wat");
    [self showGoogleAutoComplete];
}

- (void)updateTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"hh:mm";
    NSLog(@"hi");
    NSString *time = [formatter stringFromDate:date];
    if ([time hasPrefix:@"0"]) {
        time = [time substringFromIndex:1];
    }
    self.timeLabel.text = time;
}

- (void)showGoogleAutoComplete {
    GMSAutocompleteViewController *autocompleteController = [[GMSAutocompleteViewController alloc] init];
    autocompleteController.delegate = self;
    [self presentViewController:autocompleteController animated:YES completion:nil];
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    Location *location = [[Location alloc]initWithPlace:place.name :place.placeID];
    NSLog(@"Test: %@", location.name);
    NSLog(@"Test: %@", location.placeID);
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
