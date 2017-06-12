//
//  SPNFCReaderController.m
//  testNFC
//
//  Created by Matjaž Munda on 07/06/2017.
//  Copyright © 2017 Matjaž Munda. All rights reserved.
//

#import "SPNFCReaderController.h"
@import UserNotifications;

@interface SPNFCReaderController()
@property NFCNDEFReaderSession* session;
@end

@implementation SPNFCReaderController
- (instancetype) init {
    self = [super init];
    if (!self) return nil;
    
    _session = [[NFCNDEFReaderSession alloc] initWithDelegate:self
                                                        queue:nil
                                     invalidateAfterFirstRead:NO];
    [self.session beginSession];
    
    return self;
}

- (void) readerSession:(nonnull NFCNDEFReaderSession *)session didDetectNDEFs:(nonnull NSArray<NFCNDEFMessage *> *)messages {
    NSLog(@"Did detect NDEFs");
    
    for (NFCNDEFMessage* message in messages) {
        for (NFCNDEFPayload* record in message.records) {
            NSLog(@"%@", record.identifier);
            NSLog(@"%@", record.payload);
            NSLog(@"%@", record.type);
            NSLog(@"%hhu", record.typeNameFormat);
            [self sendNotification:[NSString stringWithFormat:@"TAG: %@", [record.identifier base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]]];
        }
    }
}

- (void) readerSession:(nonnull NFCNDEFReaderSession *)session didInvalidateWithError:(nonnull NSError *)error {
    NSLog(@"Got error: %@", error.localizedDescription);
    [self.session invalidateSession];
}

- (void) sendNotification:(NSString*)text {
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center requestAuthorizationWithOptions:options
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (!granted) {
                                  NSLog(@"Something went wrong");
                              }
                          }];
    
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus != UNAuthorizationStatusAuthorized) {
            return;
        }
    }];
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"NFC test";
    content.body = text;
    content.categoryIdentifier = @"CategoryId";
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"RequestId" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
    
}

@end
