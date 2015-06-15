//
//  PostViewController.m
//  openPost
//
//  Created by Caleb Linburg on 4/23/15.
//  Copyright (c) 2015 Alyssa McDevitt. All rights reserved.
//

#import "PostViewController.h"
#import "Parse/Parse.h"

@implementation PostViewController{
    NSArray* foundObjects;
}

#pragma mark table
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"BasicCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    PFObject *currentObject = [foundObjects objectAtIndex:indexPath.row];
    NSString *currentText = currentObject[@"text"];
    myCell.textLabel.text = currentText;
    return myCell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Row %i", indexPath.row);
    
    PFObject *currentObject = [foundObjects objectAtIndex:indexPath.row];
    NSString *currentText = currentObject[@"text"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Full Post"
                                                    message:currentText
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"posts"];
    [query whereKey:@"post" equalTo:@"true"];
    [query orderByDescending:@"createdAt"];
    query.limit = 21;
    foundObjects = [query findObjects];
    
    int testSize = foundObjects.count;
    
    NSLog(@"Size: %i", testSize);
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.myTableView addSubview:refreshControl];
}



- (void)refresh:(UIRefreshControl *)refreshControl {
    PFQuery *query = [PFQuery queryWithClassName:@"posts"];
    [query whereKey:@"post" equalTo:@"true"];
    [query orderByDescending:@"createdAt"];
    query.limit = 21;
    foundObjects = [query findObjects];
    
    [_myTableView reloadData];
    
    [refreshControl endRefreshing];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
