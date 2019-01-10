//
//  CourseDetailTableViewController.m
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 05/01/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "CourseDetailTableViewController.h"
#import "CourseDetailCell.h"
#import "DataManager.h"
#import "SelectionViewController.h"

@interface CourseDetailTableViewController () <SelectionViewControllerDelegate>
@property (strong,nonatomic)  NSArray *users;
@property (strong, nonatomic) UITextField* courseNameTextField;
@property (strong, nonatomic) UITextField* subjectTextField;
@property (strong, nonatomic) UITextField* sectorNameTextField;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* subject;
@property (strong, nonatomic) NSString* sector;
@property (strong, nonatomic) NSString* mentor;
@property (strong,nonatomic)  NSMutableArray *selectedUsers;
@end

@implementation CourseDetailTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.tableView registerClass:[CourseDetailCell class] forCellReuseIdentifier:@"CourseDetailCell"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Course Details";
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                              target:self
                                                                              action:@selector(saveItem:)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    self.name = self.course.courseName;
    self.subject = self.course.subject;
    self.sector = self.course.sector;
    self.mentor = self.course.mentor;
    
    if (self.course) {
        self.users = [NSMutableArray arrayWithArray:[self.course.users allObjects]];
    } else {
        self.users = [NSMutableArray array];
        self.selectedUsers = [NSMutableArray array];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (self.course) {
        self.users = [NSArray arrayWithArray:[self.course.users allObjects]];
    } else {
        self.users = [NSArray arrayWithArray:self.selectedUsers];
    }
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    self.selectionType = DetailSelectionTypeNone;
    [self.courseNameTextField  becomeFirstResponder];
}

#pragma mark - Actions

- (void)saveItem:(UIBarButtonItem *) sender {
    
    
    if ((!self.name) | (!self.sector) | (!self.mentor) | (!self.subject)) {
        return;
    }
    
    
    if (!self.course) {
        
        Course *course = [NSEntityDescription insertNewObjectForEntityForName:@"Course"
                                                       inManagedObjectContext:[DataManager sharedManager].persistentContainer.viewContext];
        
        course.courseName = self.name;
        course.subject = self.subject;
        course.sector = self.sector;
        course.mentor = self.mentor;
        course.users = [NSSet setWithArray:self.selectedUsers];
        [[DataManager sharedManager]saveContext];
        
    }else{
        self.course.courseName = self.name;
        self.course.subject = self.subject;
        self.course.sector = self.sector;
        self.course.mentor = self.mentor;
        [[DataManager sharedManager]saveContext];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - SelectionViewControllerDelegate

- (void) didSelectMentor:(User *)user{
    self.mentor = [NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName];
    [self.tableView reloadData];
}

- (void) didSelectUser:(NSMutableArray *)users{
    self.selectedUsers = users;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? [self.users count] + 1 : 4;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section ? @"Users list" : @"Course editing";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CourseDetailCell *courseDetailCell = [tableView dequeueReusableCellWithIdentifier:@"CourseDetailCell" forIndexPath:indexPath];
    UITableViewCell *courseCell = [tableView dequeueReusableCellWithIdentifier:@"CourseCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            courseDetailCell.detailText.text = @"Course Name";
            courseDetailCell.detailTextField.text = self.name;
            self.courseNameTextField = courseDetailCell.detailTextField;
            return courseDetailCell;
        }
        if (indexPath.row == 1) {
            courseDetailCell.detailText.text = @"Subject";
            courseDetailCell.detailTextField.text = self.subject;
            self.subjectTextField = courseDetailCell.detailTextField;
            return courseDetailCell;
        }
        if (indexPath.row == 2) {
            courseDetailCell.detailText.text = @"Sector";
            courseDetailCell.detailTextField.text = self.sector;
            self.sectorNameTextField = courseDetailCell.detailTextField;
            return courseDetailCell;
        }
        if (indexPath.row == 3) {
            if (self.mentor) {
                courseCell.textLabel.textAlignment = NSTextAlignmentLeft;
                courseCell.textLabel.text = [NSString stringWithFormat:@"Mentor %@",self.mentor];
                courseCell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                courseCell.textLabel.textAlignment = NSTextAlignmentCenter;
                courseCell.textLabel.text = @"Add Mentor";
            }
            return courseCell;
        }

        return courseDetailCell;
    }else {
        
        if (indexPath.row == 0) {
            courseCell.textLabel.text = @"Add User";
        }else {
                if([self.users count] > 0){
                User *user = [self.users objectAtIndex:indexPath.row - 1];
                courseCell.textLabel.text = [NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName];
                courseCell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        return courseCell;
    }
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            self.selectionType = DetailSelectionTypeMentor;
            self.name = self.courseNameTextField.text;
            self.subject = self.subjectTextField.text;
            self.sector = self.sectorNameTextField.text;
            [self performSegueWithIdentifier:@"SelectionViewController" sender:self.course];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            self.selectionType = DetailSelectionTypeUser;
            [self performSegueWithIdentifier:@"SelectionViewController" sender:self.course];
        }
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.destinationViewController isKindOfClass:[SelectionViewController class]]) {
        SelectionViewController* selectionViewController = segue.destinationViewController;
        selectionViewController.currentCourse = sender;
        selectionViewController.selectionType = (SelectionType)self.selectionType;
        selectionViewController.currentCourse.mentor = self.mentor;
        selectionViewController.delegate = self;
    }
}


@end
