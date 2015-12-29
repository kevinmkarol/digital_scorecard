//
//  ShowScores.h
//  greekSingScoring
//
//  Created by Kevin Karol on 3/16/14.
//  Copyright (c) 2014 Kevin Karol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowScores : NSObject

@property (nonatomic, assign) NSString *organizationName;
@property (nonatomic, assign) NSString *showName;

@property (nonatomic, assign) NSInteger sync;
@property (nonatomic, assign) NSInteger enunc;
@property (nonatomic, assign) NSInteger characters;
@property (nonatomic, assign) NSInteger transitions;
@property (nonatomic, assign) NSInteger flow;

@property (nonatomic, assign) NSInteger setAesthetics;
@property (nonatomic, assign) NSInteger setInteractions;
@property (nonatomic, assign) NSInteger costumes;

@property (nonatomic, assign) NSInteger story;
@property (nonatomic, assign) NSInteger script;
@property (nonatomic, assign) NSInteger acting;


@property (nonatomic, assign) NSInteger groupVocals;
@property (nonatomic, assign) NSInteger featuredVocals;
@property (nonatomic, assign) NSInteger band;

@property (nonatomic, assign) NSInteger choreographyImpressivness;
@property (nonatomic, assign) NSInteger choreographyExecutaion;

@property (nonatomic, assign) NSInteger energy;
@property (nonatomic, assign) NSInteger entertainmentValue;
@property (nonatomic, assign) NSInteger overallImpression;


-(void) createShow:(NSString *)orgName showTitle:(NSString *)showName;
//This method is tied to MasterShowArray init's control names
-(NSInteger) getScoreForControlID:(NSString *) controlKey;
-(NSMutableDictionary*) serialize;

@end
