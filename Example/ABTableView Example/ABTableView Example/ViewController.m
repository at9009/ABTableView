//
//  ViewController.m
//  ABTableView Example
//
//  Created by Aaron Bratcher on 01/30/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize scrollView;

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	NSMutableArray *categories = [[NSMutableArray alloc] initWithCapacity:30];
	NSMutableArray *monthNames = [[NSMutableArray alloc] initWithCapacity:12];
	NSMutableArray *months = [[NSMutableArray alloc] initWithCapacity:12];
	
	summary = [[SummaryMatrix alloc] init];
	summary.categories = categories;
	summary.monthNames = monthNames;
	summary.months = months;

	
	// fill in some dummy data
	[categories addObject:@"Auto Maintenance"];
	[categories addObject:@"Auto/Transportation"];
	[categories addObject:@"Clothing"];
	[categories addObject:@"Debt"];
	[categories addObject:@"Education/Day Care"];
	[categories addObject:@"Eating Out"];
	[categories addObject:@"Entertainment"];
	[categories addObject:@"Food"];
	[categories addObject:@"Gas"];
	[categories addObject:@"Health/Beauty"];
	[categories addObject:@"Home Maintenance"];
	[categories addObject:@"Insurance"];
	[categories addObject:@"Medical/Dental"];
	[categories addObject:@"Miscellaneous"];
	[categories addObject:@"Rent/Mortgage"];
	[categories addObject:@"Saving/Investment"];
	[categories addObject:@"Taxes"];
	[categories addObject:@"Tithing/Charity"];
	[categories addObject:@"Utilities"];
	[categories addObject:@"U2"];
	[categories addObject:@"U3"];
	[categories addObject:@"U4"];
	[categories addObject:@"U5"];
	[categories addObject:@"U6"];
	[categories addObject:@"U7"];
	[categories addObject:@"U8"];
	[categories addObject:@"U9"];
	[categories addObject:@"U10"];
	[categories addObject:@"U11"];
	[categories addObject:@"U12"];
	[categories addObject:@"U13"];
	[categories addObject:@"U14"];
	[categories addObject:@"U15"];
	[categories addObject:@"U16"];
	[categories addObject:@"U17"];
	[categories addObject:@"U18"];
	[categories addObject:@"U19"];
	[categories addObject:@"U20"];
	[categories addObject:@"U21"];
	[categories addObject:@"U22"];
	[categories addObject:@"U23"];
	[categories addObject:@"U24"];
	[categories addObject:@"U25"];
	[categories addObject:@"U26"];
	[categories addObject:@"U27"];
	[categories addObject:@"U28"];
	[categories addObject:@"U29"];
	[categories addObject:@"U30"];
	[categories addObject:@"U31"];
	[categories addObject:@"U32"];
	[categories addObject:@"U33"];
	[categories addObject:@"U34"];
	[categories addObject:@"Total"];
	
	[monthNames addObject:@"Jan 2009"];
	[monthNames addObject:@"Feb 2009"];
	[monthNames addObject:@"Mar 2009"];
	[monthNames addObject:@"Apr 2009"];
	[monthNames addObject:@"May 2009"];
	[monthNames addObject:@"Jun 2009"];
	[monthNames addObject:@"Jul 2009"];
	[monthNames addObject:@"Aug 2009"];
	[monthNames addObject:@"Sep 2009"];
	[monthNames addObject:@"Oct 2009"];
	[monthNames addObject:@"Nov 2009"];
	[monthNames addObject:@"Dec 2009"];
	[monthNames addObject:@"Jan 2010"];
	[monthNames addObject:@"Feb 2010"];
	[monthNames addObject:@"Mar 2010"];
	[monthNames addObject:@"Apr 2010"];
	[monthNames addObject:@"May 2010"];
	[monthNames addObject:@"Jun 2010"];
	[monthNames addObject:@"Jul 2010"];
	[monthNames addObject:@"Aug 2010"];
	[monthNames addObject:@"Sep 2010"];
	[monthNames addObject:@"Oct 2010"];
	[monthNames addObject:@"Nov 2010"];
	[monthNames addObject:@"Dec 2010"];
	[monthNames addObject:@"Total"];
	
	double amount = 0;
	double cellValue = 0;
	for (int column = 0; column < [summary.monthNames count]-1; column++) {
		amount = 0;
		for (int row = 0; row < [summary.categories count]-1; row++) {
			cellValue = (column+1)*(row+1);
			amount += cellValue;
		}
		[summary.amounts setAmount:[[NSNumber alloc] initWithDouble:amount] atColumn:column row:[categories count]-1];
	}
}

- (void)viewDidUnload
{
	[self setScrollView:nil];
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[scrollView setDelegate:self];
	[scrollView reset];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (NSInteger) numberOfRowsInTableView:(ABTableView *)tableView {
	return [summary.categories count];
}

- (NSInteger) numberOfColumnsInTableView:(ABTableView *)tableView {
	return [summary.monthNames count]+1;
}

- (CGFloat) tableView:(ABTableView *)tableView heightOfRow: (NSInteger) row {
	return 23;
}

- (CGFloat) tableView:(ABTableView *)tableView widthOfColumn: (NSInteger)column {
	return (column == 0 ? 115 : 100);
}

- (CGFloat) heightOfHeaderRowInTableView:(ABTableView *)tableView {
	return 23;
}

-(UITableViewCell *)tableView:(ABTableView *)tableView dataCellAtTableColumn: (NSInteger) column row: (NSInteger) row {
	NSString *resultsCategory = [summary.categories objectAtIndex:row];
	
	UITableViewCell *cell;
	if (column == 0) {
		NSString *cellIdentifier = @"CategoryCell";
		
		cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
		
		if (!cell) {
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
			cell = (UITableViewCell *)[nib objectAtIndex:0];
		}
		
		
		UILabel *categoryLabel = (UILabel*) [cell viewWithTag:1]; 
		categoryLabel.text = resultsCategory;
		
	} else {
		NSString *cellIdentifier = @"SummaryDataCell";
		
		cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
		
		
		if (!cell) {
			NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
			cell = (UITableViewCell *)[nib objectAtIndex:0];
		}
		
		
		UILabel *amountLabel = (UILabel*) [cell viewWithTag:1]; 
		
		
		NSNumber *amountObject = [summary.amounts getAmountAtColumn:column-1 row:row];
		if ([amountObject doubleValue] == 0) {
			amountLabel.text = @"";
		}
		else {
			NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
			[numberFormatter setNumberStyle: NSNumberFormatterCurrencyStyle];
			[numberFormatter setMaximumFractionDigits:2];
			[numberFormatter setCurrencySymbol:@""];
			NSString *numberAsString = [numberFormatter stringFromNumber:amountObject];
			
			amountLabel.text = numberAsString;
		}		
	}
	
	UIView *myView = [[UIView alloc] init];
	if (row == [summary.categories count]-1 || column == [summary.monthNames count] ) {
		myView.backgroundColor = [UIColor redColor];
		myView.alpha = .2;
	} else {
		if ((row % 2) == 0) {
			myView.backgroundColor = [UIColor greenColor];
			myView.alpha = .2;
		}
		else {
			myView.backgroundColor = [UIColor whiteColor];
			myView.alpha = 1;
		}
	}
	
	cell.backgroundView = myView;
	
	return cell;
}

-(UITableViewCell *)tableView:(ABTableView *)tableView headerCellAtTableColumn: (NSInteger) column{
	NSString *cellIdentifier = @"HeaderCell";
	UITableViewCell *cell;
	
	cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (!cell) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
		cell = (UITableViewCell *)[nib objectAtIndex:0];
	}
	
	UILabel *label = (UILabel*) [cell viewWithTag:1];
	if (column == 0) {
		label.text = @"Category";
		CGRect newFrame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 125, cell.frame.size.height);
		cell.frame = newFrame;
	}
	else {
		label.text = [summary.monthNames objectAtIndex:column-1];
		CGRect newFrame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, 100, cell.frame.size.height);
		cell.frame = newFrame;
	}
	
	return cell;
}

@end
