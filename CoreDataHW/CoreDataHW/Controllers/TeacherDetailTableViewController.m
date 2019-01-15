//
//  TeacherDetailTableViewController.m
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 14/01/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "TeacherDetailTableViewController.h"

@interface TeacherDetailTableViewController ()

@end

@implementation TeacherDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Teacher Details/Editing";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherDetailCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Teachers name";
        cell.detailTextLabel.text = self.teacher.teacherName;
    } else {
        cell.textLabel.text = @"Subject";
        cell.detailTextLabel.text = self.teacher.subject;
    }
    return cell;
}

@end
