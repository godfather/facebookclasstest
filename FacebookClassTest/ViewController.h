//
//  ViewController.h
//  FacebookClassTest
//
//  Created by Santiago Carmo on 6/5/13.
//  Copyright (c) 2013 Santiago Carmo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFFacebookHelpers.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *fbStatus;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)performLogin:(UIButton *)sender;
- (void)updateStatusLabels;
@end
