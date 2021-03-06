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

-(NSString*)busNumber {
    if ([_busNumber characterAtIndex:0] == '0') {
        return [_busNumber substringFromIndex:1];
    } else {
        return _busNumber;
    }
}

-(NSString*)departureString {
    if (_departureTime) {
        return [General stringFromTimeInterval:_departureTime];
    } else {
        return @"";
    }
}

-(NSString*)arrivalString {
    if (_arrivalTime) {
        return [General stringFromTimeInterval:_arrivalTime];
    } else {
        return @"";
    }
}

-(id)initWithDepartureTime:(NSTimeInterval)departureTime arrivalTime:(NSTimeInterval)arrivalTime busNumber:(NSString *)busNumber type:(NSString *)type{
    self = [super init];
    
    _departureTime = departureTime;
    _arrivalTime = arrivalTime;
    _duration = arrivalTime - departureTime;
    _busNumber = busNumber;
    _type = type;
    
    return self;
}

@end