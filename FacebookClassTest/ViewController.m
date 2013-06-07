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
  User *user = [GFFacebookHelpers requestUserData];
  NSLog(@"user: %@", user.name);
  
  self.fbStatus.text = [GFFacebookHelpers isLogged] ? @"Logado" : @"Offline";
  [_loginButton setTitle:[GFFacebookHelpers isLogged] ? @"Logout" : @"Login" forState:UIControlStateNormal];
}

@end
