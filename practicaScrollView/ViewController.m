//
//  ViewController.m
//  practicaScrollView
//
//  Created by Balazs on 13/12/2016.
//  Copyright © 2016 iqtech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSArray *docs;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    docs = [[NSArray alloc] initWithObjects:@"doc1", @"doc2", @"doc3", nil];
    
    [_testSV setContentSize:CGSizeMake(0, 700)];
    
    for(UITextField *tf in _textFields){
        tf.text = @"";
        tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:tf.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }
    
    [_viewDate setHidden:YES];
    [_viewDocument setHidden:YES];
    
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showCamera {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }else{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void) showGaleria {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        if (m_ImgPicker == nil)
            m_ImgPicker = [[UIImagePickerController alloc] init];
        
        m_ImgPicker.allowsEditing = YES;
        m_ImgPicker.delegate = self;
        m_ImgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:m_ImgPicker animated:YES completion:nil];
    }
    else
    {
        //TODO Show Alert View
    }
}

- (IBAction)fotoClick:(id)sender {
    UIAlertController *alerta =
    [UIAlertController alertControllerWithTitle:@"PickerController"
                                        message:@"Escull una opció..."
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionCamera = [UIAlertAction
                                      actionWithTitle:@"Camera"
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction * action)
                                      {
                                          [self showCamera];
                                          [alerta dismissViewControllerAnimated:YES completion:nil];
                                      }];
    UIAlertAction *actionGaleria = [UIAlertAction
                                     actionWithTitle:@"Galeria"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         [self showGaleria];
                                         [alerta dismissViewControllerAnimated:YES completion:nil];
                                     }];
    
    [alerta addAction:actionCamera];
    [alerta addAction:actionGaleria];
    
    [self presentViewController:alerta animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo
{
    if(img != nil){
        [_avatar setImage:img];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)genereClick:(id)sender {
    UIAlertController *alerta =
    [UIAlertController alertControllerWithTitle:@"PickerController"
                                        message:@"Escull una opció..."
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *actionMasculino = [UIAlertAction
                             actionWithTitle:@"Masculino"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [_genereButton setTitle:@"MASCULINO" forState:UIControlStateNormal];
                                 [alerta dismissViewControllerAnimated:YES completion:nil];
                             }];
    UIAlertAction *actionFeminino = [UIAlertAction
                             actionWithTitle:@"Feminino"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [_genereButton setTitle:@"FEMININO" forState:UIControlStateNormal];
                                 [alerta dismissViewControllerAnimated:YES completion:nil];
                             }];
    
    [alerta addAction:actionMasculino];
    [alerta addAction:actionFeminino];
    
    [self presentViewController:alerta animated:YES completion:nil];
}

- (IBAction)dateBtnPressed:(id)sender {
    _viewDate.hidden = NO;
}

- (IBAction)closeDatePickerClick:(id)sender {
    _viewDate.hidden = YES;
    NSDate *bdate = _datePicker.date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM/dd/yyyy"];
    [_dateButton setTitle:[df stringFromDate:bdate] forState:UIControlStateNormal];
}

- (IBAction)documentBtnClicked:(id)sender {
    _viewDocument.hidden = NO;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return docs.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return docs[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_documentButton setTitle:docs[row] forState:UIControlStateNormal];
    _viewDocument.hidden = YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGPoint pt;
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:_testSV];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
    [_testSV setContentOffset:pt animated:YES];
    [textField becomeFirstResponder];
}

- (IBAction)endOnExit:(id)sender {
    UITextField *tfCurrent = (UITextField*) sender;
    
    bool found = NO;
    
    for(UITextField *tf in _textFields)
    {
        if(found)
        {
            [tf becomeFirstResponder];
            break;
        }
        if(tf==tfCurrent) found = YES;
    }
}


@end
