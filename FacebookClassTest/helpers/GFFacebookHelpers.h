//
//  GFFacebookHelpers.h
//  MissingLink
//
//  Created by Santiago Carmo on 6/4/13.
//  Copyright (c) 2013 Santiago Carmo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "User.h"

typedef void(^OnOpenCallback)();
typedef void(^OnCloseCallback)();
typedef void(^OnErrorCallback)();

@interface GFFacebookHelpers : NSObject 

//Login, logout and extends permissions
+ (BOOL)login:(OnOpenCallback)onOpen onClose:(OnCloseCallback)onClose onError:(OnErrorCallback)onError;
+ (BOOL)logout:(OnCloseCallback)onClose;
+ (BOOL)reAuthorize:(NSArray *)permitions;

+ (void)sessionStateChange:(FBSession *)session state:(FBSessionState)state error:(NSError *)error onOpen:(OnOpenCallback)onOpen onClose:(OnCloseCallback)onClose onError:(OnErrorCallback)onError;

+ (BOOL)isLogged;

//User profile data
+ (void)requestUserDataWithCompletionHandler:(void (^)(User *user, NSError *error))handler;
+ (void)setUserData:(NSDictionary<FBGraphUser> *)user userModel:(User *)userModel;

@end
