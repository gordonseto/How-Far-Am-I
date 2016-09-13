//
//  LocationCell.h
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-13.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface LocationCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *busLabel;

-(void)configureCellWithLocation:(Location*)location currentLocation:(CLLocation*)currentLocation;

@end
