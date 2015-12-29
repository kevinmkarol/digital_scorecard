//
//  masterShowArray.h
//  greekSingScoring
//
//  Created by Kevin Karol on 3/17/14.
//  Copyright (c) 2014 Kevin Karol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowScores.h"
#import "LoginManager.h"
#import "Reachability.h"

@interface MasterShowArray : NSObject<NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableArray *showArray;
@property (nonatomic, strong) ShowScores *currentShow;
@property (nonatomic, strong) NSMutableDictionary<NSString*,UISegmentedControl*> *scoreControls;
@property (nonatomic, strong) NSString* testString;

+ (id)sharedManager;
-(NSString*)serialize;
-(void)sendScores;
-(void)fetchShowListFromServer;


@end
