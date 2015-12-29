//
//  MasterViewController.m
//  greekSingScoring
//
//  Created by Kevin Karol on 1/16/14.
//  Copyright (c) 2014 Kevin Karol. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ShowScores.h"
#import "MasterShowArray.h"



@interface MasterViewController () {
    NSMutableArray *_objects;

}
@end

@implementation MasterViewController
@synthesize showList;

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MasterShowArray* allShows =[MasterShowArray sharedManager];
    NSArray* showArray = [allShows showArray];
    int count = 0;
    if(showArray !=nil){
        count = [showArray count];
    }
    return count;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString* sectionTitle = @"Show List";
    return sectionTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *title = @"";
    NSString *subtitle = @"";
    
    MasterShowArray *shared = [MasterShowArray sharedManager];
    NSArray *allShows = shared.showArray;
    
    int row = [indexPath row];
    ShowScores *current =(ShowScores *)allShows[row];
    title = current.showName;
    subtitle = current.organizationName;
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = subtitle;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MasterShowArray *shared = [MasterShowArray sharedManager];
    NSMutableArray *allShows = shared.showArray;
    
    ShowScores *selectedShow;
    if([indexPath section] == 0) {
        selectedShow = [allShows objectAtIndex:[indexPath row]];
    }
    else if(indexPath.section == 1){
        selectedShow = [allShows objectAtIndex:([indexPath row] + 5)];
    }
    
    [self.delegate didSelectShow:selectedShow];
    
}

@end
