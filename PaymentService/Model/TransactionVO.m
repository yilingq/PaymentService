//
//  TransactionVO.m
//  PaymentServiceAPI
//
//  Created by Peter Qiu on 9/26/14.
//  Copyright (c) 2014 Peter Qiu. All rights reserved.
//

#import "TransactionVO.h"

@implementation TransactionVO
@synthesize itemId = _itemId;
@synthesize amount = _amount;
@synthesize uniqueTransactionId;
@synthesize track = _track;
@synthesize currency = _currency;
@synthesize paymentType = _paymentType;
@synthesize seatNumber = _seatNumber;
@synthesize fareClass = _fareClass;
@synthesize ffStatus = _ffStatus;
@synthesize eMVApplicationIdentifierField = _eMVApplicationIdentifierField;
@synthesize eMVCryptogramTransactionTypeField = _eMVCryptogramTransactionTypeField;
@synthesize eMVIssuerScriptTemplate1Field = _eMVIssuerScriptTemplate1Field;
@synthesize eMVIssuerScriptTemplate2Field = _eMVIssuerScriptTemplate2Field;
@synthesize eMVApplicationInterchangeProfileField = _eMVApplicationInterchangeProfileField;
@synthesize eMVDedicatedFileNameField = _eMVDedicatedFileNameField;
@synthesize eMVAuthorizationResponseCodeField = _eMVAuthorizationResponseCodeField;
@synthesize eMVIssuerAuthenticationDataField = _eMVIssuerAuthenticationDataField;
@synthesize eMVTerminalVerificationResultsField = _eMVTerminalVerificationResultsField;
@synthesize eMVTransactionDateField = _eMVTransactionDateField;
@synthesize eMVTransactionStatusInformationField = _eMVTransactionStatusInformationField;
@synthesize eMVTransactionTypeField = _eMVTransactionTypeField;
@synthesize eMVIssuerCountryCodeField = _eMVIssuerCountryCodeField;
@synthesize eMVTransactionCurrencyCodeField = _eMVTransactionCurrencyCodeField;
@synthesize eMVCardSequenceNumberField = _eMVCardSequenceNumberField;
@synthesize eMVTransactionAmountField = _eMVTransactionAmountField;
@synthesize eMVApplicationUsageControlField = _eMVApplicationUsageControlField;
@synthesize eMVApplicationVersionNumberField = _eMVApplicationVersionNumberField;
@synthesize eMVIssuerActionCodeDenialField = _eMVIssuerActionCodeDenialField;
@synthesize eMVIssuerActionCodeOnlineField = _eMVIssuerActionCodeOnlineField;
@synthesize eMVIssuerActionCodeDefaultField = _eMVIssuerActionCodeDefaultField;
@synthesize eMVIssuerApplicationDataField = _eMVIssuerApplicationDataField;
@synthesize eMVTerminalCountryCodeField = _eMVTerminalCountryCodeField;
@synthesize eMVInterfaceDeviceSerialNumberField = _eMVInterfaceDeviceSerialNumberField;
@synthesize eMVApplicationCryptogramField = _eMVApplicationCryptogramField;
@synthesize eMVCryptogramInformationDataField = _eMVCryptogramInformationDataField;
@synthesize eMVTerminalCapabilitiesField = _eMVTerminalCapabilitiesField;
@synthesize eMVCardholderVerificationMethodResultsField = _eMVCardholderVerificationMethodResultsField;
@synthesize eMVTerminalTypeField = _eMVTerminalTypeField;
@synthesize eMVApplicationTransactionCounterField = _eMVApplicationTransactionCounterField;
@synthesize eMVUnpredictableNumberField = _eMVUnpredictableNumberField;
@synthesize eMVTransactionSequenceCounterIDField = _eMVTransactionSequenceCounterIDField;
@synthesize eMVApplicationCurrencyCodeField = _eMVApplicationCurrencyCodeField;
@synthesize eMVTransactionCategoryCodeField = _eMVTransactionCategoryCodeField;
@synthesize eMVIssuerScriptResultsField = _eMVIssuerScriptResultsField;
@synthesize eMVPanSequenceNumber = _eMVPanSequenceNumber;
@synthesize eMVServiceCode = _eMVServiceCode;
@synthesize eMVShortFileIdentifier = _eMVShortFileIdentifier;

- (id)init
{
    if ((self = [super init]))
    {
        uniqueTransactionId = [_uniqueTransactionId UUIDString];
    }
    return self;
    
}

- (id)initWithName:(int)itmId amt:(NSDecimalNumber *)amt curency:(NSString *)curency payType:(NSString*)payType trck:(NSString *)trck uniqueId:(NSString*)uniqueId

{
    if ((self = [super init]))
    {
        uniqueTransactionId = uniqueId;
        _itemId = itmId;
        _amount = amt;
        _track = trck;
        _currency = curency;
        _paymentType = payType;
    }
    return self;
    
}

- (void) dealloc
{
    _uniqueTransactionId = nil;
    _paymentType = nil;
    _amount = nil;
    _track = nil;
    _currency = nil;
    _fareClass = nil;
    _ffStatus = nil;
    _fareClass = nil;
    _eMVApplicationIdentifierField = nil;
    _eMVCryptogramTransactionTypeField = nil;
    _eMVIssuerScriptTemplate1Field = nil;
    _eMVIssuerScriptTemplate2Field = nil;
    _eMVApplicationInterchangeProfileField = nil;
    _eMVDedicatedFileNameField = nil;
    _eMVAuthorizationResponseCodeField = nil;
    _eMVIssuerAuthenticationDataField = nil;
    _eMVTerminalVerificationResultsField = nil;
    _eMVTransactionDateField = nil;
    _eMVTransactionStatusInformationField = nil;
    _eMVTransactionTypeField = nil;
    _eMVIssuerCountryCodeField = nil;
    _eMVTransactionCurrencyCodeField = nil;
    _eMVCardSequenceNumberField = nil;
    _eMVTransactionAmountField = nil;
    _eMVApplicationUsageControlField = nil;
    _eMVApplicationVersionNumberField = nil;
    _eMVIssuerActionCodeDenialField = nil;
    _eMVIssuerActionCodeOnlineField = nil;
    _eMVIssuerActionCodeDefaultField = nil;
    _eMVIssuerApplicationDataField = nil;
    _eMVTerminalCountryCodeField = nil;
    _eMVInterfaceDeviceSerialNumberField = nil;
    _eMVApplicationCryptogramField = nil;
    _eMVCryptogramInformationDataField = nil;
    _eMVTerminalCapabilitiesField = nil;
    _eMVCardholderVerificationMethodResultsField = nil;
    _eMVTerminalTypeField = nil;
    _eMVApplicationTransactionCounterField = nil;
    _eMVUnpredictableNumberField = nil;
    _eMVTransactionSequenceCounterIDField = nil;
    _eMVApplicationCurrencyCodeField = nil;
    _eMVTransactionCategoryCodeField = nil;
    _eMVIssuerScriptResultsField = nil;
    _eMVPanSequenceNumber = nil;
    _eMVServiceCode = nil;
    _eMVShortFileIdentifier = nil;
}
@end
