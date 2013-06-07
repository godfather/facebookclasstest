//
//  ViewController.m
//  FacebookClassTest
//
//  Created by Santiago Carmo on 6/5/13.
//  Copyright (c) 2013 Santiago Carmo. All rights reserved.
//

#import "ViewController.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize fbStatus    = _fbStatus;
@synthesize loginButton = _loginButton;

- (void)viewDidLoad {
    [self updateStatusLabels];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)performLogin:(UIButton *)sender {
    if([GFFacebookHelpers isLogged]) {
        [GFFacebookHelpers logout:^{ [self updateStatusLabels]; }];
    } else {
        [GFFacebookHelpers login:^{
            [self updateStatusLabels];
        } onClose:^{} onError:nil];
    }
}

- (void)updateStatusLabels {
    if([GFFacebookHelpers isLogged]){
        [GFFacebookHelpers requestUserDataWithCompletionHandler:^(User *user, NSError *error) {
            if(!error){
                self.fbStatus.text = user.name;
                [_loginButton setTitle:@"Logout" forState:UIControlStateNormal];
            }
        }];
    }else{
        self.fbStatus.text = @"-";
        
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
    }
}

@end
