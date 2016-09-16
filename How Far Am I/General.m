//
//  General.m
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-13.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import "General.h"

@implementation General

+(NSString*)stringFromTimeInterval:(NSTimeInterval)time{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm a"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time ];
    NSString *resultString = [dateFormatter stringFromDate: date];
    return resultString;
}

@end