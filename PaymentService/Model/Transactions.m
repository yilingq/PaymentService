//
//  Transactions.m
//  PaymentServiceAPI
//
//  Created by Peter Qiu on 9/26/14.
//  Copyright (c) 2014 Peter Qiu. All rights reserved.
//

#import "Transactions.h"
#import "GeneralInfoVO.h"

@implementation Transactions

- (id)init
{    
    if ((self = [super init]))
    {
        self.transactionRecords = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
