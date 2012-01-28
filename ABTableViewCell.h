//
//  ABTableViewCell.h
//  Easy Spend Log
//
//  Created by Aaron Bratcher on 05/17/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ABTableView;

@protocol ABTableViewCellDelegate;

@interface ABTableViewCell : NSObject {
	NSInteger		row;
	NSInteger		column;
	UITableViewCell	*tableViewCell;
	NSString		*reuseIdentifier;
	UIView			*selectionView;
	BOOL			selected;
	BOOL			isHeader;
	id <ABTableViewCellDelegate> tapDelegate;
}

@property (assign) NSInteger row;
@property (assign) NSInteger column;
@property (nonatomic, retain) UITableViewCell *tableViewCell;
@property (nonatomic, retain) NSString *reuseIdentifier;
@property (nonatomic, retain) UIView *selectionView;
@property (assign) BOOL selected;
@property (assign) BOOL isHeader;

-(id) initWithUITableViewCell: (UITableViewCell *) tableCell tapDelegate:(id<ABTableViewCellDelegate>) new_delegate;
-(void) setFrame: (CGRect) rect;
-(void) removeFromSuperview;
-(void) cellSelected: (UITapGestureRecognizer *)tapGesture;
@end


@protocol ABTableViewCellDelegate <NSObject>

- (void) cellSelected: (ABTableViewCell*) cell;

@end