//
//  TransactionVO.h
//  PaymentServiceAPI
//
//  Created by Peter Qiu on 9/26/14.
//  Copyright (c) 2014 Peter Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransactionVO : NSObject

@property (nonatomic, assign) int itemId;
@property (nonatomic, copy) NSDecimalNumber *amount;
@property (nonatomic, copy) NSString *seatNumber;
@property (nonatomic, copy) NSString *fareClass;
@property (nonatomic, copy) NSString *ffStatus;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *paymentType;
@property (nonatomic, copy) NSString *uniqueTransactionId;
@property (nonatomic, copy) NSString *track;
@property (nonatomic, copy) NSString * eMVApplicationIdentifierField;
@property (nonatomic, copy) NSString * eMVCryptogramTransactionTypeField;
@property (nonatomic, copy) NSString * eMVIssuerScriptTemplate1Field;
@property (nonatomic, copy) NSString * eMVIssuerScriptTemplate2Field;
@property (nonatomic, copy) NSString * eMVApplicationInterchangeProfileField;
@property (nonatomic, copy) NSString * eMVDedicatedFileNameField;
@property (nonatomic, copy) NSString * eMVAuthorizationResponseCodeField;
@property (nonatomic, copy) NSString * eMVIssuerAuthenticationDataField;
@property (nonatomic, copy) NSString * eMVTerminalVerificationResultsField;
@property (nonatomic, copy) NSString * eMVTransactionDateField;
@property (nonatomic, copy) NSString * eMVTransactionStatusInformationField;
@property (nonatomic, copy) NSString * eMVTransactionTypeField;
@property (nonatomic, copy) NSString * eMVIssuerCountryCodeField;
@property (nonatomic, copy) NSString * eMVTransactionCurrencyCodeField;
@property (nonatomic, copy) NSString * eMVCardSequenceNumberField;
@property (nonatomic, copy) NSString * eMVTransactionAmountField;
@property (nonatomic, copy) NSString * eMVApplicationUsageControlField;
@property (nonatomic, copy) NSString * eMVApplicationVersionNumberField;
@property (nonatomic, copy) NSString * eMVIssuerActionCodeDenialField;
@property (nonatomic, copy) NSString * eMVIssuerActionCodeOnlineField;
@property (nonatomic, copy) NSString * eMVIssuerActionCodeDefaultField;
@property (nonatomic, copy) NSString * eMVIssuerApplicationDataField;
@property (nonatomic, copy) NSString * eMVTerminalCountryCodeField;
@property (nonatomic, copy) NSString * eMVInterfaceDeviceSerialNumberField;
@property (nonatomic, copy) NSString * eMVApplicationCryptogramField;
@property (nonatomic, copy) NSString * eMVCryptogramInformationDataField;
@property (nonatomic, copy) NSString * eMVTerminalCapabilitiesField;
@property (nonatomic, copy) NSString * eMVCardholderVerificationMethodResultsField;
@property (nonatomic, copy) NSString * eMVTerminalTypeField;
@property (nonatomic, copy) NSString * eMVApplicationTransactionCounterField;
@property (nonatomic, copy) NSString * eMVUnpredictableNumberField;
@property (nonatomic, copy) NSString * eMVTransactionSequenceCounterIDField;
@property (nonatomic, copy) NSString * eMVApplicationCurrencyCodeField;
@property (nonatomic, copy) NSString * eMVTransactionCategoryCodeField;
@property (nonatomic, copy) NSString * eMVIssuerScriptResultsField;
@property (nonatomic, copy) NSString * eMVPanSequenceNumber;
@property (nonatomic, copy) NSString * eMVServiceCode;
@property (nonatomic, copy) NSString * eMVShortFileIdentifier;

- (instancetype)init;
- (instancetype)initWithName:(int)itmId amt:(NSDecimalNumber *)amt curency:(NSString *)currency payType:(NSString*)payType trck:(NSString *)trck uniqueId:(NSString*)uniqueId;
@end
