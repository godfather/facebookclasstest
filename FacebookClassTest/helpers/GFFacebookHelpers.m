//
//  GFFacebookHelpers.m
//  MissingLink
//
//  Created by Santiago Carmo on 6/4/13.
//  Copyright (c) 2013 Santiago Carmo. All rights reserved.
//

#import "GFFacebookHelpers.h"

@implementation GFFacebookHelpers

+ (BOOL)login:(OnOpenCallback)onOpen onClose:(OnCloseCallback)onClose onError:(OnErrorCallback)onError {
    [FBSession openActiveSessionWithReadPermissions:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"FacebookPermissions"] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
        [self sessionStateChange:session state:state error:error onOpen:onOpen onClose:onClose onError:onError];
    }];
    return YES;
}

+ (BOOL)logout:(OnCloseCallback)onClose {
    [FBSession.activeSession closeAndClearTokenInformation];
    onClose();
    return YES;
}

+ (BOOL)reAuthorize:(NSArray *)permissions {
    return YES;
}

+ (void)sessionStateChange:(FBSession *)session state:(FBSessionState)state error:(NSError *)error onOpen:(OnOpenCallback)onOpen onClose:(OnCloseCallback)onClose onError:(OnErrorCallback)onError {
    switch(state) {
        case FBSessionStateOpen:              onOpen();  break;
        case FBSessionStateClosed:            onClose(); break;
        case FBSessionStateClosedLoginFailed: onClose(); break;
        default: break;
    }
    if(error && onError != nil) onError();
}

+ (BOOL)isLogged {
    return (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) || (FBSession.activeSession.state == 513);
}

//User profile data
+ (void)requestUserDataWithCompletionHandler:(void (^)(User *user, NSError *error))handler{
    if(FBSession.activeSession.isOpen) {        
        [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
            if(!error){
                User *userData = [[User alloc] init];
                userData.name = user.name;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(userData, nil);
                });
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(nil, error);
                });
            }
        }];
    }
}

+ (void)setUserData:(NSDictionary<FBGraphUser> *)user userModel:(User *)userModel {
    for(NSString *key in user) { userModel.name = [user objectForKey:key]; }
}


@end
