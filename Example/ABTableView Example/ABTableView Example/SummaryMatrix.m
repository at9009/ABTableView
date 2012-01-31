//
//  SummaryMatrix.m
//  Easy Spend Log
//
//  Created by Aaron Bratcher on 05/20/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SummaryMatrix.h"

@implementation SummaryMatrix
@synthesize categories;
@synthesize monthNames;
@synthesize months;
@synthesize amounts;
@synthesize percents;

- (id)init
{
	self = [super init];
	if (self) {
		self.amounts = [[ABNumberTable alloc] init ];
		self.percents = [[ABNumberTable alloc] init];
	}
	
	return self;
}


@end
