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
#import "Direction.h"

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

-(void)getEarliestDirectionFromCurrentLocation:(CLLocation*)currentLocation completion:(void (^)(Direction*)) completionHandler{
    [self getDirectionsFromLocation:currentLocation completion:^(NSMutableArray *directions) {
        if  (self.directions != nil && self.directions.count > 0) {
            for (Direction *direction in directions){
                NSLog(direction.arrivalString);
            }
            NSLog(@"sorted:");
            self.directions = [self.directions sortedArrayUsingComparator:^NSComparisonResult(Direction *d1, Direction *d2) {
                return d1.arrivalTime < d2.arrivalTime;
            }];
            for (Direction *direction in directions){
                NSLog(direction.arrivalString);
            }
            completionHandler([directions objectAtIndex:0]);
        }
    }];
}

-(void)getDirectionsFromLocation:(CLLocation*)location completion:(void (^)(NSMutableArray*))completionHandler {
    if (_name == nil) { return; }
    if (_placeID == nil) { return; }
    if (location == nil) { return; }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%f%@%f%@%@%@%@%@%@", GOOGLE_BASE, @"origin=", location.coordinate.latitude, @",", location.coordinate.longitude, @"&destination=place_id:", _placeID, @"&key=", GOOGLE_DIRECTIONS_KEY, @"&alternatives=true", @"&mode=transit"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[DataService instance] urlRequestWithUrl:url completion:^(id response) {
        //NSLog(@"%@", response);
        NSLog(urlString);
        completionHandler([self parseResponse:response]);
    }];
}

-(NSMutableArray*)parseResponse:(id)response {
    if (self.directions != nil){
        [self.directions removeAllObjects];
    } else {
        self.directions = [[NSMutableArray alloc]init];
    }
    NSMutableArray *routes = [response objectForKey:@"routes"];
    for (NSDictionary *route in routes){
        Direction *direction;
        NSMutableArray *legs = [route objectForKey:@"legs"];
        NSDictionary *leg = [legs objectAtIndex:0];
        NSString *arrivalTime = [[leg objectForKey:@"arrival_time"] objectForKey:@"value"];
        NSMutableArray *steps = [leg objectForKey:@"steps"];
        for (NSDictionary *step in steps){
            NSString *travelMode = [step objectForKey:@"travel_mode"];
            if ([travelMode isEqualToString:@"TRANSIT"]) {
                NSString *busNumber = [[[step objectForKey:@"transit_details"] objectForKey:@"line"] objectForKey:@"short_name"];
                NSString *departureTime = [[[step objectForKey:@"transit_details"] objectForKey:@"departure_time"] objectForKey:@"value"];
                direction = [[Direction alloc]initWithDepartureTime:[departureTime doubleValue] arrivalTime:[arrivalTime doubleValue] busNumber:busNumber type:@"TRANSIT"];
                break;
            }
        }
        if (direction == nil){
            NSDictionary *leg = [[route objectForKey:@"legs"] objectAtIndex:0];
            NSString *duration = [[leg objectForKey:@"duration"] objectForKey:@"value"];
            direction = [[Direction alloc]initWithDepartureTime:0 arrivalTime:0 busNumber:@"" type:@"WALKING"];
            direction.duration = [duration doubleValue];
            
        }
        [self.directions addObject:direction];
    }
    return self.directions;
}

@end

