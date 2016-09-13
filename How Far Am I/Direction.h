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
@property NSInteger *duration;
@property (nonatomic, strong) NSString *busNumber;
@property (nonatomic, strong) NSString *type;

-(id)initWithDepartureTime:(NSString*)departureTime :(NSInteger*)duration :(NSString*)busNumber :(NSString*)type;

@end