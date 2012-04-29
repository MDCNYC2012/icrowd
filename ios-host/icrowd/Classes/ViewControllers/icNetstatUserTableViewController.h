//
//  icNetstatUserTableViewController.h
//  icrowd
//
//  Created by Nick Kaye on 4/29/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import <UIKit/UIKit.h>

@class icUser;

#pragma mark - icNetstatUserTableViewDelegate
@protocol icCloudNodesViewDelegate <NSObject>
-(void)mainDidUpdateInterval;
@end

@interface icNetstatUserTableViewController : UITableViewController <icCloudNodesViewDelegate>

#pragma mark - Table view data source
-(UITableViewCell *) tableCellUser: (UITableView *)tableView withUser: (icUser *) user;
-(UITableViewCell *) tableCellInit: (UITableView *)tableView withIdentifier: (NSString *)CellIdentifier;

@end
