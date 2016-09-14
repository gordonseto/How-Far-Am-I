//
//  ViewController.h
//  How Far Am I
//
//  Created by Gordon Seto on 2016-09-10.
//  Copyright © 2016 Gordon Seto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, retain) CLLocationManager *locationManager;

- (IBAction)onAddButtonTapped:(id)sender;

@end

