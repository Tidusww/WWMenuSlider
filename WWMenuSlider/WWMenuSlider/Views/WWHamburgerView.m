//
//  WWHamburgerView.m
//  WWMenuSlider
//
//  Created by Tidus on 15/8/16.
//  Copyright (c) 2015年 Tidus. All rights reserved.
//

#import "WWHamburgerView.h"

@implementation WWHamburgerView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init {
    if(self = [super init]) {
        [self setupSubViews];
    }
    
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setupSubViews];
    }
    
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    
    
    return self;
}


- (void)setupSubViews {
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Hamburger"]];
    self.imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:self.imageView];
    
    
}

- (void)rotateHamburgerView:(CGFloat)fraction {
    CGFloat angle = 90 * fraction * M_PI / 180;
    [self.imageView.layer setValue:@(angle) forKeyPath:@"transform.rotation.z"];
    
}

@end
