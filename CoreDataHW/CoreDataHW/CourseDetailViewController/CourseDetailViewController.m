//
//  CourseDetailViewController.m
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 24/12/2018.
//  Copyright © 2018 n1ke71. All rights reserved.
//

#import "CourseDetailViewController.h"
#import "CourseDetailCell.h"
#import "UsersCourseCell.h"
#import "DataManager.h"
#import "User+CoreDataClass.h"
#import "UserDetailViewController.h"

@interface CourseDetailViewController ()
@property (strong,nonatomic) NSArray *firstSectionArray;
@property (strong,nonatomic) NSMutableArray *secondSectionArray;
@property (strong,nonatomic) NSArray *sectionsArray;
@property (strong,nonatomic) NSMutableArray *textFields;
@end

@implementation CourseDetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.tableView registerClass:[CourseDetailCell class] forCellReuseIdentifier:@"CourseDetailCell"];
        [self.tableView registerClass:[UsersCourseCell class] forCellReuseIdentifier:@"UsersCourseCell"];
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
    self.textFields = [NSMutableArray array];

    if(self.course){
        self.firstSectionArray = [NSArray arrayWithObjects:self.course.courseName,self.course.subject,self.course.sector,self.course.mentor,nil];
        self.secondSectionArray = [NSMutableArray arrayWithObjects:@"", nil];
        if ([[self.course.users allObjects] count] > 0) {
           [self.secondSectionArray addObjectsFromArray:[self.course.users allObjects]];
        }
        self.sectionsArray = [NSArray arrayWithObjects:self.firstSectionArray,self.secondSectionArray, nil];
    }else {
        self.firstSectionArray = [NSArray arrayWithObjects:@"",@"",@"",@"", nil];
        self.secondSectionArray = [NSMutableArray arrayWithObjects:@"", nil];
        self.sectionsArray = [NSArray arrayWithObjects:self.firstSectionArray,self.secondSectionArray, nil];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    UITextField *textField = [self.textFields objectAtIndex:CourseAttributeCourseName];
    [textField becomeFirstResponder];
}

#pragma mark - Actions

- (void)saveItem:(UIBarButtonItem *) sender {
    
    if (!self.course) {
        
        Course *course = [NSEntityDescription insertNewObjectForEntityForName:@"Course"
                                                   inManagedObjectContext:[DataManager sharedManager].persistentContainer.viewContext];

        course.courseName = [self textFieldWithAttribute:CourseAttributeCourseName];
        course.subject = [self textFieldWithAttribute:CourseAttributeSubject];
        course.sector = [self textFieldWithAttribute:CourseAttributeSector];
        course.mentor = [self textFieldWithAttribute:CourseAttributeMentor];
        [[DataManager sharedManager]saveContext];
        
    }else{
        self.course.courseName = [self textFieldWithAttribute:CourseAttributeCourseName];
        self.course.subject = [self textFieldWithAttribute:CourseAttributeSubject];
        self.course.sector = [self textFieldWithAttribute:CourseAttributeSector];
        self.course.mentor = [self textFieldWithAttribute:CourseAttributeMentor];
        [[DataManager sharedManager]saveContext];
    }
}

#pragma mark - Actions

- (NSString *)attributeName:(CourseAttribute) attribute{
    switch (attribute) {
        case CourseAttributeCourseName:
            return @"Course Name";
            break;
        case CourseAttributeSubject:
            return @"Subject";
            break;
        case CourseAttributeSector:
            return @"Sector";
            break;
        case CourseAttributeMentor:
            return @"Mentor";
            break;
        default:
            break;
    }
}

- (NSString *)textFieldWithAttribute:(CourseAttribute) attribute{
    
    UITextField *textField = nil;

    switch (attribute) {
        case CourseAttributeCourseName:
            textField = [self.textFields objectAtIndex:CourseAttributeCourseName];
            return textField.text;
            break;
        case CourseAttributeSubject:
            textField = [self.textFields objectAtIndex:CourseAttributeSubject];
            return textField.text;
            break;
        case CourseAttributeSector:
            textField = [self.textFields objectAtIndex:CourseAttributeMentor];
            return textField.text;
            break;
        case CourseAttributeMentor:
            textField = [self.textFields objectAtIndex:CourseAttributeMentor];
            return textField.text;
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section ? @"Users list":@"Course editing";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.sectionsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = [self.sectionsArray objectAtIndex:section];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CourseDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"CourseDetailCell" forIndexPath:indexPath];
    UsersCourseCell *usersCell = [tableView dequeueReusableCellWithIdentifier:@"UsersCourseCell" forIndexPath:indexPath];

    if (indexPath.section == 0) {
        detailCell.detailText.text = [self attributeName: (CourseAttribute)indexPath.row];
        detailCell.detailTextField.text = [self.firstSectionArray objectAtIndex:indexPath.row];
        [self.textFields addObject:detailCell.detailTextField];
        return detailCell;
    }
    if (indexPath.section == 1){
       if (indexPath.row == 0) {
           UIFont *font = [UIFont boldSystemFontOfSize:25.0];
           usersCell.detailText.font = font;
           usersCell.detailText.text = @"Tap to add user";
            return usersCell;
       }
       if (indexPath.row > 0) {
           usersCell.detailText.textAlignment = NSTextAlignmentLeft;
           NSArray *array = [self.sectionsArray objectAtIndex:indexPath.section];
           User *currentUser = [array objectAtIndex:indexPath.row];
           if (currentUser) {
               usersCell.accessoryType = UITableViewCellAccessoryCheckmark;
               usersCell.detailText.text = [NSString stringWithFormat:@"%@ %@",currentUser.firstName,currentUser.lastName];
           }
               return usersCell;
       }
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *array = [self.sectionsArray objectAtIndex:indexPath.section];
    User *currentUser = [array objectAtIndex:indexPath.row];
    
    if(indexPath.section == 1){
    if (indexPath.row == 0){
        NSFetchRequest<User *> *fetchRequest = [[NSFetchRequest alloc]init];
        NSEntityDescription *description = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[DataManager sharedManager].persistentContainer.viewContext];
        [fetchRequest setEntity:description];
        
        NSError *error;
        NSArray *fetchedObjects = [[DataManager sharedManager].persistentContainer.viewContext executeFetchRequest:fetchRequest error:&error];
        
        for (User *user in fetchedObjects)
        {
            if (![user.course containsObject:self.course] ) {
                [self.course addUsersObject:user];
                [[DataManager sharedManager]saveContext];
                [self viewDidLoad];
                [tableView reloadData];
                break;
            }
        }
  
    } else{
        [self performSegueWithIdentifier:@"FromCourseDetailViewController" sender:currentUser];
    }

    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSArray *array = [self.sectionsArray objectAtIndex:indexPath.section];
        User *currentUser = [array objectAtIndex:indexPath.row];
        [self.course removeUsersObject:currentUser];
        [[DataManager sharedManager]saveContext];
        [self viewDidLoad];
        [tableView reloadData];
    }
}
#pragma mark - Segues

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[UserDetailViewController class]]) {
        UserDetailViewController* userdetailTableViewController = segue.destinationViewController;
        userdetailTableViewController.user = sender;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



@end
