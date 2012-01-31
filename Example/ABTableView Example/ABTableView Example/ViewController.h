//
//  ViewController.h
//  ABTableView Example
//
//  Created by Aaron Bratcher on 01/30/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ABTableView.h"
#import "SummaryMatrix.h"

@interface ViewController : UIViewController<ABTableViewDelegate> {
		SummaryMatrix *summary;
}

@property (weak, nonatomic) IBOutlet ABTableView *scrollView;

@end
