//
//  Location.h
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-11.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Direction.h"

@interface Location: NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *placeID;
@property (nonatomic, strong) NSMutableArray *directions;

-(id)initWithPlace:(NSString *)name:(NSString *)placeID;
-(void)getDirectionsFromLocation:(CLLocation*)location completion:(void (^)(NSMutableArray*))completionHandler;
-(void)getEarliestDirectionFromCurrentLocation:(CLLocation*)currentLocation completion:(void (^)(Direction*)) completionHandler;

@end
