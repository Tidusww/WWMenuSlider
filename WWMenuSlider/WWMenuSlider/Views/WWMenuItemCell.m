//
//  WWMenuItemCell.m
//  WWMenuSlider
//
//  Created by Tidus on 15/8/14.
//  Copyright (c) 2015年 Tidus. All rights reserved.
//

#import "WWMenuItemCell.h"

@implementation WWMenuItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubviews];
        
    }
       
    
    
    
    return self;
}


- (void)setupSubviews {
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.iconImageView.frame = self.bounds;
    [self addSubview:self.iconImageView];
    
    
    //AutoLayout
    NSDictionary *views = @{@"imageView":self.iconImageView};
    NSDictionary *metrics = @{};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                                   options:0
                                                                   metrics:metrics
                                                                     views:views];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|"
                                                                   options:0
                                                                   metrics:metrics
                                                                     views:views];
    
    self.autoresizingMask = NO;
    self.iconImageView.autoresizingMask = NO;
//    self.translatesAutoresizingMaskIntoConstraints = NO;
    //十分重要的一句话
    self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraints:constraint1];
    [self addConstraints:constraint2];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellInfo:(NSDictionary *)dict {
    NSString *imageName = [dict objectForKey:@"image"];
    NSArray *colorArray = [dict objectForKey:@"colors"];
    self.iconImageView.image = [UIImage imageNamed:imageName];
    self.backgroundColor = [UIColor colorWithRed:[colorArray[0] floatValue]/255.0 green:[colorArray[1] floatValue]/255.0 blue:[colorArray[2] floatValue]/255.0 alpha:1];
}

@end
