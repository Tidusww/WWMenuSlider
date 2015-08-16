//
//  WWDetailViewController.m
//  WWMenuSlider
//
//  Created by Tidus on 15/8/14.
//  Copyright (c) 2015年 Tidus. All rights reserved.
//

#import "WWDetailViewController.h"

@interface WWDetailViewController ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) NSDictionary *dict;
@end

@implementation WWDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupSubviews];
    [self setDetailInfo];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
    
    
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if(self = [super init]){
        self.dict = dict;
    }
    return self;
}

- (void)setInfoDict:(NSDictionary *)dict {
    self.dict = dict;
    [self setDetailInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubviews {
    
    self.backgroundImageView = [[UIImageView alloc] init];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.backgroundImageView];
    
    
    //AutoLayout
    NSDictionary *views = @{@"view":self.view, @"imageView":self.backgroundImageView};
    NSDictionary *metrics = @{};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                                                   metrics:metrics
                                                                     views:views];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|"
                                                                   options:NSLayoutFormatDirectionLeadingToTrailing
                                                                   metrics:metrics
                                                                     views:views];
    
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
}

- (void)setDetailInfo {
    if(self.dict == nil){
        return;
    }
    NSString *imageName = [self.dict objectForKey:@"bigImage"];
    NSArray *colorArray = [self.dict objectForKey:@"colors"];
    
    self.backgroundImageView.image = [UIImage imageNamed:imageName];
    self.view.backgroundColor = [UIColor colorWithRed:[colorArray[0] floatValue]/255.0 green:[colorArray[1] floatValue]/255.0 blue:[colorArray[2] floatValue]/255.0 alpha:1];
}


@end
