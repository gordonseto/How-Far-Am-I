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

-(void)getDirections {
    if (_name == nil) { return; }
    if (_placeID == nil) { return; }
    
    NSURL *url = [NSURL URLWithString:@"https://maps.googleapis.com/maps/api/directions/json?origin=Disneyland&destination=Universal+Studios+Hollywood4&key=AIzaSyC0yLxw6ZqpTLF7DRjR4HlLRRAHNgxKHLw"];
    
    [[DataService instance] urlRequest:url];
}

@end

