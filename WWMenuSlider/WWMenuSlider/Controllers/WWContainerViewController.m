//
//  WWContainerViewController.m
//  WWMenuSlider
//
//  Created by Tidus on 15/8/15.
//  Copyright (c) 2015年 Tidus. All rights reserved.
//

#import "WWContainerViewController.h"

#define wwScreenWith ([[UIScreen mainScreen] bounds].size.width)

@interface WWContainerViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) WWMenuViewController *menuController;
@property (nonatomic, strong) WWDetailViewController *detailController;

@end

@implementation WWContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //设置navigationBar的clipsToBounds属性，如果为YES，bar将不会覆盖状态栏
    self.navigationController.navigationBar.clipsToBounds = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    [self setupSubViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
    NSLog(@"%@", NSStringFromCGRect(self.scrollView.frame));
    NSLog(@"%@", NSStringFromCGRect(self.contentView.frame));
    NSLog(@"%@", NSStringFromCGSize(self.scrollView.contentSize));
    
}

- (void)setupSubViews {
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
    //1、ScrollView
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delaysContentTouches = NO;//有啥用？
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scrollView];
    //AutoLayout
    NSDictionary *views = @{@"scrollView":self.scrollView};
    NSDictionary *metrics = @{};
    NSArray *constraint1 = [NSLayoutConstraint
                            constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|"
                            options:NSLayoutFormatDirectionLeadingToTrailing
                            metrics:metrics
                            views:views];
    NSArray *constraint2 = [NSLayoutConstraint
                            constraintsWithVisualFormat:@"V:|-0-[scrollView]-0-|"
                            options:NSLayoutFormatDirectionLeadingToTrailing
                            metrics:metrics
                            views:views];
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
    
    //2、ContentView
    //由于ScrollView比较特殊，需要确定了ContentView的宽高，才能确定其contentSize的大小
    //View的宽为屏幕宽度+80，View右侧离SrollView边缘为0,所以SrollView的contentSize的宽度是屏幕宽度+80
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.contentView];
    //AutoLayout
    NSString *tableViewWidth = @"80";
    views = @{@"contentView":self.contentView, @"scrollView":self.scrollView};
    metrics = @{@"paddingRight":tableViewWidth, @"contentViewWidth":@(wwScreenWith+[tableViewWidth floatValue])};
    constraint1 = [NSLayoutConstraint
                            constraintsWithVisualFormat:@"H:|-0-[contentView(==contentViewWidth)]-0-|"
                            options:NSLayoutFormatDirectionLeadingToTrailing
                            metrics:metrics
                            views:views];
    constraint2 = [NSLayoutConstraint
                            constraintsWithVisualFormat:@"V:|-0-[contentView(==scrollView)]-0-|"
                            options:NSLayoutFormatDirectionLeadingToTrailing
                            metrics:metrics
                            views:views];
    [self.scrollView addConstraints:constraint1];
    [self.scrollView addConstraints:constraint2];
    
    //3、MenuController
    self.menuController = [[WWMenuViewController alloc] init];
    self.menuController.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.menuController.tableView];
    [self addChildViewController:self.menuController];
    //AutoLayout
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"H:|-0-[tableView(==tableViewWidth)]"
                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                      metrics:@{@"tableViewWidth":tableViewWidth}
                                      views:@{@"tableView":self.menuController.tableView}]];
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|"
                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                      metrics:@{}
                                      views:@{@"tableView":self.menuController.tableView, @"contentView":self.contentView}]];
    
    
    //4、DetailController
    self.detailController = [[WWDetailViewController alloc] init];
    self.detailController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.detailController.view];
    [self addChildViewController:self.detailController];
    //AutoLayout
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"H:[tableView]-0-[detailView]-0-|"
                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                      metrics:@{}
                                      views:@{@"tableView":self.menuController.tableView, @"detailView":self.detailController.view}]];
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:|-0-[detailView]-0-|"
                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                      metrics:@{}
                                      views:@{@"tableView":self.menuController.tableView, @"detailView":self.detailController.view}]];
    
    
}

@end
