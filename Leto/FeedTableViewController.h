//
//  FeedTableViewController.h
//  Leto
//
//  Created by Shevchenko Nik on 10/08/2015.
//  Copyright (c) 2015 Shevchenko Nik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedTableViewController : UITableViewController

// VIEW CONTROLLER
@property (strong, nonatomic) IBOutlet UITableView *feedTableView;

// FEED ARRAY
@property (strong, nonatomic) NSMutableArray *feedsArray;

@end
