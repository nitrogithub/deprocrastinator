//
//  MainViewController.m
//  deprocrastinator
//
//  Created by Kevin Kim on 3/21/16.
//  Copyright © 2016 Kevin Kim. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSMutableArray *tableArray;
@property NSMutableArray *tableArrayBackgroundColor;
@property NSMutableArray *tableArrayTextColor;
@property UISwipeGestureRecognizer *recognizer;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableArray = [NSMutableArray new];
    self.tableArrayBackgroundColor = [NSMutableArray new];
    self.tableArrayTextColor = [NSMutableArray new];
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(rightSwipe:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.tableView addGestureRecognizer:recognizer];
}


#pragma mark Swipe Gestures


// NEED TO UPDATE THIS WITH THE CORRECT ARRAY 9AM 3/22/16
- (void)rightSwipe:(UISwipeGestureRecognizer *)gestureRecognizer{
    //do you right swipe stuff here. Something usually using theindexPath that you get that way
    CGPoint location = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
    
    if ([self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor == [UIColor greenColor]) {
        
        
        [self.tableArrayTextColor removeObjectAtIndex:indexPath.row];
        [self.tableArrayTextColor insertObject:[UIColor yellowColor] atIndex:indexPath.row];
        [self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = self.tableArrayTextColor[indexPath.row];
        
    
        
    } else if ([self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor == [UIColor yellowColor]){
        [self.tableArrayTextColor removeObjectAtIndex:indexPath.row];
        [self.tableArrayTextColor insertObject:[UIColor redColor] atIndex:indexPath.row];
        [self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = self.tableArrayTextColor[indexPath.row];
        
    } else if ([self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor == [UIColor redColor]) {
        [self.tableArrayTextColor removeObjectAtIndex:indexPath.row];
        [self.tableArrayTextColor insertObject:[UIColor blackColor] atIndex:indexPath.row];
        [self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = self.tableArrayTextColor[indexPath.row];
        
    } else {
        [self.tableArrayTextColor removeObjectAtIndex:indexPath.row];
        [self.tableArrayTextColor insertObject:[UIColor greenColor] atIndex:indexPath.row];
        [self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = self.tableArrayTextColor[indexPath.row];
    }
    [self.tableView reloadData];
    
    
    
    
//    original DELETE
    //do you right swipe stuff here. Something usually using theindexPath that you get that way
//    CGPoint location = [gestureRecognizer locationInView:self.tableView];
//    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
//    if ([self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor == [UIColor greenColor]) {
//        
//        
//        [self.tableArrayTextColor removeObjectAtIndex:indexPath.row];
//        [self.tableArrayTextColor insertObject:[UIColor yellowColor] atIndex:indexPath.row];
//        //        [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:self.tableArrayTextColor[indexPath.row]];
//        
//        
//        
//        [self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor yellowColor];
//        
//        
//        
//    } else if ([self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor == [UIColor yellowColor]){
//        [self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor redColor];
//    } else if ([self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor == [UIColor redColor]) {
//        [self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor blackColor];
//    } else {
//        [self.tableView cellForRowAtIndexPath:indexPath].textLabel.textColor = [UIColor greenColor];
//    }
//    [self.tableView reloadData];
}



#pragma mark TableView Selections
// how many CELLS to display
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableArray.count;
}

// linking the CELLs with the TABLEVIEW
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deprocrastinator cell"];
    cell.textLabel.text = [self.tableArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = self.tableArrayTextColor[indexPath.row];
    cell.backgroundColor = self.tableArrayBackgroundColor[indexPath.row];

    return cell;
}

// when CELL row is selected, change the color
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if GREEN, then change to CLEAR
    if ([tableView cellForRowAtIndexPath:indexPath].backgroundColor == [UIColor greenColor]) {
        
        
        [self.tableArrayBackgroundColor removeObjectAtIndex:indexPath.row];
        [self.tableArrayBackgroundColor insertObject:[UIColor clearColor] atIndex:indexPath.row];
        [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:self.tableArrayBackgroundColor[indexPath.row]];
        
            
//        if CLEAR, then change to GREEN
    } else {
        
        
        [self.tableArrayBackgroundColor removeObjectAtIndex:indexPath.row];
        [self.tableArrayBackgroundColor insertObject:[UIColor greenColor] atIndex:indexPath.row];
//        [[self.tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor greenColor]];
        [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:self.tableArrayBackgroundColor[indexPath.row]];
        
        

//    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor greenColor]];
    }
    [self.tableView reloadData];
}

// when editing is enabled, clear colors and remove array position
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self alertPrompt:indexPath];
}

// Allow moving of rows (cells)
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

// When movement does occurs, how it reorders
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSString *title = [self.tableArray objectAtIndex:sourceIndexPath.row];
    [self.tableArray removeObject:title];
    [self.tableArray insertObject:title atIndex:destinationIndexPath.row];
    
    UIColor *tempTextColor = [self.tableArrayTextColor objectAtIndex:sourceIndexPath.row];
    [self.tableArrayTextColor removeObjectAtIndex:sourceIndexPath.row];
    [self.tableArrayTextColor insertObject:tempTextColor atIndex:destinationIndexPath.row];
    
    UIColor *tempBackColor = [self.tableArrayBackgroundColor objectAtIndex:sourceIndexPath.row];
    [self.tableArrayBackgroundColor removeObjectAtIndex:sourceIndexPath.row];
    [self.tableArrayBackgroundColor insertObject:tempBackColor atIndex:destinationIndexPath.row];
    
    
    
//    ORINGAL
//    UIColor *tempBackColor = [self.tableArrayBackgroundColor objectAtIndex:sourceIndexPath.row];
//    [self.tableArrayBackgroundColor removeObject:tempBackColor];
//    [self.tableArrayBackgroundColor insertObject:tempBackColor atIndex:destinationIndexPath.row];
}




#pragma mark Button Presses


- (IBAction)addButtonPressed:(UIButton *)sender {
    [self addNewRow];
}


-(void)addNewRow{
    [self.tableArray addObject:self.textField.text];
    
    UIColor *blackColor = [UIColor blackColor];
    UIColor *clearColor = [UIColor clearColor];

    [self.tableArrayTextColor addObject:blackColor];
    [self.tableArrayBackgroundColor addObject:clearColor];
    
    [self.tableView reloadData];
    self.textField.text = @"";
    [self.textField resignFirstResponder];
}


- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    if (self.editing){
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    }else{
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.title = @"Done";
        sender.style =  UIBarButtonItemStyleDone;
    }
    [self.tableView reloadData];
}



#pragma mark Alert Popup


// Alert Messaging. Prompts users if they really want to delete or not
-(void)alertPrompt:(NSIndexPath *)indexPath{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: [NSString stringWithFormat:@"Are you sure you want to delete?"] message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                               [self.tableArray removeObjectAtIndex:indexPath.row];
                                                              [self.tableArrayTextColor removeObjectAtIndex:indexPath.row];
                                                              [self.tableArrayBackgroundColor removeObjectAtIndex:indexPath.row];

//                                                                [[self.tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor clearColor]];
                                                              [self.tableView reloadData];
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          }];
    [alert addAction:deleteAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
