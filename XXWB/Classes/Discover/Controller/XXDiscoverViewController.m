//
//  XXDiscoverViewController.m
//  XXWB
//
//  Created by 刘超 on 14/12/15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "XXDiscoverViewController.h"
#import "XXSearBar.h"

@interface XXDiscoverViewController () <UITextFieldDelegate>

@end

@implementation XXDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加搜索框
    XXSearBar *searchBar = [[XXSearBar alloc] init];
    searchBar.delegate = self;
    searchBar.bounds = CGRectMake(0, 0, 300, 30);
    self.navigationItem.titleView = searchBar;
}

#pragma mark - UITextFieldDelegate method

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

@end
