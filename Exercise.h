//
//  Exercise.h
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-02.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Exercise : NSManagedObject

@property (nonatomic, strong) NSString *name_pl;
@property (nonatomic, strong) NSNumber *hidden;
@property (nonatomic, strong) NSNumber *removed;
@property (nonatomic, strong) NSNumber *downloaded;
@property (nonatomic, strong) NSString *name_da;
@property (nonatomic, strong) NSNumber *photoVersion;
@property (nonatomic, strong) NSNumber *custom;
@property (nonatomic, strong) NSString *name_pt;
@property (nonatomic, strong) NSNumber *oid;
@property (nonatomic, strong) NSString *name_no;
@property (nonatomic, strong) NSString *name_sv;
@property (nonatomic, strong) NSString *name_es;
@property (nonatomic, strong) NSDate *lastUpdated;
@property (nonatomic, strong) NSString *name_ru;
@property (nonatomic, strong) NSNumber *addedByUser;
@property (nonatomic, strong) NSString *name_de;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *name_fr;
@property (nonatomic, strong) NSString *name_nl;
@property (nonatomic, strong) NSNumber *calories;
@property (nonatomic, strong) NSString *name_it;

+ (NSString *)entityName;

+ (NSArray *)supportedLanguages;
+ (NSString *)attributeNameForLanguageIdentifier:(NSString *)languageIdentifier;
+ (NSString *)titleForExercise:(Exercise *)exercise byLanguageIdentifier:(NSString *)languageIdentifier;

+ (NSPredicate *)predicateWithLanguageAttributeName:(NSString *)languageAttributeName filteredByTitle:(NSString *)title;

@end
