//
//  LoginManager.m
//  greekSingScoring
//
//  Created by Kevin Karol on 3/11/15.
//  Copyright (c) 2015 Kevin Karol. All rights reserved.
//

#import "LoginManager.h"

@implementation LoginManager

static bool loggedin = false;
static NSString* judgeName = @"";

+(bool)isLoggedIn{
    return loggedin;
}

+(void)setName:(NSString *)name{
    judgeName = name;
    loggedin = true;
}

+(NSString *)getName{
    return judgeName;
}

@end
