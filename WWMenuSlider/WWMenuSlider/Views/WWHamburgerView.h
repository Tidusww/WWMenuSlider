//
//  WWHamburgerView.h
//  WWMenuSlider
//
//  Created by Tidus on 15/8/16.
//  Copyright (c) 2015年 Tidus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWHamburgerView : UIView

@property (nonatomic, strong) UIImageView *imageView;

- (void)rotateHamburgerView:(CGFloat)fraction;

@end
