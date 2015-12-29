//
//  LoginManager.h
//  greekSingScoring
//
//  Created by Kevin Karol on 3/11/15.
//  Copyright (c) 2015 Kevin Karol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginManager : NSObject

+(bool)isLoggedIn;
+(void)setName:(NSString *) name;
+(NSString *)getName;

@end
