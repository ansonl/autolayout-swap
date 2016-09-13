//
//  ViewController.m
//  Auto
//
//  Created by Anson Liu on 9/12/16.
//  Copyright © 2016 Anson Liu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    UIView *dateModificationView;
    UITextField *alertTitleTextField;
    UIDatePicker *alertDatePicker;
    UIButton *alertScheduleButton;
    UITableView *alertListTableView;
    
    NSArray<NSLayoutConstraint *> *temporaryAddedConstraints;
    /*
     dateModificationView.translatesAutoresizingMaskIntoConstraints = NO;
     alertListTableView.translatesAutoresizingMaskIntoConstraints = NO;
     alertTitleTextField.translatesAutoresizingMaskIntoConstraints = NO;
     datePicker.translatesAutoresizingMaskIntoConstraints = NO;
     scheduleAlertButton.translatesAutoresizingMaskIntoConstraints = NO;*/
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular) {
            NSLog(@"Show vertical layout");
            
            [self applyPortraitConstraints];
        } else if (newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
            NSLog(@"Show horizonal layout");
            
            [self applyLandscapeConstraints];
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
    }];
    
    
}

- (void)applyLandscapeConstraints {
    if (temporaryAddedConstraints)
        [self.view removeConstraints:temporaryAddedConstraints];
    temporaryAddedConstraints = [[NSArray alloc] init];
    
    id topGuide = [self topLayoutGuide];
    NSDictionary *bindings = NSDictionaryOfVariableBindings(dateModificationView, alertTitleTextField, alertDatePicker, alertScheduleButton, alertListTableView, topGuide);
    
    temporaryAddedConstraints = [temporaryAddedConstraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topGuide]-0-[dateModificationView]-0-|"
                                                                                                                                 options:(NSLayoutFormatOptions)0
                                                                                                                                 metrics:nil views:bindings]];
    temporaryAddedConstraints = [temporaryAddedConstraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topGuide]-0-[alertListTableView]-0-|"
                                                                                                                                 options:(NSLayoutFormatOptions)0
                                                                                                                                 metrics:nil views:bindings]];
    
    temporaryAddedConstraints = [temporaryAddedConstraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[alertListTableView]-0-[dateModificationView]-0-|"
                                                                                                                                 options:(NSLayoutFormatOptions)0
                                                                                                                                 metrics:nil views:bindings]];
    [self.view addConstraints:temporaryAddedConstraints];
}

- (void)applyPortraitConstraints {
    if (temporaryAddedConstraints)
        [self.view removeConstraints:temporaryAddedConstraints];
    temporaryAddedConstraints = [[NSArray alloc] init];
    
    id topGuide = [self topLayoutGuide];
    NSDictionary *bindings = NSDictionaryOfVariableBindings(dateModificationView, alertTitleTextField, alertDatePicker, alertScheduleButton, alertListTableView, topGuide);
    
    temporaryAddedConstraints = [temporaryAddedConstraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topGuide]-0-[dateModificationView]-0-[alertListTableView]-0-|"
                                                                                                                                 options:(NSLayoutFormatOptions)0
                                                                                                                                 metrics:nil views:bindings]];
    
    temporaryAddedConstraints = [temporaryAddedConstraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[dateModificationView]-0-|"
                                                                                                                                 options:(NSLayoutFormatOptions)0
                                                                                                                                 metrics:nil views:bindings]];
    temporaryAddedConstraints = [temporaryAddedConstraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[alertListTableView]-0-|"
                                                                                                                                 options:(NSLayoutFormatOptions)0
                                                                                                                                 metrics:nil views:bindings]];
    [self.view addConstraints:temporaryAddedConstraints];
}

- (void)applyPermanentConstraints {
    NSDictionary *bindings = NSDictionaryOfVariableBindings(dateModificationView, alertTitleTextField, alertDatePicker, alertScheduleButton, alertListTableView);
    [dateModificationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[alertTitleTextField]-[alertDatePicker]-[alertScheduleButton]-|"
                                                                                 options:(NSLayoutFormatOptions)0
                                                                                 metrics:nil views:bindings]];
    [dateModificationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[alertTitleTextField]-|"
                                                                                 options:(NSLayoutFormatOptions)0
                                                                                 metrics:nil views:bindings]];
    [dateModificationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[alertDatePicker]-|"
                                                                                 options:(NSLayoutFormatOptions)0
                                                                                 metrics:nil views:bindings]];
    [dateModificationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[alertScheduleButton]-|"
                                                                                 options:(NSLayoutFormatOptions)0
                                                                                 metrics:nil views:bindings]];
    
    //decrease schedule button content hugging priority so that it will stretch to fill available space
    [alertScheduleButton setContentHuggingPriority:100 forAxis:UILayoutConstraintAxisVertical];
    
    [alertListTableView setContentHuggingPriority:100 forAxis:UILayoutConstraintAxisVertical];
    [alertListTableView setContentHuggingPriority:100 forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dateModificationView = [[UIView alloc] init];
    [dateModificationView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:dateModificationView];
    
    alertTitleTextField = [[UITextField alloc] init];
    [alertTitleTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [alertTitleTextField setBackgroundColor:[UIColor blueColor]];
    [alertTitleTextField setPlaceholder:@"What will the alert be?"];
    [dateModificationView addSubview:alertTitleTextField];
    
    alertDatePicker = [[UIDatePicker alloc] init];
    [alertDatePicker setTranslatesAutoresizingMaskIntoConstraints:NO];
    [alertDatePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    [dateModificationView addSubview:alertDatePicker];
    
    alertScheduleButton = [[UIButton alloc] init];
    [alertScheduleButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [alertScheduleButton setTitle:@"Set Alert" forState:UIControlStateNormal];
    [alertScheduleButton setBackgroundColor:[UIColor redColor]];
    [dateModificationView addSubview:alertScheduleButton];
    
    alertListTableView = [[UITableView alloc] init];
    [alertListTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [alertListTableView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:alertListTableView];
    
    [self applyPermanentConstraints];
    [self applyPortraitConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
