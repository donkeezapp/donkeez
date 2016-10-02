#import "RegisterViewController.h"
#import "Backendless.h"
#import "NSString+Date.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    NSArray *_data;
    BackendlessUser *_user;
    UITextField *_firstResponder;
}
-(void)changeDate:(UIDatePicker *)sender;

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _user = [BackendlessUser new];
    _data = @[@{@"type":@"DATETIME", @"name":@"birthday"}, @{@"type":@"STRING", @"name":@"email"}, @{@"type":@"STRING", @"name":@"firstname"}, @{@"type":@"STRING", @"name":@"gender"}, @{@"type":@"STRING", @"name":@"lastname"}, @{@"type":@"STRING", @"name":@"name"}, @{@"type":@"STRING", @"name":@"password"}];

    [self boolPropertiesDefaultSet];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITextFieldDelegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *expression;
    UITableViewCell *cell = (UITableViewCell *)(([[[textField superview] superview] isKindOfClass:[UITableViewCell class]])?[[textField superview] superview]:[[[textField superview] superview] superview]);
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *field = _data[indexPath.row];
    if ([field[@"type"] isEqualToString:@"INT"])
    {
        expression = @"^([1-9]+)([0-9]*)$";
    }
    else if ([field[@"type"] isEqualToString:@"DOUBLE"])
    {
        expression = @"^([0-9]+)(\\.([0-9]*))?$";
    }
    else
    {
        return YES;
    }
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                        options:0
                                                          range:NSMakeRange(0, [newString length])];
        if (numberOfMatches == 0)
            return NO;

    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _firstResponder = textField;
    UITableViewCell *cell = (UITableViewCell *)(([[[textField superview] superview] isKindOfClass:[UITableViewCell class]])?[[textField superview] superview]:[[[textField superview] superview] superview]);

    [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    UITableViewCell *cell = (UITableViewCell *)(([[[textField superview] superview] isKindOfClass:[UITableViewCell class]])?[[textField superview] superview]:[[[textField superview] superview] superview]);
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *field = _data[indexPath.row];
    if ([field[@"type"] isEqualToString:@"DATETIME"]) {
        return;
    }
    id val;
    if ([field[@"type"] isEqualToString:@"STRING"])
    {
        val = textField.text;
    }
    else if ([field[@"type"] isEqualToString:@"DOUBLE"])
    {
        val = @(textField.text.doubleValue);
    }
    else if ([field[@"type"] isEqualToString:@"BOOLEAN"])
    {
        val = @(textField.text.boolValue);
    }
    else if ([field[@"type"] isEqualToString:@"INT"])
    {
        val = @(textField.text.intValue);
    }
    else if ([field[@"type"] isEqualToString:@"TEXT"])
    {
        val = textField.text;
    }

    [_user setProperty:field[@"name"] object:val];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    UITableViewCell *cell = (UITableViewCell *)(([[[textField superview] superview] isKindOfClass:[UITableViewCell class]])?[[textField superview] superview]:[[[textField superview] superview] superview]);
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if ([_data[indexPath.row][@"type"] isEqualToString:@"DATETIME"]) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
        datePicker.tag = indexPath.row;
        [textField setInputView:datePicker];
    }

    return YES;

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
    _firstResponder = nil;
	return YES;
}
-(void)changeDate:(UIDatePicker *)sender
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    [_user setProperty:_data[sender.tag][@"name"] object:sender.date];
    UITextField *textField = (UITextField *)[cell viewWithTag:1];
    textField.text = [NSString stringWithDateFormat:@"dd.MM.yyyy" date:sender.date];
    [textField resignFirstResponder];
}
-(void)registrate:(id)sender
{
    [_firstResponder resignFirstResponder];
    [backendless.userService registering:_user response:^(BackendlessUser *user) {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SuccessRegistration"];
        [self presentViewController:vc animated:YES completion:^{

        }];
    } error:^(Fault *error) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:error.detail delegate:nil cancelButtonTitle:@"Done" otherButtonTitles:nil] show];
    }];
}
-(void)changeBoolVal:(UISwitch *)sender
{
    UITableViewCell *cell = (UITableViewCell *)(([[[sender superview] superview] isKindOfClass:[UITableViewCell class]])?[[sender superview] superview]:[[[sender superview] superview] superview]);
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *field = _data[indexPath.row];
    [_user setProperty:field[@"name"] object:@(sender.on)];
}

-(void)boolPropertiesDefaultSet {

    for (NSDictionary *field in _data)
        if ([field[@"type"] isEqualToString:@"BOOLEAN"])
            [_user setProperty:field[@"name"] object:@(YES)];
}

@end