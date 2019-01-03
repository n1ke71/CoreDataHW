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

@interface UserDetailViewController ()
@property (strong,nonatomic) NSArray *array;
@property (strong,nonatomic) NSMutableArray *textFields;
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
    
    self.navigationItem.title = @"User Details";
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                             target:self
                                                                             action:@selector(saveItem:)];
    self.navigationItem.rightBarButtonItem = saveItem;
    self.textFields = [NSMutableArray array];
    
    if(self.user){
        self.array = [NSArray arrayWithObjects:self.user.firstName,self.user.lastName,self.user.email, nil];
    }else {
        self.array = [NSArray arrayWithObjects:@"",@"",@"", nil];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];

    UITextField *textField = [self.textFields objectAtIndex:0];
    [textField becomeFirstResponder];
}

#pragma mark - Actions

- (void)saveItem:(UIBarButtonItem *) sender {
    
    if (!self.user) {
        User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                   inManagedObjectContext:[DataManager sharedManager].persistentContainer.viewContext];
        user.firstName = [self textFieldWithAttribute:UsersAttributeFirstName];
        user.lastName = [self textFieldWithAttribute:UsersAttributeLastName];
        user.email = [self textFieldWithAttribute:UsersAttributeEmail];
        [[DataManager sharedManager]saveContext];
    }else{
        self.user.firstName = [self textFieldWithAttribute:UsersAttributeFirstName];
        self.user.lastName = [self textFieldWithAttribute:UsersAttributeLastName];
        self.user.email = [self textFieldWithAttribute:UsersAttributeEmail];
        [[DataManager sharedManager]saveContext];
    }
}

#pragma mark - Actions

- (NSString *)attributeName:(UsersAttribute) attribute{
    switch (attribute) {
        case UsersAttributeFirstName:
            return @"First Name";
            break;
        case UsersAttributeLastName:
            return @"Last Name";
            break;
        case UsersAttributeEmail:
            return @"Email";
            break;
        default:
            break;
    }
}

- (NSString *)textFieldWithAttribute:(UsersAttribute) attribute{
    
    UITextField *textField = nil;
    
    switch (attribute) {
        case UsersAttributeFirstName:
            textField = [self.textFields objectAtIndex:0];
            return textField.text;
            break;
        case UsersAttributeLastName:
            textField = [self.textFields objectAtIndex:1];
            return textField.text;
            break;
        case UsersAttributeEmail:
            textField = [self.textFields objectAtIndex:2];
            return textField.text;
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserDetailCell" forIndexPath:indexPath];
    cell.detailText.text = [self attributeName: (UsersAttribute)indexPath.row];
    cell.detailTextField.text = [self.array objectAtIndex:indexPath.row];
    [self.textFields addObject:cell.detailTextField];
    return cell;
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
