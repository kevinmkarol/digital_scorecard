//
//  DetailViewController.m
//  greekSingScoring
//
//  Created by Kevin Karol on 1/16/14.
//  Copyright (c) 2014 Kevin Karol. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterShowArray.h"
#import "ShowScores.h"
#import "Reachability.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *displayShow;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end


@implementation DetailViewController
@synthesize detailDescriptionLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}



- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = @"Shows";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}



/**
*   When a new show is selected in the MasterViewController, update the visible indicators
*   to reflect the previously input scores for that show.
**/

-(void) didSelectShow:(ShowScores *)show
{
    [self.masterPopoverController dismissPopoverAnimated:YES];
    
    MasterShowArray *shared = [MasterShowArray sharedManager];
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        [shared sendScores];
    }
    
    shared.currentShow = show;
    
    NSMutableDictionary<NSString*, UISegmentedControl*>* controls = [shared scoreControls];
    
    
    //reset all controls to appropriate values
    for(NSString* key in controls){
      if(controls[key] != nil){
        controls[key].selectedSegmentIndex = [show getScoreForControlID:key];
      }
    }
    
    _displayShow.text = show.showName;
    
}

#pragma mark Methods to Update Segmented Display

//First Row

- (IBAction)sync:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.sync = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"sync"] = ((UISegmentedControl *)sender);
}
- (IBAction)enunc:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.enunc = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"enunc"] = ((UISegmentedControl *)sender);
}

- (IBAction)characters:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.characters = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"characters"] = ((UISegmentedControl *)sender);
}
- (IBAction)transitions:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.transitions = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"transitions"] = ((UISegmentedControl *)sender);
}
- (IBAction)flow:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.flow = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"flow"] = ((UISegmentedControl *)sender);
}


//Production Values
- (IBAction)setAesthetics:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.setAesthetics = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"setAesthetics"] = ((UISegmentedControl *)sender);
}

- (IBAction)setInteractions:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.setInteractions = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"setInteractions"] = ((UISegmentedControl *)sender);
}
- (IBAction)costumes:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.costumes = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"costumes"] = ((UISegmentedControl *)sender);
}



//Story
- (IBAction)story:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.story = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"story"] = ((UISegmentedControl *)sender);
}
- (IBAction)script:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.script = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"script"] = ((UISegmentedControl *)sender);
}
- (IBAction)acting:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.acting = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"acting"] = ((UISegmentedControl *)sender);
}



//Musical Elements
- (IBAction)groupVocals:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.groupVocals = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"groupVocals"] = ((UISegmentedControl *)sender);
}

- (IBAction)band:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.band = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"band"] = ((UISegmentedControl *)sender);
}
- (IBAction)featuredVocals:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.featuredVocals = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"featuredVocals"] = ((UISegmentedControl *)sender);
}

//Choreography
- (IBAction)choreographyImpressiveness:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.choreographyImpressivness = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"choreographyImpressivness"] = ((UISegmentedControl *)sender);
}

- (IBAction)choreographyExecution:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.choreographyExecutaion = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"choreographyExecution"] = ((UISegmentedControl *)sender);
}



//General
- (IBAction)energy:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.energy = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"energy"] = ((UISegmentedControl *)sender);
}

- (IBAction)entertainmentValue:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.entertainmentValue = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"entertainmentValue"] = ((UISegmentedControl *)sender);
}

- (IBAction)overallImpression:(id)sender {
    MasterShowArray *shared = [MasterShowArray sharedManager];
    shared.currentShow.overallImpression = (((UISegmentedControl *)sender).selectedSegmentIndex);
    shared.scoreControls[@"overallImpression"] = ((UISegmentedControl *)sender);
}

@end