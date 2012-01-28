//
//  ABTableViewCell.m
//  Easy Spend Log
//
//  Created by Aaron Bratcher on 05/17/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ABTableViewCell.h"

@implementation ABTableViewCell
@synthesize row;
@synthesize column;
@synthesize reuseIdentifier;
@synthesize tableViewCell;
@synthesize selectionView;
@synthesize selected;
@synthesize isHeader;

- (id)initWithUITableViewCell: (UITableViewCell *) tableCell tapDelegate:(id<ABTableViewCellDelegate>) new_delegate {
    self = [super init];
    if (self) {
        self.tableViewCell = tableCell;
		if (new_delegate) {
			tapDelegate = new_delegate;
			UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellSelected:)];
			[self.tableViewCell.contentView addGestureRecognizer:tapGesture];
		}
    }
    return self;
}


-(void) setFrame: (CGRect) rect {
	[tableViewCell.contentView setFrame:rect];
	[tableViewCell.backgroundView setFrame:rect];}

-(void) removeFromSuperview {
	[tableViewCell.contentView removeFromSuperview];
	[tableViewCell.backgroundView removeFromSuperview];
}

- (void) cellSelected: (UITapGestureRecognizer *)tapGesture {
	if (tapDelegate && [tapDelegate respondsToSelector:@selector(cellSelected:)]) {
		[tapDelegate cellSelected:self];
	}
}

@end
