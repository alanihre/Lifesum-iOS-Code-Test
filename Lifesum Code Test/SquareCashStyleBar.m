//
//  SquareCashStyleBar.m
//  BLKFlexibleHeightBar Demo
//
//  Created by Bryan Keller on 2/19/15.
//  Copyright (c) 2015 Bryan Keller. All rights reserved.
//

#import "SquareCashStyleBar.h"
#import "ColorConstants.h"

@implementation SquareCashStyleBar

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    if(self = [super initWithFrame:frame])
    {
        [self configureBarWithTitle:title];
    }
    
    return self;
}

- (void)configureBarWithTitle:(NSString *)title
{
    // Configure bar appearence
    self.maximumBarHeight = 150.0;
    self.minimumBarHeight = 65.0;
    self.backgroundColor = COLOR_LIFESUM_GREEN;
    
    
    CGSize labelSize = CGSizeMake(self.frame.size.width - 30, self.maximumBarHeight - 50);
    
    // Add and configure name label
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:35.0 weight:UIFontWeightMedium];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.numberOfLines = 2;
    nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = title;
    
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *initialNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
    initialNameLabelLayoutAttributes.size = [nameLabel sizeThatFits:labelSize];
    initialNameLabelLayoutAttributes.center = CGPointMake(labelSize.width*0.5+15, self.maximumBarHeight-50.0);
    [nameLabel addLayoutAttributes:initialNameLabelLayoutAttributes forProgress:0.0];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *midwayNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialNameLabelLayoutAttributes];
    midwayNameLabelLayoutAttributes.center = CGPointMake(labelSize.width*0.5+15, (self.maximumBarHeight-self.minimumBarHeight)*0.4+self.minimumBarHeight-50.0);
    CGAffineTransform translationM = CGAffineTransformMakeTranslation(0.0, 0.0);
    CGAffineTransform scaleM = CGAffineTransformMakeScale(0.7, 0.7);
    midwayNameLabelLayoutAttributes.transform = CGAffineTransformConcat(scaleM, translationM);
    [nameLabel addLayoutAttributes:midwayNameLabelLayoutAttributes forProgress:0.6];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *finalNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:midwayNameLabelLayoutAttributes];
    finalNameLabelLayoutAttributes.center = CGPointMake(labelSize.width*0.5+15, self.minimumBarHeight-25.0);
    CGAffineTransform translation = CGAffineTransformMakeTranslation(0.0, 0.0);
    CGAffineTransform scale = CGAffineTransformMakeScale(0.5, 0.5);
    finalNameLabelLayoutAttributes.transform = CGAffineTransformConcat(scale, translation);
    [nameLabel addLayoutAttributes:finalNameLabelLayoutAttributes forProgress:1.0];
    
    [self addSubview:nameLabel];
    
}

@end
