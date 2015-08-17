//
//  WWContainerViewController.m
//  WWMenuSlider
//
//  Created by Tidus on 15/8/15.
//  Copyright (c) 2015年 Tidus. All rights reserved.
//

#import "WWContainerViewController.h"

#define wwScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define wwMenuWidth (@"80")

@interface WWContainerViewController ()

@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, assign) BOOL showingMenu;
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
    
    __weak typeof(self) wself = self;
    self.menuController.itemDidSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, NSDictionary *dict){
        wself.curIndex = indexPath.row ;
        wself.showingMenu = NO;
        [wself setDetailControllerDict:dict];
        [wself setMenuOpen:wself.showingMenu  animated:YES];
    };
    
    self.detailController.hamburgerViewDidTapBlock = ^(UITapGestureRecognizer *tapGesture) {
        
        wself.showingMenu = !wself.showingMenu;
        [wself setMenuOpen:wself.showingMenu animated:YES];
    };
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
//    NSLog(@"%@", NSStringFromCGRect(self.scrollView.frame));
//    NSLog(@"%@", NSStringFromCGRect(self.contentView.frame));
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.menuController.view.layer.anchorPoint = CGPointMake(1, 0.5);
    
    
    [self setMenuOpen:self.showingMenu animated:NO];
    
    
}

- (void)setupSubViews {
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
    views = @{@"contentView":self.contentView, @"scrollView":self.scrollView};
    metrics = @{@"paddingRight":wwMenuWidth, @"contentViewWidth":@(wwScreenWidth+[wwMenuWidth floatValue])};
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
//    self.menuController = [[WWMenuViewController alloc] init];
//    self.menuController.tableView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.contentView addSubview:self.menuController.tableView];
//    [self addChildViewController:self.menuController];
//    [self.menuController didMoveToParentViewController:self];
//    //AutoLayout
//    [self.contentView addConstraints:[NSLayoutConstraint
//                                      constraintsWithVisualFormat:@"H:|-0-[tableView(==tableViewWidth)]"
//                                      options:NSLayoutFormatDirectionLeadingToTrailing
//                                      metrics:@{@"tableViewWidth":wwMenuWidth}
//                                      views:@{@"tableView":self.menuController.tableView}]];
//    [self.contentView addConstraints:[NSLayoutConstraint
//                                      constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|"
//                                      options:NSLayoutFormatDirectionLeadingToTrailing
//                                      metrics:@{}
//                                      views:@{@"tableView":self.menuController.tableView}]];
    
    //带NavigationController
    //初始化RootViewController
    self.menuController = [[WWMenuViewController alloc] init];
    //设置RootViewController
    UINavigationController *menuNavController = [[UINavigationController alloc] initWithRootViewController:self.menuController];
    //设置导航栏样式
    menuNavController.navigationBar.translucent = NO;
    menuNavController.navigationBar.barTintColor = [UIColor blackColor];
    //使用AutoLayout
    menuNavController.view.translatesAutoresizingMaskIntoConstraints = NO;
    //添加到parentController
    [self.contentView addSubview:menuNavController.view];
    [self addChildViewController:menuNavController];
    [menuNavController didMoveToParentViewController:self];
    //添加AutoLayout样式
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"H:|-0-[tableView(==tableViewWidth)]"
                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                      metrics:@{@"tableViewWidth":wwMenuWidth}
                                      views:@{@"tableView":menuNavController.view}]];
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|"
                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                      metrics:@{}
                                      views:@{@"tableView":menuNavController.view}]];
    
    
    //4、DetailNavigationController
    self.detailController = [[WWDetailViewController alloc] init];
    UINavigationController *detailNavController = [[UINavigationController alloc] initWithRootViewController:self.detailController];
    detailNavController.navigationBar.translucent = NO;
    detailNavController.navigationBar.barTintColor = [UIColor blackColor];
    detailNavController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
//    [self.contentView addSubview:self.detailController.view];
    [self.contentView addSubview:detailNavController.view];
    [self addChildViewController:detailNavController];
    [detailNavController didMoveToParentViewController:self];
    //AutoLayout
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"H:[tableView]-0-[navigationView]-0-|"
                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                      metrics:@{}
                                      views:@{@"tableView":menuNavController.view,
                                              @"navigationView":detailNavController.view}]];
    [self.contentView addConstraints:[NSLayoutConstraint
                                      constraintsWithVisualFormat:@"V:|-0-[navigationView]-0-|"
                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                      metrics:@{}
                                      views:@{@"navigationView":detailNavController.view}]];
    
    //5、DetailController
//    self.detailController.view.frame = detailNavController.view.bounds;
//    self.detailController.view.translatesAutoresizingMaskIntoConstraints = NO;
//    [detailNavController.view addSubview:self.detailController.view];
//    [detailNavController addChildViewController:self.detailController];
    
    
//    //AutoLayout
//    [detailNavController.view addConstraints:[NSLayoutConstraint
//                                      constraintsWithVisualFormat:@"H:|-0-[detailView(==375)]-0-|"
//                                      options:NSLayoutFormatDirectionLeadingToTrailing
//                                      metrics:@{}
//                                      views:@{@"detailView":self.detailController.view}]];
//    [detailNavController.view addConstraints:[NSLayoutConstraint
//                                      constraintsWithVisualFormat:@"V:|-0-[navigationBar]-0-[detailView]-0-|"
//                                      options:NSLayoutFormatDirectionLeadingToTrailing
//                                      metrics:@{}
//                                      views:@{@"navigationBar":detailNavController.navigationBar,
//                                              @"detailView":self.detailController.view}]];
}

#pragma mark - Event
- (void)setDetailControllerDict:(NSDictionary *)dict {
    
    [self.detailController setInfoDict:dict];
    
}

- (void)setMenuOpen:(BOOL)isOpen animated:(BOOL) animate {
    [self.scrollView setContentOffset:(isOpen ? CGPointZero : CGPointMake([wwMenuWidth floatValue], 0)) animated:animate];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //避免点击detailView会导致菜单弹出
    scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - CGRectGetWidth(scrollView.frame));
    
    //实时更新showingMenu
    if(scrollView.contentOffset.x == 0){
        self.showingMenu = YES;
    }else{
        self.showingMenu = NO;
    }
    
    [self transformMenuViewWithX:scrollView.contentOffset.x];
    
}

#pragma mark - 动画 根据offset.x设置 menu的旋转
- (void)transformMenuViewWithX:(CGFloat)x {
    CGFloat angle = 90 * (x/[wwMenuWidth floatValue]) * M_PI/180;
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -0.001;
    self.menuController.view.layer.transform = perspective;
    
//    [self.menuController.view.layer setValue:@([wwMenuWidth floatValue] * 0.5) forKeyPath:@"transform.translation.x"];
    
    [self.menuController.view.layer setValue:@(-angle) forKeyPath:@"transform.rotation.y"];
    
    self.menuController.view.alpha = 1 - x/[wwMenuWidth floatValue];
    
    [self.detailController.hamburgerView rotateHamburgerView: 1 - x/[wwMenuWidth floatValue]];
    
    
    
}

@end
