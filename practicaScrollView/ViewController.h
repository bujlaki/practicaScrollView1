//
//  ViewController.h
//  practicaScrollView
//
//  Created by Balazs on 13/12/2016.
//  Copyright © 2016 iqtech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
    <
        UIImagePickerControllerDelegate,
        UINavigationControllerDelegate,
        UIPickerViewDelegate,
        UIPickerViewDataSource,
        UITextFieldDelegate
    >
{
    UIImagePickerController *m_ImgPicker;
}

@property (weak, nonatomic) IBOutlet UIScrollView *testSV;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;
@property (weak, nonatomic) IBOutlet UIButton *genereButton;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIView *viewDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (weak, nonatomic) IBOutlet UIView *viewDocument;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *documentButton;

- (IBAction)fotoClick:(id)sender;

- (IBAction)genereClick:(id)sender;
- (IBAction)dateBtnPressed:(id)sender;
- (IBAction)closeDatePickerClick:(id)sender;
- (IBAction)documentBtnClicked:(id)sender;
@end

