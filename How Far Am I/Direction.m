//
//  Direction.m
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-12.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Direction.h"

@implementation Direction {
    //private instance variables
}

-(id)initWithDepartureTime:(NSString *)departureTime :(NSInteger *)duration :(NSString *)busNumber :(NSString *)type{
    self = [super init];
    
    _departureTime = departureTime;
    _duration = duration;
    _busNumber = busNumber;
    _type = type;
    
    return self;
}

@end