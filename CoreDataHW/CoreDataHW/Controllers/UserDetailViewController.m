//
//  DetailViewController.m
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 07/12/2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UserDetailCell.h"
#import "DataManager.h"
#import "Course+CoreDataClass.h"

@interface UserDetailViewController ()
@property (strong,nonatomic) NSArray *userAttributes;
@property (strong,nonatomic) NSArray *userStudyingCourses;
@property (strong,nonatomic) NSArray *userGuideingCourses;
@property (strong,nonatomic) NSMutableArray *sections;
@property (strong, nonatomic) UITextField* firstNameTextField;
@property (strong, nonatomic) UITextField* lastNameTextField;
@property (strong, nonatomic) UITextField* emailTextField;
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* email;
@end

@implementation UserDetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
         [self.tableView registerClass:[UserDetailCell class] forCellReuseIdentifier:@"UserDetailCell"];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"User Details/Editing";
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                             target:self
                                                                             action:@selector(saveItem:)];
    self.navigationItem.rightBarButtonItem = saveItem;
    

    
    if(self.user){
        
        self.firstName = self.user.firstName;
        self.lastName = self.user.lastName;
        self.email = self.user.email;
        
        self.userAttributes = [NSArray arrayWithObjects:self.user.firstName,self.user.lastName,self.user.email, nil];
        self.userStudyingCourses = [NSArray arrayWithArray:[self.user.course allObjects]];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setIncludesPropertyValues:YES];
        NSEntityDescription *description = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:[DataManager sharedManager].persistentContainer.viewContext];
        [fetchRequest setEntity:description];
        NSString *string = [NSString stringWithFormat:@"%@ %@",self.user.firstName,self.user.lastName];
        NSPredicate *predicate =  [NSPredicate predicateWithFormat:@"mentor = %@",string];
        [fetchRequest setPredicate:predicate];
        NSError *error;
        self.userGuideingCourses = [[DataManager sharedManager].persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
        self.sections = [NSMutableArray array];
    }else {

        self.userAttributes = [NSArray array];
        self.userStudyingCourses = [NSArray array];
        self.userGuideingCourses = [NSArray array];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    [self.firstNameTextField becomeFirstResponder];
}

#pragma mark - Actions

- (void)saveItem:(UIBarButtonItem *) sender {
    
        self.firstName = self.firstNameTextField.text;
        self.lastName = self.lastNameTextField.text;
        self.email = self.emailTextField.text;
    
    if (([self.firstName isEqualToString:@""]) | ([self.lastName isEqualToString:@""]) | ([self.email isEqualToString:@""])) {
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Empty text field"
                                                                       message:@"All fields must be filled in"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if (!self.user) {
        User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                   inManagedObjectContext:[DataManager sharedManager].persistentContainer.viewContext];
        user.firstName = self.firstName;
        user.lastName = self.lastName;
        user.email = self.email;
        [[DataManager sharedManager]saveContext];
    }else{
        self.user.firstName = self.firstName;
        self.user.lastName = self.lastName;
        self.user.email = self.email;
        [[DataManager sharedManager]saveContext];
    }
        [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *title = @"";
   
    if (section == 0) {
        title = @"User attributes";
    }  else {
        if ([self.userStudyingCourses count] > 0) {
            title = @"User studying";
        }
        if ([self.userGuideingCourses count] > 0) {
            title = @"User guideing";
        }
    }

    return title;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger numberOfSections = 1;
    if ([self.userStudyingCourses count] > 0) {
        return numberOfSections + 1;
    } else if ([self.userGuideingCourses count] > 0){
        return numberOfSections + 1;
    }
    return numberOfSections;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    [self.sections addObject:self.userAttributes];
    
    if (section == 0) {
       if ([self.userAttributes count] > 0) {
           return [self.userAttributes count];
       } else {
        return 3;
       }
    } else {
        if ([self.userStudyingCourses count] > 0) {
            [self.sections addObject:self.userStudyingCourses];
            return [self.userStudyingCourses count];
        } else {
            if ([self.userGuideingCourses count] > 0) {
                [self.sections addObject:self.userGuideingCourses];
                return [self.userGuideingCourses count];
            } else {
                return 0;
            }
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserDetailCell  *userDetailCell = [tableView dequeueReusableCellWithIdentifier:@"UserDetailCell" forIndexPath:indexPath];
    UITableViewCell *courseCell = [tableView dequeueReusableCellWithIdentifier:@"UserCourseCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            userDetailCell.detailText.text = @"First Name";
            userDetailCell.detailTextField.text = self.firstName;
            self.firstNameTextField = userDetailCell.detailTextField;
            return userDetailCell;
        }
        if (indexPath.row == 1) {
            userDetailCell.detailText.text = @"Last Name";
            userDetailCell.detailTextField.text = self.lastName;
            self.lastNameTextField = userDetailCell.detailTextField;
            return userDetailCell;
        }
        if (indexPath.row == 2) {
            userDetailCell.detailText.text = @"Email";
            userDetailCell.detailTextField.text = self.email;
            self.emailTextField = userDetailCell.detailTextField;
            return userDetailCell;
        }
    } else {
    if ([self.userStudyingCourses count] > 0) {
        Course *course = [self.userStudyingCourses objectAtIndex:indexPath.row];
        courseCell.textLabel.text = course.courseName;
    }
    if ([self.userGuideingCourses count] > 0) {
        Course *course = [self.userGuideingCourses objectAtIndex:indexPath.row];
        courseCell.textLabel.text = course.courseName;
    }
    }
    return courseCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
