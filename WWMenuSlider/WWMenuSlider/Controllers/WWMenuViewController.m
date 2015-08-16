//
//  WWMenuViewController.m
//  WWMenuSlider
//
//  Created by Tidus on 15/8/14.
//  Copyright (c) 2015年 Tidus. All rights reserved.
//

#import "WWMenuViewController.h"

@interface WWMenuViewController ()

@property (nonatomic, strong) NSMutableArray *menuItems;

@end

@implementation WWMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuItems" ofType:@"plist"];
    NSArray *items = [[NSArray alloc] initWithContentsOfFile:path];
    self.menuItems = [[NSMutableArray alloc] initWithArray:items];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupSubviews];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    NSLog(@"%@", NSStringFromCGRect(self.tableView.frame));
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubviews {
    
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return MAX(80, CGRectGetHeight(self.view.bounds)) / (CGFloat)self.menuItems.count;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WWDetailViewController *detailController = [[WWDetailViewController alloc] initWithDict:self.menuItems[indexPath.row]];
    [self.navigationController pushViewController:detailController animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"WWMenuItemCellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(!cell){
        cell = [[WWMenuItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if([cell respondsToSelector:@selector(setCellInfo:)]){
        [cell performSelector:@selector(setCellInfo:) withObject:self.menuItems[indexPath.row]];
    }
    
    return cell;
}
@end
