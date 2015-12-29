//
//  DetailViewController.h
//  greekSingScoring
//
//  Created by Kevin Karol on 1/16/14.
//  Copyright (c) 2014 Kevin Karol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

-(void) didSelectShow:(ShowScores *)show;

@end
