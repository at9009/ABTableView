//
//  ABNumberTable.m
//  Easy Spend Log
//
//  Created by Aaron Bratcher on 05/21/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ABNumberTable.h"

@implementation ABNumberTable

- (id)init
{
    self = [super init];
    if (self) {
        columnAmounts = [[NSMutableArray alloc] init];
		rows = -1;
    }
    
    return self;
}



- (void) setAmount: (NSNumber*) amount atColumn: (NSInteger) column row: (NSInteger) row {
	while ([columnAmounts count] < column+1) {
		[columnAmounts addObject:[[NSMutableArray alloc] init]];
	}
	
	NSMutableArray *rowAmounts = [columnAmounts objectAtIndex:column];
	while ([rowAmounts count] < row+1) {
		[rowAmounts addObject:[[NSNumber alloc] initWithDouble:0]];
	}
	
	[rowAmounts replaceObjectAtIndex:row withObject:amount];
	
	if (row > rows) {
		rows = row;
	}
}

- (NSNumber *) getAmountAtColumn: (NSInteger) column row: (NSInteger) row {
	while ([columnAmounts count] < column+1) {
		[columnAmounts addObject:[[NSMutableArray alloc] init]];
	}
	
	NSMutableArray *rowAmounts = [columnAmounts objectAtIndex:column];
	while ([rowAmounts count] < row+1) {
		[rowAmounts addObject:[[NSNumber alloc] initWithDouble:0]];
	}
	
	if (row > rows) {
		rows = row;
	}
	
	return [rowAmounts objectAtIndex:row];
}

- (NSInteger) columns {
	return [columnAmounts count];
}

- (NSInteger) rows {
	return rows+1;
}

@end
