//
//  SPNFCReaderController.m
//  testNFC
//
//  Created by Matjaž Munda on 07/06/2017.
//  Copyright © 2017 Matjaž Munda. All rights reserved.
//

#import "SPNFCReaderController.h"

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
        }
    }
}

- (void) readerSession:(nonnull NFCNDEFReaderSession *)session didInvalidateWithError:(nonnull NSError *)error {
    NSLog(@"Got error: %@", error.localizedDescription);
    [self.session invalidateSession];
}

@end
