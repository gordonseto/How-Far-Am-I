//
//  Direction.h
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-12.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Direction: NSObject

@property NSTimeInterval departureTime;
@property NSTimeInterval arrivalTime;
@property (nonatomic, strong) NSString *busNumber;
@property (nonatomic, strong) NSString *type;
@property NSTimeInterval duration;

-(id)initWithDepartureTime:(NSTimeInterval)departureTime arrivalTime:(NSTimeInterval)arrivalTime busNumber:(NSString *)busNumber type:(NSString *)type;

@end