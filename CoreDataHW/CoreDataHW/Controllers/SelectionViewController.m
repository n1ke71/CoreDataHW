//
//  SelectionViewController.m
//  CoreDataHW
//
//  Created by Kozaderov Ivan on 05/01/2019.
//  Copyright © 2019 n1ke71. All rights reserved.
//

#import "SelectionViewController.h"
#import "DataManager.h"
#import "CourseDetailTableViewController.h"

@interface SelectionViewController ()
@property (strong,nonatomic)  NSMutableArray *selectedUsers;
@end

@implementation SelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"User selection";
    self.selectedUsers = [NSMutableArray array];
}

#pragma mark - Actions

- (IBAction)doneAction:(UIBarButtonItem *)sender {
    self.selectionType = SelectionTypeNone;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectionCell" forIndexPath:indexPath];
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:user];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)configureCell:(UITableViewCell *)cell withObject:(User *)user {
    NSString *userText = [NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName];
    cell.textLabel.text = userText;
    
    if (self.selectionType == SelectionTypeUser){
        if (self.currentCourse) {
        if ([user.course containsObject:self.currentCourse]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        } else{
            if([self.selectedUsers containsObject:user]){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
    if (self.selectionType == SelectionTypeMentor){
        if (self.currentCourse) {
            if (self.currentCourse.mentor) {
                if ([self.currentCourse.mentor isEqualToString:userText]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
            }else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }

}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    User *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (self.selectionType == SelectionTypeUser) {
        if (self.currentCourse) {
            if (![user.course containsObject:self.currentCourse]) {
                [user addCourseObject:self.currentCourse];
                [self.currentCourse addUsersObject:user];
                [[DataManager sharedManager]saveContext];
                [tableView reloadData];
            } else {
                [user removeCourseObject:self.currentCourse];
                [self.currentCourse removeUsersObject:user];
                [[DataManager sharedManager]saveContext];
                [tableView reloadData];
            }
        } else {
            if(![self.selectedUsers containsObject:user]){
                [self.selectedUsers addObject:user];
                [self.delegate didSelectUser:self.selectedUsers];
                [tableView reloadData];
            }
        }
    }
    
    if (self.selectionType == SelectionTypeMentor) {
        if (self.currentCourse) {
            [self.delegate didSelectMentor:user];
            [[DataManager sharedManager]saveContext];
            [tableView reloadData];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.delegate didSelectMentor:user];
            [tableView reloadData];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController< User *> *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest<User *> *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"User" inManagedObjectContext:[DataManager sharedManager].persistentContainer.viewContext];
    [fetchRequest setEntity:description];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    [fetchRequest setSortDescriptors:@[firstNameDescriptor,lastNameDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<User *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[DataManager sharedManager].persistentContainer.viewContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withObject:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withObject:anObject];
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[CourseDetailTableViewController class]]) {
        CourseDetailTableViewController* courseDetailTableViewController = segue.destinationViewController;
        courseDetailTableViewController.course.users = sender;
    }
}
@end
