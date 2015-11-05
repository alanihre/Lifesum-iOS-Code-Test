//
//  JSONImporter.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-01.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONImporter : NSObject

+ (NSArray *)importJSONArrayWithFileName:(NSString *)fileName error:(NSError **)error;

@end
