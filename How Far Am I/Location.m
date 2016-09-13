//
//  Location.m
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-11.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import "Location.h"
#import "AFNetworking.h"
#import "DataService.h"
#import <CoreLocation/CoreLocation.h>
#import "Constants.h"

@implementation Location {
    //private instance variables
}

-(id)initWithPlace:(NSString *)name :(NSString *)placeID {
    self = [super init];
    if (self) {
        _name = name;
        _placeID = placeID;
    }
    return self;
}

-(void)getDirectionsFromLocation:(CLLocation*)location {
    if (_name == nil) { return; }
    if (_placeID == nil) { return; }
    if (location == nil) { return; }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%f%@%f%@%@%@%@%@%@", GOOGLE_BASE, @"origin=", location.coordinate.latitude, @",", location.coordinate.longitude, @"&destination=place_id:", _placeID, @"&key=", GOOGLE_DIRECTIONS_KEY, @"&alternatives=true", @"&mode=transit"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[DataService instance] urlRequestWithUrl:url completion:^(id response) {
        //NSLog(@"%@", response);
        [self parseResponseWithResponse:response];
    }];
}

-(void)parseResponseWithResponse:(id)response {
    NSMutableArray *routes = [response objectForKey:@"routes"];
    for (int i = 0; i < routes.count; i++){
        NSDictionary *route = [routes objectAtIndex:i];
    }
}

@end

