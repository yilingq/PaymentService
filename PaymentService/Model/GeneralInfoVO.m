//
//  GeneralInfoVO.m
//  PaymentServiceAPI
//
//  Created by Peter Qiu on 9/26/14.
//  Copyright (c) 2014 Peter Qiu. All rights reserved.
//

#import "GeneralInfoVO.h"

@implementation GeneralInfoVO

- (instancetype)initWithName: (int)companyId crewId:(int)crewId deviceId:(NSString *)deviceId depTime:(NSDate *)depTime fltNum:(NSString *)fltNum origAiport:(NSString *)origAiport destAirport:(NSString *)destAirport
{
    if ((self = [super init]))
    {
        self.deviceId = deviceId;
        self.companyId = companyId;
        self.crewId = crewId;
        self.DepartureTime = depTime;
        self.FlightNum = fltNum;
        self.OriginatingAirport = origAiport;
        self.DestinationAirport = destAirport;
    }
    return self;
    
}

@end