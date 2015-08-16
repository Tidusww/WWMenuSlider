//
//  WWDetailViewController.h
//  WWMenuSlider
//
//  Created by Tidus on 15/8/14.
//  Copyright (c) 2015年 Tidus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWHamburgerView.h"


typedef void(^hamburgerViewDidTapBlock)(UITapGestureRecognizer *tapGesture);
@interface WWDetailViewController : UIViewController

@property (nonatomic, copy) hamburgerViewDidTapBlock hamburgerViewDidTapBlock;
@property (nonatomic, strong) WWHamburgerView *hamburgerView;

- (instancetype)initWithDict:(NSDictionary *)dict;

- (void)setInfoDict:(NSDictionary *)dict;
    
@end
