//
//  DataService.m
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-12.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import "DataService.h"
#import "AFNetworking.h"

@implementation DataService

+(id)instance {
    static DataService *sharedInstance = nil;
    
    @synchronized (self) {
        if (sharedInstance == nil){
            sharedInstance = [[self alloc]init];
        }
    }
    
    return sharedInstance;
}

-(void)urlRequest:(NSURL*)url{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
}

@end
