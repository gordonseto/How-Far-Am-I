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

@property (nonatomic, strong) NSString *departureTime;
@property (nonatomic, strong) NSString *arrivalTime;
@property (nonatomic, strong) NSString *busNumber;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *duration;

-(id)initWithDepartureTime:(NSString *)departureTime arrivalTime:(NSString *)arrivalTime busNumber:(NSString *)busNumber type:(NSString *)type;

@end