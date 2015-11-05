//
//  DataMapper.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-01.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@protocol DataMapperProtocol

- (NSDictionary*)dataMapping;

@end

@interface DataMapper : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (void)mapData:(NSDictionary *)data ontoObject:(NSObject *)object error:(NSError **)error;

@end
