//
//  MasterViewController.h
//  greekSingScoring
//
//  Created by Kevin Karol on 1/16/14.
//  Copyright (c) 2014 Kevin Karol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowScores.h"

@class DetailViewController;
@protocol ShowDelegate <NSObject>

-(void) didSelectShow:(ShowScores *) show;

@end



@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong,nonatomic) NSMutableArray *showList;

@property (nonatomic,retain) id<ShowDelegate> delegate;

@end
