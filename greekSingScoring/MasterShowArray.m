//
//  masterShowArray.m
//  greekSingScoring
//
//  Created by Kevin Karol on 3/17/14.
//  Copyright (c) 2014 Kevin Karol. All rights reserved.
//

#import "MasterShowArray.h"
#import "ShowScores.h"

#define requestURL [NSURL URLWithString: @"http://kevinmkarol.com/gs/scoredata"]
#define showListURL [NSURL URLWithString: @"http://kevinmkarol.com/gs/showList"]

@implementation MasterShowArray


+(id)sharedManager{
    static MasterShowArray* sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

-(id) init{
    if(self = [super init]){
        //set all scores to null value
        _scoreControls = [[NSMutableDictionary alloc] initWithCapacity:19];

        //These names are tied with DetailViewController's IBAction names
        _scoreControls[@"sync"] = nil;
        _scoreControls[@"enunc"] = nil;
        _scoreControls[@"characters"] = nil;
        _scoreControls[@"trasitions"] = nil;
        _scoreControls[@"flow"] = nil;
        _scoreControls[@"setAesthetics"] = nil;
        _scoreControls[@"setInteractions"] = nil;
        _scoreControls[@"costumes"] = nil;
        _scoreControls[@"story"] = nil;
        _scoreControls[@"script"] = nil;
        _scoreControls[@"acting"] = nil;
        _scoreControls[@"groupVocals"] = nil;
        _scoreControls[@"featuredVocals"] = nil;
        _scoreControls[@"band"] = nil;
        _scoreControls[@"choreographyImpressivness"] = nil;
        _scoreControls[@"choreographyExecution"] = nil;
        _scoreControls[@"energy"] = nil;
        _scoreControls[@"entertainmentValue"] = nil;
        _scoreControls[@"overallImpression"] = nil;
    }
    
    [self fetchShowListFromServer];
    return self;
}


#pragma mark Sigleton Methods

-(NSString *)serialize {
    
    NSMutableArray *serializedShows = [[NSMutableArray alloc] initWithCapacity:12];
    
    for(int i = 0; i < 12; i++){
        ShowScores *current = _showArray[i];
        serializedShows[i] = current.serialize;
    }
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:serializedShows options:kNilOptions error:normal];
    NSString *final = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return final;
}

-(void)sendScores{
    if([Reachability reachabilityForInternetConnection]){
        NSString *currentJudge = [LoginManager getName];
        //Set current time
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:@"d MMM HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
        NSDate *date = [NSDate date];
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        
        NSMutableDictionary *updateData = [[NSMutableDictionary alloc] init];
        [updateData setValue: currentJudge forKey: @"judge"];
        [updateData setValue: dateString forKey: @"time"];
        [updateData setValue: self.serialize forKey: @"showArray"];
        
        //Start of boiler code
        NSString *manualSerialize = [NSString stringWithFormat:@"judge=%@&time=%@&showArray=%@", currentJudge, dateString, self.serialize];
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];

        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];

        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL];
        [request setHTTPBody:[manualSerialize dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPMethod:@"POST"];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            // The server answers with an error because it doesn't receive the params
            NSString *responded = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", responded);
        }];
        
        [postDataTask resume];
    }
}

-(void)fetchShowListFromServer
{
if([Reachability reachabilityForInternetConnection]){
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:showListURL];
    [request setHTTPBody:[@"emptybody" dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // The server answers with an error because it doesn't receive the params
        if(!error){
            NSString *responded = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@", responded);
            //Set Zero in here
            //set currentShow Array in here
            NSError* e = nil;
            NSDictionary* formattedShowList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];

            
            if(!formattedShowList) {
                NSLog(@"Error parsing JSON: %@", e);
            }else{
                NSArray* allShows = formattedShowList[@"showList"];
                _showArray = [[NSMutableArray alloc] init];
                for(int i = 0; i < allShows.count; i++){
                    [self setCurrentShow:[[ShowScores alloc] init]];
                    [_currentShow createShow:allShows[i][@"organization"] showTitle:allShows[i][@"show"]];
                    [_showArray addObject:_currentShow];
                }
                
                [self setCurrentShow:_showArray[0]];
            }
        }else{
            NSLog(@"Server responded with error: %@", error);
        }
    }];
    
    [postDataTask resume];
}
}

@end
