//
//  CustomNavigationController.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-05.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "CustomNavigationController.h"

@implementation CustomNavigationController

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden
{
    if (!_preventNavigationBarShowing || navigationBarHidden == YES) {
        [super setNavigationBarHidden:navigationBarHidden];
    }
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    if (!_preventNavigationBarShowing || hidden == YES) {
        [super setNavigationBarHidden:hidden animated:animated];
    }
}

@end
