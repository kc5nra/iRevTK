//
//  RTKBoxesViewController.m
//  RevTK
//
//  Created by John Bradley on 4/1/10.
//  Copyright 2010 J. Bradley & Associates, LLC. All rights reserved.
//

#import "RTKBoxesViewController.h"
#import "RTKBoxes.h"
#import "RTKSimpleBox.h"
#import "RTKBoxGraphView.h"
#import "RTKManager.h"
#import "RTKBadgedTableViewCell.h"

@implementation RTKBoxesViewController

#pragma mark -
#pragma mark UITableViewControllerDelegate Methods

- (UITableViewCell *)
tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    RTKBadgedTableViewCell *cell = 
		[[[RTKBadgedTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    
	
	cell.textLabel.text = @"Test";
	cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.badgeNumber = 64;

	cell.badgeColor = [UIColor colorWithRed:1.000 green:0.397 blue:0.419 alpha:1.000];
	
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
		return 3;
	} else {
		return 2;
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[self boxes] boxes] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	// Create label with section title
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.shadowColor = [UIColor grayColor];
    label.shadowOffset = CGSizeMake(0.0, 1.0);
    label.font = [UIFont boldSystemFontOfSize:16];
    [label setTextAlignment: UITextAlignmentCenter];
	label.text = [NSString stringWithFormat: @"Box %d",[[[boxes boxes] objectAtIndex: section] boxId], nil];
	
    return label;
}

#pragma mark -
#pragma mark UIView Methods

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// retrieve the current box count from the manager
	[self setBoxes: [[RTKManager sharedManager] boxes]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

#pragma mark -
#pragma mark NSObject Methods

- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Synthesized Properties

@synthesize boxes;

@end
