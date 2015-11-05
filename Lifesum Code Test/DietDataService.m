//
//  DietDataService.m
//  Lifesum Code Test
//
//  Created by Alan Ihre on 2015-11-05.
//  Copyright © 2015 Ihre IT. All rights reserved.
//

#import "DietDataService.h"

static const float RDICalories = 2500;
static const float RDIProtein = 55;
static const float RDIFat = 55;
static const float RDIFiber = 30;
static const float RDICarbohydrates = 343;
static const float RDISugar = 62;
static const float RDISodium = 2;
static const float RDIPotassium = 4;

@implementation DietDataService

+ (float)calculateFoodScoreByFood:(Food *)food
{
    
    //This algorithm is not completly accurate and should be made by multiplying the scores with a base value but since this was not the main purpose of the test I will only develop it this far
    
    float score = 0;
    
    float calories = [food.calories floatValue];
    if (calories > 0) {
        float caloryScore = [DietDataService calculateNutritionalScore:calories RDIValue: RDICalories];
        score += caloryScore;
    }
    
    float protein = [food.protein floatValue];
    if (protein > 0) {
        float proteinScore = [DietDataService calculateNutritionalScore:protein RDIValue: RDIProtein];
        score += proteinScore;
    }
    
    float fat = [food.fat floatValue];
    if (fat > 0) {
        float fatScore = [DietDataService calculateNutritionalScore:fat RDIValue: RDIFat];
        score += fatScore;
    }
    
    float fiber = [food.fiber floatValue];
    if (fiber > 0) {
        float fiberScore = [DietDataService calculateNutritionalScore:fiber RDIValue: RDIFiber];
        score += fiberScore;
    }

    float carbohydrates = [food.carbohydrates floatValue];
    if (carbohydrates > 0) {
        float carbohydratesScore = [DietDataService calculateNutritionalScore:carbohydrates RDIValue: RDICarbohydrates];
        score += carbohydratesScore;
    }

    float sugar = [food.sugar floatValue];
    if (sugar > 0) {
        float sugarScore = [DietDataService calculateNutritionalScore:sugar RDIValue:RDISugar];
        score += sugarScore;
    }
    
    float sodium = [food.sodium floatValue];
    if (sodium > 0) {
        float sodiumScore = [DietDataService calculateNutritionalScore:sodium RDIValue:RDISodium];
        score += sodiumScore;
    }
    
    float potassium = [food.potassium floatValue];
    if (potassium > 0) {
        float potassiumScore = [DietDataService calculateNutritionalScore:potassium RDIValue:RDIPotassium];
        score += potassiumScore;
    }

    return score;
}

+ (float)calculateNutritionalScore:(float)nutritionalValue RDIValue:(float)RDIValue
{
    
    //A person eats more than one ingredient per day so RDI value is divided by 30
    float partialRDIValue = RDIValue / 30;
    
    float diff = partialRDIValue - nutritionalValue;
    if (diff < 0) {
        diff *= -1;
    }
    float ratio = diff / partialRDIValue;
    float reversedRatio = 1 - ratio;
    if (reversedRatio < 0) { //For ratios > 1
        reversedRatio = 1 / ratio;
    }
    return reversedRatio;
}

@end
