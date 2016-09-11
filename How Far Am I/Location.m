//
//  Location.m
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-11.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import "Location.h"

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

@end

