//
//  icNetstatUserTableViewController.h
//  icrowd
//
//  Created by Nick Kaye on 4/29/12.
//  Copyright (c) 2012 Outright Mental. All rights reserved.
//

#import "global.h"
#import <UIKit/UIKit.h>

@class icUser;
@class icNetstatUserTableCell;

#pragma mark - icNetstatUserTableViewDelegate
@protocol icCloudNodesViewDelegate <NSObject>
-(void)mainDidUpdateInterval;
@end

@interface icNetstatUserTableViewController : UITableViewController <icCloudNodesViewDelegate>

#pragma mark - Data Transform to Local Cache
@property (nonatomic,strong) NSArray * visUsers;
-(void)visdataRebuild;
-(void)visdataRelease;

#pragma mark - Table view data source
-(icNetstatUserTableCell *) tableCellUser: (UITableView *)tableView withUser: (icUser *) user;
-(icNetstatUserTableCell *) tableCellInit: (UITableView *)tableView withIdentifier: (NSString *)CellIdentifier;


@end
