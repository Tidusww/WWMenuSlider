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
    
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if(self = [super init]){
        self.dict = dict;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSubviews {
    NSString *imageName = [self.dict objectForKey:@"bigImage"];
    NSArray *colorArray = [self.dict objectForKey:@"colors"];
    
    self.backgroundImageView = [[UIImageView alloc] init];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundImageView.image = [UIImage imageNamed:imageName];
    self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.backgroundImageView];
    self.view.backgroundColor = [UIColor colorWithRed:[colorArray[0] floatValue]/255.0 green:[colorArray[1] floatValue]/255.0 blue:[colorArray[2] floatValue]/255.0 alpha:1];
    
    
    //AutoLayout
    NSDictionary *views = @{@"view":self.view, @"imageView":self.backgroundImageView};
    NSDictionary *metrics = @{};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                                   options:0
                                                                   metrics:metrics
                                                                     views:views];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|"
                                                                   options:0
                                                                   metrics:metrics
                                                                     views:views];
    
    [self.view addConstraints:constraint1];
    [self.view addConstraints:constraint2];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
