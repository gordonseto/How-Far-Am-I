//
//  Location.h
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-11.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location: NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *placeID;

-(id)initWithPlace:(NSString *)name:(NSString *)placeID;
-(void)getDirectionsFromLocation:(CLLocation*)location;

@end
