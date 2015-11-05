//
//  UIViewController+GoBack.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-03.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "UIViewController+GoBack.h"

@implementation UIViewController (GoBack)

- (IBAction)goBack:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
