//
//  DataService.h
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-12.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataService : NSObject

+(id)instance;
-(void)urlRequestWithUrl:(NSURL*)url completion:(void (^)(id response))completionBlock;

@end