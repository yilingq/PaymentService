//
//  TransactionVO.m
//  PaymentServiceAPI
//
//  Created by Peter Qiu on 9/26/14.
//  Copyright (c) 2014 Peter Qiu. All rights reserved.
//

#import "TransactionVO.h"

@implementation TransactionVO

- (instancetype)init
{
    if ((self = [super init]))
    {
		// I think this will always end up being nil?
        // uniqueTransactionId = [_uniqueTransactionId UUIDString];
		
		// I think this was probably the intention
		self.uniqueTransactionId = [[NSUUID UUID] UUIDString];
    }
    return self;
    
}

- (instancetype)initWithName:(int)itmId amt:(NSDecimalNumber *)amt curency:(NSString *)curency payType:(NSString*)payType trck:(NSString *)trck uniqueId:(NSString*)uniqueId

{
    if ((self = [super init]))
    {
        self.uniqueTransactionId = uniqueId;
        self.itemId = itmId;
        self.amount = amt;
        self.track = trck;
        self.currency = curency;
        self.paymentType = payType;
    }
    return self;
    
}

@end
