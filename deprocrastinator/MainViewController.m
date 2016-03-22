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
@property UISwipeGestureRecognizer *recognizer;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableArray = [NSMutableArray new];
    
//    self.recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
//                                                                action:@selector(handleSwipeRight:)];
//    self.recognizer.delegate = self;
//    [self.recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    [self.tableView addGestureRecognizer:self.recognizer];
//    [self.recognizer release];
    
    
    
    
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(leftSwipe:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.tableView addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                           action:@selector(rightSwipe:)];
    
    recognizer.delegate = self;
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.tableView addGestureRecognizer:recognizer];
    
    
}




#pragma mark TableView Selections

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableArray.count;
    ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deprocrastinator cell"];
    cell.textLabel.text = [self.tableArray objectAtIndex:indexPath.row];
    NSLog(@"%@", [self.tableArray objectAtIndex:indexPath.row]);
    return cell;
    
    

}



// when CELL row is selected, change the color
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView cellForRowAtIndexPath:indexPath].backgroundColor == [UIColor greenColor]) {
        [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor clearColor]];
    } else {
    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor greenColor]];
    }
    [self.tableView reloadData];
}

// when editing is enabled, what to edit. Clear colors and remove array position
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self alertPrompt:indexPath];
    
//    
//    [self.tableArray removeObjectAtIndex:indexPath.row];
//    [[tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor clearColor]];
//    [self.tableView reloadData];
}




-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSString *title = [self.tableArray objectAtIndex:sourceIndexPath.row];
    [self.tableArray removeObject:title];
    [self.tableArray insertObject:title atIndex:destinationIndexPath.row];
}





#pragma mark Button Presses


- (IBAction)addButtonPressed:(UIButton *)sender {
    [self addNewRow];
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


//- (IBAction)swipeGesture:(UISwipeGestureRecognizer *)sender {
//    [[self.tableView cellForRowAtIndexPath:sender.indexPath] setBackgroundColor:[UIColor clearColor]];
//
//}




// Alert Messaging. Prompts users if they really want to delete or not
-(void)alertPrompt:(NSIndexPath *)indexPath{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: [NSString stringWithFormat:@"Are you sure you want to delete?"] message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                               [self.tableArray removeObjectAtIndex:indexPath.row];
                                                              
                                                                [[self.tableView cellForRowAtIndexPath:indexPath] setBackgroundColor:[UIColor clearColor]];

                                                              [self.tableView reloadData];

                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          }];
    [alert addAction:deleteAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}





-(void)addNewRow{
    [self.tableArray addObject:self.textField.text];
    [self.tableView reloadData];
    self.textField.text = @"";
    [self.textField resignFirstResponder];
}



@end
