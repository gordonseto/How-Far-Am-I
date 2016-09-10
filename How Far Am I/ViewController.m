//
//  ViewController.m
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-10.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

CLLocation *currentLocation;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    [self getLocation];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateTime];
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

@end
