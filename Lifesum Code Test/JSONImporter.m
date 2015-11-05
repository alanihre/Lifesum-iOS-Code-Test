//
//  JSONImporter.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-01.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "JSONImporter.h"

@implementation JSONImporter

NSString * const kJSONImporterErrorDomain = @"com.lifesumCodeTest.JSONImporter";

+ (NSArray *)importJSONArrayWithFileName:(NSString *)fileName error:(NSError **)error
{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    if (!filePath) {
        *error = [NSError errorWithDomain:kJSONImporterErrorDomain code:100 userInfo:@{NSLocalizedDescriptionKey: @"Invalid file path"}];
        return nil;
    }
    
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    if (!fileData) {
        *error = [NSError errorWithDomain:kJSONImporterErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey: @"Could not load file data"}];
        return nil;
    }
    
    NSError *jsonDecodeError = nil;
    id json = [NSJSONSerialization JSONObjectWithData:fileData options:0 error:&jsonDecodeError];
    
    if (jsonDecodeError) {
        *error = jsonDecodeError;
        return nil;
    }
    
    if (!json) {
        *error = [NSError errorWithDomain:kJSONImporterErrorDomain code:102 userInfo:@{NSLocalizedDescriptionKey: @"Invalid JSON"}];
        return nil;
    } else if(![json isKindOfClass:[NSArray class]]) {
        *error = [NSError errorWithDomain:kJSONImporterErrorDomain code:103 userInfo:@{NSLocalizedDescriptionKey: @"Imported JSON is not an array"}];
        return nil;
    }
    
    return json;

}

@end
