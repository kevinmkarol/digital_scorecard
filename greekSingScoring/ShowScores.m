//
//  ShowScores.m
//  greekSingScoring
//
//  Created by Kevin Karol on 3/16/14.
//  Copyright (c) 2014 Kevin Karol. All rights reserved.
//

#import "ShowScores.h"

@implementation ShowScores

-(void) createShow:(NSString *)orgName showTitle:(NSString *)showName{
    _organizationName = orgName;
    _showName = showName;

    //first 10 initialized to 1 to accomodate mod if none selected
    _enunc = 1;
    _acting = 1;
    _characters = 1;
    _transitions = 1;
    _flow = 1;
    
    //back to not weird mod scoring - fix weirdness in later version
    _setAesthetics = 0;
    _setInteractions = 0;
    _costumes = 0;
    
    _story = 0;
    _script = 0;
    _acting = 0;
    
    _groupVocals = 0;
    _featuredVocals = 0;
    _band = 0;
    
    _choreographyImpressivness = 0;
    _choreographyExecutaion = 0;
    
    _energy = 0;
    _entertainmentValue = 0;
    _overallImpression = 0;
    
}


-(NSInteger) getScoreForControl:(NSString*) controlKey{
  NSInteger score = 0;
  if([controlKey isEqualToString:@"sync"]){
    score = self.sync;
  }else if([controlKey isEqualToString:@"enunc"]){
    score = self.enunc;
  }else if([controlKey isEqualToString:@"characters"]){
    score = self.characters;
  }else if([controlKey isEqualToString:@"transitions"]){
    score = self.transitions;
  }else if([controlKey isEqualToString:@"flow"]){
    score = self.flow;
  }else if([controlKey isEqualToString:@"setAesthetics"]){
    score = self.setAesthetics;
  }else if([controlKey isEqualToString:@"setInteractions"]){
    score = self.setInteractions;
  }else if([controlKey isEqualToString:@"costumes"]){
    score = self.costumes;
  }else if([controlKey isEqualToString:@"story"]){
    score = self.story;
  }else if([controlKey isEqualToString:@"script"]){
    score = self.script;
  }else if([controlKey isEqualToString:@"acting"]){
    score = self.acting;
  }else if([controlKey isEqualToString:@"groupVocals"]){
    score = self.groupVocals;
  }else if([controlKey isEqualToString:@"featuredVocals"]){
    score = self.featuredVocals;
  }else if([controlKey isEqualToString:@"band"]){
    score = self.band;
  }else if([controlKey isEqualToString:@"choreographyImpressivness"]){
    score = self.choreographyImpressivness;
  }else if([controlKey isEqualToString:@"choreographyExecution"]){
    score = self.choreographyExecutaion;
  }else if([controlKey isEqualToString:@"energy"]){
    score = self.energy;
  }else if([controlKey isEqualToString:@"entertainmentValue"]){
    score = self.entertainmentValue;
  }else if([controlKey isEqualToString:@"overallImpression"]){
    score = self.overallImpression;
  }

  return score;
}

-(NSMutableDictionary*) serialize{
    //includes reversing good/bad w/ mod
    NSMutableDictionary *propDict = [[NSMutableDictionary alloc] initWithCapacity:25];
    [propDict setObject:_organizationName forKey:@"orgName"];
    
    [propDict setObject:[NSNumber numberWithInt:((_enunc + 1) % 2)] forKey:@"enunc"];
    [propDict setObject:[NSNumber numberWithInt:((_acting + 1) % 2)] forKey:@"pacing"];
    [propDict setObject:[NSNumber numberWithInt:((_characters + 1) % 2)] forKey:@"characters"];
    [propDict setObject:[NSNumber numberWithInt:((_transitions + 1) % 2)] forKey:@"transitions"];
    [propDict setObject:[NSNumber numberWithInt:((_flow + 1) % 2)] forKey:@"flow"];
    
    [propDict setObject:[NSNumber numberWithLong:_setAesthetics] forKey:@"setAesthetics"];
    [propDict setObject:[NSNumber numberWithLong:_setInteractions] forKey:@"setInteractions"];
    [propDict setObject:[NSNumber numberWithLong:_costumes] forKey:@"costumes"];
    
    [propDict setObject:[NSNumber numberWithLong:_story] forKey:@"story"];
    [propDict setObject:[NSNumber numberWithLong:_script] forKey:@"script"];
    [propDict setObject:[NSNumber numberWithLong:_acting] forKey:@"acting"];
    
    [propDict setObject:[NSNumber numberWithLong:_groupVocals] forKey:@"groupVocals"];
    [propDict setObject:[NSNumber numberWithLong:_band] forKey:@"band"];
    [propDict setObject:[NSNumber numberWithLong:_featuredVocals] forKey:@"featuredVocals"];
    
    [propDict setObject:[NSNumber numberWithLong:_choreographyImpressivness] forKey:@"choreographyImpressivness"];
    [propDict setObject:[NSNumber numberWithLong:_choreographyExecutaion] forKey:@"choreographiExecution"];
    
    [propDict setObject:[NSNumber numberWithLong:_energy] forKey:@"energy"];
    [propDict setObject:[NSNumber numberWithLong:_entertainmentValue] forKey:@"entertainmentValue"];
    [propDict setObject:[NSNumber numberWithLong:_overallImpression] forKey:@"overallImpression"];

    return propDict;
}


@end
