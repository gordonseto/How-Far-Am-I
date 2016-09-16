//
//  LocationCell.m
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-13.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import "LocationCell.h"
#import "General.h"

@implementation LocationCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

-(void)configureCellWithLocation:(Location*)location currentLocation:(CLLocation*)currentLocation{
    if (location.name != nil){
        self.locationLabel.text = location.name;
    }
    [location getEarliestDirectionFromCurrentLocation:currentLocation completion:^(Direction *direction) {
        if (direction != nil) {
            self.timeLabel.text = direction.arrivalString;
            if ([direction.type  isEqual: @"WALKING"]) {
                self.busLabel.text = @"Walking";
            } else {
                self.busLabel.text = [NSString stringWithFormat:@"By %@ At %@", direction.busNumber, direction.departureString];
            }
        }
    }];
}

@end

