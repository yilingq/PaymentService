//
//  Transactions.h
//  PaymentServiceAPI
//
//  Created by Peter Qiu on 9/26/14.
//  Copyright (c) 2014 Peter Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneralInfoVO.h"

@interface Transactions : NSObject
{
    GeneralInfoVO *_info;
    NSMutableArray *_transactionRecords;
}
@property (strong, nonatomic) GeneralInfoVO *info;
@property (strong, nonatomic) NSMutableArray *transactionRecords;
@end


