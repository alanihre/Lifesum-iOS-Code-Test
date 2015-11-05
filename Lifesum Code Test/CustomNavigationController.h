//
//  CustomNavigationController.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-05.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomNavigationController : UINavigationController

@property (nonatomic) BOOL preventNavigationBarShowing;

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden;
- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end
