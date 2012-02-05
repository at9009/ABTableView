//
//  ABTableView.m
//  Easy Spend Log
//
//  Created by Aaron Bratcher on 05/14/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ABTableView.h"


@implementation ABTableView
@synthesize freezeHeaders;
@synthesize freezeLeftColumn;


- (id)init {
	return [self initWithFrame:CGRectZero];
}

- (id)initWithCoder:(NSCoder *)decoder {
	if((self = [super initWithCoder:decoder]))
		[self reset];
		
	return self;
}

- (id)initWithFrame:(CGRect)frame{
	if((self = [super initWithFrame:frame]))
		[self reset];
	
	return self;
}

- (void) reset {
	[visibleDataCells makeObjectsPerformSelector:@selector(removeFromSuperview)];
	[visibleColumnHeaders makeObjectsPerformSelector:@selector(removeFromSuperview)];
	
	
	visibleDataCells = [[NSMutableArray alloc] init];
	visibleColumnHeaders = [[NSMutableArray alloc] init];
	enqueuedCells = [[NSMutableDictionary alloc] init];
	columnsToShow = [[NSMutableArray alloc] initWithCapacity:6];
	rowsToShow = [[NSMutableArray alloc] initWithCapacity:20];
	
	maxEnqueued = 20;
	[self setNeedsLayout];
}




- (void) setDelegate:(id<ABTableViewDelegate>)new_delegate {
	if (delegate != new_delegate) {
		delegate = new_delegate;
		
		[self setNeedsLayout];
	}
}


- (ABTableViewCell *)getColumnHeader: (NSInteger) column {
	for (ABTableViewCell *header in visibleColumnHeaders) {
		if (header.column == column) {
			return header;
		}
	}
	 
	UITableViewCell *tc = [delegate tableView:self headerCellAtTableColumn:column];
	ABTableViewCell *cell = [[ABTableViewCell alloc] initWithUITableViewCell:tc tapDelegate:self];
	cell.reuseIdentifier = [tc reuseIdentifier];
	cell.column = column;
	cell.isHeader = YES;
	
	return cell;
}

- (ABTableViewCell *)getDataCellAtColumn: (NSInteger) column row: (NSInteger) row {
	for (ABTableViewCell* dataCell in visibleDataCells) {
		if (dataCell.column == column && dataCell.row == row) {
			return dataCell;
		}
	}
	
	UITableViewCell *dc = [delegate tableView:self dataCellAtTableColumn:column row:row];
	ABTableViewCell *cell = [[ABTableViewCell alloc] initWithUITableViewCell:dc tapDelegate:self];
	cell.reuseIdentifier = [dc reuseIdentifier];
	cell.column = column;
	cell.row = row;
	cell.isHeader = NO;
	
	return cell;
}

- (void) enqueueReusableCell: (ABTableViewCell *) cell {	
	NSMutableArray *cells;
	
	cells = [enqueuedCells objectForKey:cell.reuseIdentifier];
	if (cells) {
		if ([cells count] < maxEnqueued) {
			[cells addObject:cell];
		}
	} else {
		cells = [[NSMutableArray alloc] init];
		[cells addObject:cell];
		[enqueuedCells setObject:cells forKey:cell.reuseIdentifier];
	}
}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
	return nil;
	// problems with enqueued cells,  UILabel *categoryLabel = (UILabel*) [cell viewWithTag:1]; doesn't work from enqueued cells
	ABTableViewCell *cell;
	NSMutableArray *cells;
	
	cells = [enqueuedCells objectForKey:identifier];

	if(cells && [cells count] > 0) {
		cell = [cells objectAtIndex:0];
		[cells removeObject:cell];

		return cell.tableViewCell;
	}

	// key not found in dictionary or count == 0
	return nil;
}

- (void) layoutSubviews {
	if(!delegate)
		return;
	
	CGFloat headerHeight;
	CGFloat collectiveX = 0;
	CGFloat collectiveY = 0;
	CGFloat offsetX = self.contentOffset.x;
	CGFloat offsetY = self.contentOffset.y;
	CGFloat width = self.frame.size.width;
	CGFloat height = self.frame.size.height;
	
	int columns;
	int rows;
	int columnWidth;
	int rowHeight;
	int startX = -1;
	int startY = -1;
		
	columns = [delegate numberOfColumnsInTableView:self];
	rows = [delegate numberOfRowsInTableView:self];
	headerHeight = [delegate heightOfHeaderRowInTableView:self];
	
	// determine what columns to show. Keep track of all column widths for scroll area
	for (int index = 0; index < columns; index++) {
		columnWidth = [delegate tableView:self widthOfColumn:index];
		if (collectiveX >= offsetX-(columnWidth*2) && collectiveX <= (offsetX + width+columnWidth*2)) {
			[columnsToShow addObject: [[NSNumber alloc] initWithInt:index]];
			if (startX == -1) {
				startX = collectiveX;
			}
		}
		collectiveX += columnWidth;
	}
		
	// determine what rows to show. Keep track of all row heights for scroll area
	for (int index = 0; index < rows; index++) {
		rowHeight = [delegate tableView:self heightOfRow:index];
		if (collectiveY >= offsetY-(rowHeight*4) && collectiveY <= (offsetY + height+rowHeight*4)) {
			[rowsToShow addObject: [[NSNumber alloc] initWithInt:index]];
			if (startY == -1) {
				startY = collectiveY;
			}
		}
		collectiveY += rowHeight;
	}
		
	[self setContentSize:CGSizeMake(collectiveX,collectiveY+headerHeight)];
	
	collectiveX = startX;
	ABTableViewCell *cell;
	NSMutableArray *addedCells = [[NSMutableArray alloc] init];
	for (NSNumber *column in columnsToShow) {
		// header
		int currentColumn = [column intValue];
		columnWidth = [delegate tableView:self widthOfColumn:currentColumn];
		CGRect rect = CGRectMake(collectiveX, 0, columnWidth, [delegate heightOfHeaderRowInTableView:self]);
		cell = [self getColumnHeader:currentColumn];
		[cell setFrame:rect];
		[self insertSubview:cell.tableViewCell.contentView atIndex:0];		
		[self insertSubview:cell.tableViewCell.backgroundView atIndex:0];
		if(![visibleColumnHeaders containsObject:cell])
			[visibleColumnHeaders addObject:cell];
		
		[addedCells addObject:cell];
		
		collectiveY = startY;
		for (NSNumber *row in rowsToShow) {
			rowHeight = [delegate tableView:self heightOfRow:[row intValue]];
			// data cells
			cell = [self getDataCellAtColumn:[column intValue] row:[row intValue]];
			rect = CGRectMake(collectiveX, collectiveY, columnWidth, rowHeight);
			[cell setFrame:rect];
			[self insertSubview:cell.tableViewCell.contentView atIndex:0];
			if (cell.selectionView) {
				[self insertSubview:cell.selectionView atIndex:0];
			}
			[self insertSubview:cell.tableViewCell.backgroundView atIndex:0];
			if(![visibleDataCells containsObject:cell])
				[visibleDataCells addObject:cell];
			
			[addedCells addObject:cell];
			collectiveY += rowHeight;
		}
		
		collectiveX += columnWidth;
	}
	
	// remove header cells that have been scrolled off
	NSMutableArray* toRemove = [[NSMutableArray alloc] init];
	for (ABTableViewCell *cell in visibleColumnHeaders) {
		if (![addedCells containsObject:cell]) {
			[toRemove addObject:cell];
			[self enqueueReusableCell:cell];
		}
	}
	for (UITableViewCell *cell in toRemove) {
		[cell removeFromSuperview];
		[visibleColumnHeaders removeObject:cell];
	}
	[toRemove removeAllObjects];
	
	// remove data cells that have been scrolled off
	for (ABTableViewCell *cell in visibleDataCells) {
		if (![addedCells containsObject:cell]) {
			[toRemove addObject:cell];
			[self enqueueReusableCell:cell];
		}
	}
	for (ABTableViewCell *cell in toRemove) {
		[cell removeFromSuperview];
		[visibleDataCells removeObject:cell];
	}
	[toRemove removeAllObjects];
	
	[rowsToShow removeAllObjects];
	[columnsToShow removeAllObjects];
}

- (void) cellSelected: (ABTableViewCell*) cell {
	CGRect f = cell.tableViewCell.contentView.frame;
	
	UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(f.origin.x, f.origin.y, f.size.width, f.size.height)];
	CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.frame = myView.bounds;
//	gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:5 green:140 blue:245 alpha:1] CGColor], (id)[[UIColor blueColor] CGColor], nil];
	[myView.layer insertSublayer:gradient atIndex:0];
	cell.selectionView = myView;
	
	[self setNeedsLayout];
	
	if (cell.isHeader) {
		if([delegate respondsToSelector:@selector(tableView:didSelectTableColumn:)])
			[delegate tableView:self didSelectTableColumn:cell.column];
	}
	else
		if ([delegate respondsToSelector:@selector(tableView:dataCellAtTableColumn:row:)]) 
			[delegate tableView:(ABTableView *)self didSelectCellAtTableColumn: (NSInteger) cell.column row: (NSInteger) cell.row];

}

- (void) deselectColumn:(NSInteger) column animated: (BOOL) animated {
	
}

- (void) deselectCellAtColumn: (NSInteger) column row: (NSInteger) row animated: (BOOL) animated {
	for (ABTableViewCell *cell in visibleDataCells) {
		if (cell.column == column && cell.row == row && cell.selectionView) {
			if (animated) {
				[UIView animateWithDuration:.5
								  delay: 0
								options: UIViewAnimationOptionCurveEaseIn
							 animations:^{
								 cell.selectionView.alpha = 0.0;
							 }
							 completion:nil];
			}
			
			cell.selectionView = nil;
			cell.selected = NO;
			break;
		}
	}
}

@end
