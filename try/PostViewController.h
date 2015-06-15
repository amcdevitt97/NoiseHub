//
//  PostViewController.h
//  openPost
//
//  Created by Caleb Linburg on 4/23/15.
//  Copyright (c) 2015 Alyssa McDevitt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end
