//
//  PNServiceChannelTest.m
//  UnitTestSample
//
//  Created by Vadim Osovets on 5/5/13.
//  Copyright (c) 2013 Micro-B. All rights reserved.
//

#import "PNServiceChannelTest.h"
#import "PNServiceChannel.h"

#import "PNMessage.h"
#import "PNChannel.h"
#import "PNMessagePostRequest.h"

#import "NSData+PNAdditions.h"

#import <OCMock/OCMock.h>

@implementation PNServiceChannelTest

- (void)setUp
{
    [super setUp];
    
    NSLog(@"setUp: %@", self.name);
}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}

#pragma mark - States tests

- (void)testServiceChannelWithDelegate {
    /*
     Test scenario:
      - initService with some delegate object
      - check service is ready to work
     */
    
    PNServiceChannel *channel = [PNServiceChannel serviceChannelWithDelegate:nil];
    STAssertNotNil(channel, @"Channel is not available");
}

- (void)testInitWithTypeAndDelegate {
    /*
     Test scenario:
     - initService with type: service and some delegate object
     - check service is ready to work
     
     - initService with type: messaging and some delegate object
     - check service is ready to work
     */
    
    PNServiceChannel *channel = [[PNServiceChannel alloc] initWithType:PNConnectionChannelService andDelegate:nil];
    STAssertNotNil(channel, @"Channel is not available");
    
    channel = [[PNServiceChannel alloc] initWithType:PNConnectionChannelMessaging andDelegate:nil];
    STAssertNotNil(channel, @"Channel is not available");
}


#pragma mark - Interaction tests

- (void)testSendMessage {
    /*
     Test scenario:
     - initService with some delegate object
     - send a message
     - expect scheduleRequest method of channel ivoked
    */
    
    PNServiceChannel *channel = [PNServiceChannel serviceChannelWithDelegate:nil];
    
    id mock = [OCMockObject partialMockForObject:channel];
    
	[[[[mock expect] ignoringNonObjectArgs] andReturn:nil] sendMessage: [OCMArg any] toChannel:[OCMArg any] compressed:NO];

    [mock sendMessage:[PNMessage new]];
    
    [mock verify];
}

- (void)testSendMessageToChannel {
    /*
     Test scenario:
     - initService with some delegate object
     - send a message to specific channel
     - expect scheduleRequest method of channel ivoked
     */
    PNServiceChannel *channel = [PNServiceChannel serviceChannelWithDelegate:nil];
    
    id mockChannel = [OCMockObject partialMockForObject:channel];
    
    [[[mockChannel expect] ignoringNonObjectArgs] sendMessage:[OCMArg any] toChannel:[OCMArg any]
                                                   compressed:NO];
    
    [mockChannel sendMessage:[PNMessage new]
                   toChannel:mockChannel
                  compressed:NO];
    [mockChannel verify];
}

@end
