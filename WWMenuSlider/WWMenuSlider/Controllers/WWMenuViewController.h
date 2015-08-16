//
//  WWMenuViewController.h
//  WWMenuSlider
//
//  Created by Tidus on 15/8/14.
//  Copyright (c) 2015年 Tidus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWMenuItemCell.h"

typedef void(^WWMenuItemCellDidSelectBlock)(UITableView* tableView, NSIndexPath *indexPath, NSDictionary *dict);

@interface WWMenuViewController : UITableViewController

@property (nonatomic, copy) WWMenuItemCellDidSelectBlock itemDidSelectBlock;

@end
