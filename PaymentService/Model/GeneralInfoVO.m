//
//  GeneralInfoVO.m
//  PaymentServiceAPI
//
//  Created by Peter Qiu on 9/26/14.
//  Copyright (c) 2014 Peter Qiu. All rights reserved.
//

#import "GeneralInfoVO.h"

@implementation GeneralInfoVO

@synthesize DepartureTime;
@synthesize FlightNum;
@synthesize OriginatingAirport;
@synthesize DestinationAirport;

- (id)initWithName: (int)companyId crewId:(int)crewId deviceId:(NSString *)deviceId depTime:(NSDate *)depTime fltNum:(NSString *)fltNum origAiport:(NSString *)origAiport destAirport:(NSString *)destAirport
{
    if ((self = [super init]))
    {
        self.deviceId = deviceId;
        self.companyId = companyId;
        self.crewId = crewId;
        DepartureTime = depTime;
        FlightNum = fltNum;
        OriginatingAirport = origAiport;
        DestinationAirport = destAirport;
    }
    return self;
    
}

- (void) dealloc
{
    self.deviceId = nil;
    DepartureTime = nil;
    FlightNum = nil;
    OriginatingAirport = nil;
    DestinationAirport = nil;
}
@end