//
//  PaymentServiceAPI.m
//  PaymentServiceAPI
//
//  Created by Peter Qiu on 9/26/14.
//  Copyright (c) 2014 Peter Qiu. All rights reserved.
//

#import "PaymentService.h"
#import "Transactions.h"
#import "GDataXMLNode.h"
#import "TransactionVO.h"
#import "Model/Constants.h"

@implementation PaymentService

NSString *const PaymentReportTAG = @"paymentReport";
NSString *const GeneralInfoTAG = @"generalInfo";
NSString *const TransactionRecTAG = @"transactionRec";
NSString *const CompanyIdTAG = @"companyId";
NSString *const DeviceIdTAG = @"deviceId";
NSString *const CrewIdTAG = @"crewId";
NSString *const FlightNumberTAG = @"flightNumber";
NSString *const OriginatingAirportTAG = @"originatingAirport";
NSString *const DestinationAirportTAG = @"destinationAirport";
NSString *const DepartureTimeTAG = @"departureTime";
NSString *const ItemIdTAG = @"itemId";
NSString *const AmountTAG = @"amount";
NSString *const CurrencyTAG = @"currency";
NSString *const SeatNumberTAG = @"seatNumber";
NSString *const FareClassTAG = @"fareClass";
NSString *const FFStatusTAG = @"ffStatus";
NSString *const PaymentTypeTAG = @"paymentType";
NSString *const TrackTAG = @"blob";
NSString *const UniqueTransactionIdTAG = @"uniqueTransactionId";
NSString *const EMVApplicationInterchangeProfileTAG = @"EMVApplicationInterchangeProfile";
NSString *const EMVapplidentifierTAG = @"EMVApplicationIdentifierCard";
NSString *const EMVTerminalVerificationResultsTAG = @"EMVTerminalVerificationResults";
NSString *const EMVTransactionDateTAG = @"EMVTransactionDate";
NSString *const EMVCryptogramTransactionTypeTAG = @"EMVCryptogramTransactionType";
NSString *const EMVDedicatedFileNameTAG = @"EMVDedicatedFileName";
NSString *const EMVIssuerCountryCodeTAG = @"EMVIssuerCountryCode";
NSString *const EMVTransactionCurrencyCodeTAG = @"EMVTransactionCurrencyCode";
NSString *const EMVTransactionAmountTAG = @"EMVTransactionAmount";
NSString *const EMVApplicationVersionNumberTAG = @"EMVApplicationVersionNumber";
NSString *const EMVIssuerApplicationDataTAG = @"EMVIssuerApplicationData";
NSString *const EMVTerminalCountryCodeTAG = @"EMVTerminalCountryCode";
NSString *const EMVInterfaceDeviceSerialNumberTAG = @"EMVInterfaceDeviceSerialNumber";
NSString *const EMVApplicationCryptogramTAG = @"EMVApplicationCryptogram";
NSString *const EMVCryptogramInformationDataTAG = @"EMVCryptogramInformationData";
NSString *const EMVTerminalCapabilitiesTAG = @"EMVTerminalCapabilities";
NSString *const EMVCardholderVerificationMethodResultTAG = @"EMVCardholderVerificationMethodResult";
NSString *const EMVTerminalTypeTAG = @"EMVTerminalType";
NSString *const EMVApplicationTransactionCounterTAG = @"EMVApplicationTransactionCounter";
NSString *const EMVUnpredictableNumberTAG = @"EMVUnpredictableNumber";
NSString *const EMVTransactionSequenceCounterIDTAG = @"EMVTransactionSequenceCounterID";
NSString *const EMVApplicationCurrencyCodeTAG = @"EMVApplicationCurrencyCode";
NSString *const EMVTransactionCategoryCodeTAG = @"EMVTransactionCategoryCode";
NSString *const EMVIssuerScriptResultsTAG = @"EMVIssuerScriptResults";
NSString *const EMVAuthorisationResponseCodeTAG = @"EMVAuthorisationResponseCode";
NSString *const EMVIssuerActionCodeDefaultTAG = @"EMVIssuerActionCodeDefault";
NSString *const EMVIssuerActionCodeDenialTAG = @"EMVIssuerActionCodeDenial";
NSString *const EMVIssuerActionCodeOnlineTAG = @"EMVIssuerActionCodeOnline";
NSString *const EMVApplicationUsageControlTAG = @"EMVApplicationUsageControl";
NSString *const EMVTransactionStatusInformationTAG = @"EMVTransactionStatusInformation";
NSString *const EMVShortFileIdentifierTAG = @"EMVShortFileIdentifier";
NSString *const EMVApplicationIdentifierCardTAG = @"EMVApplicationIdentifierCard";
NSString *const EMVPanSequenceNumberTAG = @"EMVPanSequenceNumber";
NSString *const EMVServiceCodeTAG = @"EMVServiceCode";
NSString *const AppNameTAG = @"AppName";
NSString *const AppidTAG = @"Appid";
NSString *const EMVAppEffectiveDateTAG = @"EMVAppEffectiveDate";
NSString *const EMVAppExpiryDateTAG = @"EMVAppExpiryDate";

-(NSString *)dataFilePath: (NSString *)fileName :(BOOL)save
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory
                               stringByAppendingPathComponent:fileName];
    if (save || [[NSFileManager defaultManager] fileExistsAtPath:documentsPath])
    {
        return documentsPath;
    }
    else
    {
        return nil;
    }
}

-(NSString *)dateToString:(NSString *)format :(NSDate*)dte
{
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    dateString = [formatter stringFromDate:dte];
    return dateString;
}

-(NSDate *)StringToDate:(NSString *)format :(NSString*)dte
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *dateFromString = [dateFormatter dateFromString:dte];
    return dateFromString;
}

- (NSString*)element:(GDataXMLElement *)element stringValueForTag:(NSString*)tag {
	NSArray* array = [element elementsForName:tag];
	
	if (array.count > 0) {
		return array.firstObject;
	} else {
		return @"";
	}
}

- (void)BuildEMVTransaction:(GDataXMLElement *)transReportMember tran:(TransactionVO *)tran
{
    //[self BuildEMVTransaction:transReportMember :&tran];
	
	tran.eMVApplicationInterchangeProfileField = [self element:transReportMember stringValueForTag:EMVApplicationInterchangeProfileTAG];
	tran.eMVApplicationIdentifierField = [self element:transReportMember stringValueForTag:EMVapplidentifierTAG];
	tran.eMVTerminalVerificationResultsField = [self element:transReportMember stringValueForTag:EMVTerminalVerificationResultsTAG];
	tran.eMVTransactionDateField = [self element:transReportMember stringValueForTag:EMVTransactionDateTAG];
	
	/*
	 * In the case where the EMVCryptogramTransactionTypeTAG element was missing,
	 * this previously was improperly clearing out the eMVTransactionDateField. - NRP
	 */
	tran.eMVCryptogramTransactionTypeField = [self element:transReportMember stringValueForTag:EMVCryptogramTransactionTypeTAG];
	tran.eMVDedicatedFileNameField = [self element:transReportMember stringValueForTag:EMVDedicatedFileNameTAG];
	tran.eMVIssuerCountryCodeField = [self element:transReportMember stringValueForTag:EMVIssuerCountryCodeTAG];
	tran.eMVTransactionCurrencyCodeField = [self element:transReportMember stringValueForTag:EMVTransactionCurrencyCodeTAG];
	tran.eMVTransactionAmountField = [self element:transReportMember stringValueForTag:EMVTransactionAmountTAG];
	tran.eMVApplicationVersionNumberField = [self element:transReportMember stringValueForTag:EMVApplicationVersionNumberTAG];
	tran.eMVIssuerApplicationDataField = [self element:transReportMember stringValueForTag:EMVIssuerApplicationDataTAG];
	tran.eMVTerminalCountryCodeField = [self element:transReportMember stringValueForTag:EMVTerminalCountryCodeTAG];
	tran.eMVInterfaceDeviceSerialNumberField = [self element:transReportMember stringValueForTag:EMVInterfaceDeviceSerialNumberTAG];
	tran.eMVApplicationCryptogramField = [self element:transReportMember stringValueForTag:EMVApplicationCryptogramTAG];
	tran.eMVCryptogramInformationDataField = [self element:transReportMember stringValueForTag:EMVCryptogramInformationDataTAG];
	tran.eMVTerminalCapabilitiesField = [self element:transReportMember stringValueForTag:EMVTerminalCapabilitiesTAG];
	tran.eMVCardholderVerificationMethodResultsField = [self element:transReportMember stringValueForTag:EMVCardholderVerificationMethodResultTAG];
	tran.eMVTerminalTypeField = [self element:transReportMember stringValueForTag:EMVTerminalTypeTAG];
	tran.eMVApplicationTransactionCounterField = [self element:transReportMember stringValueForTag:EMVApplicationTransactionCounterTAG];
	tran.eMVUnpredictableNumberField = [self element:transReportMember stringValueForTag:EMVUnpredictableNumberTAG];
	tran.eMVTransactionSequenceCounterIDField = [self element:transReportMember stringValueForTag:EMVTransactionSequenceCounterIDTAG];
	tran.eMVApplicationCurrencyCodeField = [self element:transReportMember stringValueForTag:EMVApplicationCurrencyCodeTAG];
	tran.eMVTransactionCategoryCodeField = [self element:transReportMember stringValueForTag:EMVTransactionCategoryCodeTAG];
	tran.eMVIssuerScriptResultsField = [self element:transReportMember stringValueForTag:EMVIssuerScriptResultsTAG];
	tran.eMVAuthorizationResponseCodeField = [self element:transReportMember stringValueForTag:EMVAuthorisationResponseCodeTAG];
	tran.eMVIssuerActionCodeDefaultField = [self element:transReportMember stringValueForTag:EMVIssuerActionCodeDefaultTAG];
	tran.eMVIssuerActionCodeDenialField = [self element:transReportMember stringValueForTag:EMVIssuerActionCodeDenialTAG];
	tran.eMVIssuerActionCodeOnlineField = [self element:transReportMember stringValueForTag:EMVIssuerActionCodeOnlineTAG];
	tran.eMVApplicationUsageControlField = [self element:transReportMember stringValueForTag:EMVApplicationUsageControlTAG];
	tran.eMVTransactionStatusInformationField = [self element:transReportMember stringValueForTag:EMVTransactionStatusInformationTAG];
	tran.eMVShortFileIdentifier = [self element:transReportMember stringValueForTag:EMVShortFileIdentifierTAG];
	tran.eMVPanSequenceNumber = [self element:transReportMember stringValueForTag:EMVPanSequenceNumberTAG];
	tran.eMVServiceCode = [self element:transReportMember stringValueForTag:EMVServiceCodeTAG];}

- (Transactions *)loadTransactions :(NSString*)fileName
{
    int compId = 0;
    int crId = 0;
    NSString *devId = @"";
    NSDate *depTime;
    NSString *fltNum = @"";
    NSString *origAiport = @"";
    NSString *destAirport = @"";
    
    int itmId;
    NSDecimalNumber *amt;
    NSString *seat = @"";
    NSString *fare = @"";
    NSString *ffSt = @"";
    NSString *cur = @"";
    NSString *payType = @"";
    NSString *uniTranId;
    NSString *trck = @"";
    NSString *filePath = [self dataFilePath :fileName :false];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                           options:0 error:&error];
    Transactions *trans = [[Transactions alloc] init];
    if (doc == nil)
    {
        return nil;
    }
    @try
    {
        NSArray *genInfoMembers = [doc.rootElement elementsForName:GeneralInfoTAG];
        //NSArray *transMembers = [doc.rootElement elementsForName:TransactionRecTAG];
        NSArray *transMembers = [doc nodesForXPath:@"//paymentReport/transactionRec" error:nil];
       
        GDataXMLElement *genInfoMember = genInfoMembers[0];
		
		compId = [[self element:genInfoMember stringValueForTag:CompanyIdTAG] intValue];
		crId = [[self element:genInfoMember stringValueForTag:CrewIdTAG] intValue];
		devId = [self element:genInfoMember stringValueForTag:DeviceIdTAG];
		fltNum = [self element:genInfoMember stringValueForTag:FlightNumberTAG];
		origAiport = [self element:genInfoMember stringValueForTag:OriginatingAirportTAG];
		destAirport = [self element:genInfoMember stringValueForTag:DestinationAirportTAG];
		depTime = [self StringToDate: @"yyyy-MM-dd" :[self element:genInfoMember stringValueForTag:DepartureTimeTAG]];

        trans.info = [[GeneralInfoVO alloc] initWithName :compId crewId:crId deviceId:devId depTime:depTime fltNum:fltNum origAiport:origAiport destAirport:destAirport];
        
        for (GDataXMLElement *transReportMember in transMembers)
        {
			NSString* itemIdString = [self element:transReportMember stringValueForTag:ItemIdTAG];
			itmId = [itemIdString intValue];
			
			NSString* amtString = [self element:transReportMember stringValueForTag:AmountTAG];
			amt = [NSDecimalNumber decimalNumberWithString:amtString];
			
			cur = [self element:transReportMember stringValueForTag:CurrencyTAG];
			seat = [self element:transReportMember stringValueForTag:SeatNumberTAG];
			fare = [self element:transReportMember stringValueForTag:FareClassTAG];
			ffSt = [self element:transReportMember stringValueForTag:FFStatusTAG];
			payType = [self element:transReportMember stringValueForTag:PaymentTypeTAG];
			trck = [self element:transReportMember stringValueForTag:TrackTAG];
			uniTranId = [self element:transReportMember stringValueForTag:UniqueTransactionIdTAG];
			
#warning TODO: is this right?
			/*
			 * I am preserving the original behavior, where if any of the above fields were
			 * missing, it would silently skip this transaction. It seems like we should at
			 * least log a warning. - NRP
			 */
			if (itemIdString.length == 0 ||
				amtString.length == 0 ||
				cur.length == 0 ||
				seat.length == 0 ||
				fare.length == 0 ||
				ffSt.length == 0 ||
				payType.length == 0 ||
				trck.length == 0 ||
				uniTranId.length == 0)
			{
				// TODO: maybe put a warning here?
				continue;
			}

            //build new transaction
            TransactionVO *tran = [[TransactionVO alloc] init];
        
            tran.seatNumber = seat;
            tran.fareClass = fare;
            tran.ffStatus = ffSt;
            tran.itemId = itmId;
            tran.amount = amt;
            tran.currency = cur;
            tran.paymentType = payType;
            tran.track = trck;
            tran.uniqueTransactionId = uniTranId;
            NSArray *emvIds = [transReportMember elementsForName:EMVapplidentifierTAG];
            if (emvIds.count > 0)
            {
                [self BuildEMVTransaction:transReportMember tran:tran];
            }
            
            [trans.transactionRecords addObject :tran];
        }
    }
    @catch(NSException *e)
    {
        NSLog(@"Exception %@...", e.reason);
        @throw;
    }
    
    return trans;
}
- (void)BuildEMVElement:(TransactionVO *)tran transactionElement:(GDataXMLElement *)transactionElement
{
    GDataXMLElement *aidElement = [GDataXMLNode elementWithName:EMVapplidentifierTAG stringValue:tran.eMVApplicationIdentifierField];
    [transactionElement addChild:aidElement];
    GDataXMLElement *acElement = [GDataXMLNode elementWithName:EMVApplicationCryptogramTAG stringValue:tran.eMVApplicationCryptogramField];
    [transactionElement addChild:acElement];
    GDataXMLElement *accElement = [GDataXMLNode elementWithName:EMVApplicationCurrencyCodeTAG stringValue:tran.eMVApplicationCurrencyCodeField];
    [transactionElement addChild:accElement];
    GDataXMLElement *aipElement = [GDataXMLNode elementWithName:EMVApplicationInterchangeProfileTAG stringValue:tran.eMVApplicationInterchangeProfileField];
    [transactionElement addChild:aipElement];
    GDataXMLElement *atcElement = [GDataXMLNode elementWithName:EMVApplicationTransactionCounterTAG stringValue:tran.eMVApplicationTransactionCounterField];
    [transactionElement addChild:atcElement];
    GDataXMLElement *aucElement = [GDataXMLNode elementWithName:EMVApplicationUsageControlTAG stringValue:tran.eMVApplicationUsageControlField];
    [transactionElement addChild:aucElement];
    GDataXMLElement *avnElement = [GDataXMLNode elementWithName:EMVApplicationVersionNumberTAG stringValue:tran.eMVApplicationVersionNumberField];
    [transactionElement addChild:avnElement];
    GDataXMLElement *arcElement = [GDataXMLNode elementWithName:EMVAuthorisationResponseCodeTAG stringValue:tran.eMVAuthorizationResponseCodeField];
    [transactionElement addChild:arcElement];
    GDataXMLElement *cvmElement = [GDataXMLNode elementWithName:EMVCardholderVerificationMethodResultTAG stringValue:tran.eMVCardholderVerificationMethodResultsField];
    [transactionElement addChild:cvmElement];
    GDataXMLElement *cidElement = [GDataXMLNode elementWithName:EMVCryptogramInformationDataTAG stringValue:tran.eMVCryptogramInformationDataField];
    [transactionElement addChild:cidElement];
    GDataXMLElement *cttElement = [GDataXMLNode elementWithName:EMVCryptogramTransactionTypeTAG stringValue:tran.eMVCryptogramTransactionTypeField];
    [transactionElement addChild:cttElement];
    GDataXMLElement *dfnElement = [GDataXMLNode elementWithName:EMVDedicatedFileNameTAG stringValue:tran.eMVDedicatedFileNameField];
    [transactionElement addChild:dfnElement];
    GDataXMLElement *idsnElement = [GDataXMLNode elementWithName:EMVInterfaceDeviceSerialNumberTAG stringValue:tran.eMVInterfaceDeviceSerialNumberField];
    [transactionElement addChild:idsnElement];
    GDataXMLElement *iacdElement = [GDataXMLNode elementWithName:EMVIssuerActionCodeDefaultTAG stringValue:tran.eMVIssuerActionCodeDefaultField];
    [transactionElement addChild:iacdElement];
    GDataXMLElement *iacddElement = [GDataXMLNode elementWithName:EMVIssuerActionCodeDenialTAG stringValue:tran.eMVIssuerActionCodeDenialField];
    [transactionElement addChild:iacddElement];
    GDataXMLElement *iacoElement = [GDataXMLNode elementWithName:EMVIssuerActionCodeOnlineTAG stringValue:tran.eMVIssuerActionCodeOnlineField];
    [transactionElement addChild:iacoElement];
    GDataXMLElement *iadElement = [GDataXMLNode elementWithName:EMVIssuerApplicationDataTAG stringValue:tran.eMVIssuerApplicationDataField];
    [transactionElement addChild:iadElement];
    GDataXMLElement *iccElement = [GDataXMLNode elementWithName:EMVIssuerCountryCodeTAG stringValue:tran.eMVIssuerCountryCodeField];
    [transactionElement addChild:iccElement];
    GDataXMLElement *isrElement = [GDataXMLNode elementWithName:EMVIssuerScriptResultsTAG stringValue:tran.eMVIssuerScriptResultsField];
    [transactionElement addChild:isrElement];
    GDataXMLElement *psnElement = [GDataXMLNode elementWithName:EMVPanSequenceNumberTAG stringValue:tran.eMVPanSequenceNumber];
    [transactionElement addChild:psnElement];
    GDataXMLElement *scElement = [GDataXMLNode elementWithName:EMVServiceCodeTAG stringValue:tran.eMVServiceCode];
    [transactionElement addChild:scElement];
    GDataXMLElement *sfiElement = [GDataXMLNode elementWithName:EMVShortFileIdentifierTAG stringValue:tran.eMVShortFileIdentifier];
    [transactionElement addChild:sfiElement];
    GDataXMLElement *tcElement = [GDataXMLNode elementWithName:EMVTerminalCapabilitiesTAG stringValue:tran.eMVTerminalCapabilitiesField];
    [transactionElement addChild:tcElement];
    GDataXMLElement *tccoElement = [GDataXMLNode elementWithName:EMVTerminalCountryCodeTAG stringValue:tran.eMVTerminalCountryCodeField];
    [transactionElement addChild:tccoElement];
    GDataXMLElement *ttElement = [GDataXMLNode elementWithName:EMVTerminalTypeTAG stringValue:tran.eMVTerminalTypeField];
    [transactionElement addChild:ttElement];
    GDataXMLElement *tvrElement = [GDataXMLNode elementWithName:EMVTerminalVerificationResultsTAG stringValue:tran.eMVTerminalVerificationResultsField];
    [transactionElement addChild:tvrElement];
    GDataXMLElement *tmElement = [GDataXMLNode elementWithName:EMVTransactionAmountTAG stringValue:tran.eMVTransactionAmountField];
    [transactionElement addChild:tmElement];
    GDataXMLElement *tccodElement = [GDataXMLNode elementWithName:EMVTransactionCategoryCodeTAG stringValue:tran.eMVTransactionCategoryCodeField];
    [transactionElement addChild:tccodElement];
    GDataXMLElement *trccoElement = [GDataXMLNode elementWithName:EMVTransactionCurrencyCodeTAG stringValue:tran.eMVTransactionCurrencyCodeField];
    [transactionElement addChild:trccoElement];
    GDataXMLElement *tdElement = [GDataXMLNode elementWithName:EMVTransactionDateTAG stringValue:tran.eMVTransactionDateField];
    [transactionElement addChild:tdElement];
    GDataXMLElement *tsciElement = [GDataXMLNode elementWithName:EMVTransactionSequenceCounterIDTAG stringValue:tran.eMVTransactionSequenceCounterIDField];
    [transactionElement addChild:tsciElement];
    GDataXMLElement *tsiElement = [GDataXMLNode elementWithName:EMVTransactionStatusInformationTAG stringValue:tran.eMVTransactionStatusInformationField];
    [transactionElement addChild:tsiElement];
    GDataXMLElement *upnElement = [GDataXMLNode elementWithName:EMVUnpredictableNumberTAG stringValue:tran.eMVUnpredictableNumberField];
    [transactionElement addChild:upnElement];
}

- (void)saveTransactions:(Transactions *)transactions :(NSString*)fileName
{
    @try
    {
        GDataXMLElement * paymentReportElement;
        paymentReportElement = [GDataXMLNode elementWithName:PaymentReportTAG];   //root

        GDataXMLElement * generalInfoElement = [GDataXMLNode elementWithName:GeneralInfoTAG];

        GDataXMLElement *companyIdElement = [GDataXMLNode elementWithName:CompanyIdTAG stringValue:[NSString stringWithFormat:@"%d", transactions.info.companyId]];
        GDataXMLElement *deviceIdElement = [GDataXMLNode elementWithName:DeviceIdTAG stringValue:transactions.info.deviceId];
        GDataXMLElement *crewIdElement = [GDataXMLNode elementWithName:CrewIdTAG stringValue:[NSString stringWithFormat:@"%d", transactions.info.crewId]];
        GDataXMLElement *flightNumberElement = [GDataXMLNode elementWithName:FlightNumberTAG stringValue:transactions.info.FlightNum];
        GDataXMLElement *originatingAirportElement = [GDataXMLNode elementWithName:OriginatingAirportTAG stringValue:transactions.info.OriginatingAirport];
        GDataXMLElement *destinationAirportElement = [GDataXMLNode elementWithName:DestinationAirportTAG stringValue:transactions.info.DestinationAirport];
        GDataXMLElement *departureTimeElement = [GDataXMLNode elementWithName:DepartureTimeTAG stringValue:[self dateToString:@"yyyy-MM-dd" :transactions.info.DepartureTime]];

        [generalInfoElement addChild:companyIdElement];
        [generalInfoElement addChild:deviceIdElement];
        [generalInfoElement addChild:crewIdElement];
        [generalInfoElement addChild:flightNumberElement];
        [generalInfoElement addChild:originatingAirportElement];
        [generalInfoElement addChild:destinationAirportElement];
        [generalInfoElement addChild:departureTimeElement];

        [paymentReportElement addChild:generalInfoElement];

        for(TransactionVO *transac in transactions.transactionRecords)
        {
            GDataXMLElement * transactionElement = [GDataXMLNode elementWithName:TransactionRecTAG];
            
            GDataXMLElement *itemIdElement = [GDataXMLNode elementWithName:ItemIdTAG stringValue:[NSString stringWithFormat:@"%d", transac.itemId]];
            GDataXMLElement *amountElement = [GDataXMLNode elementWithName:AmountTAG stringValue:transac.amount.stringValue];
            GDataXMLElement *currencyElement = [GDataXMLNode elementWithName:CurrencyTAG stringValue:transac.currency];
            GDataXMLElement *paymentTypeElement = [GDataXMLNode elementWithName:PaymentTypeTAG stringValue:transac.paymentType];
            GDataXMLElement *transactionIdElement = [GDataXMLNode elementWithName:UniqueTransactionIdTAG stringValue:transac.uniqueTransactionId];
            GDataXMLElement *trackElement = [GDataXMLNode elementWithName:TrackTAG stringValue:transac.track];
            GDataXMLElement *seatElement = [GDataXMLNode elementWithName:SeatNumberTAG stringValue:transac.seatNumber];
            GDataXMLElement *fareElement = [GDataXMLNode elementWithName:FareClassTAG stringValue:transac.fareClass];
            GDataXMLElement *ffstElement = [GDataXMLNode elementWithName:FFStatusTAG stringValue:transac.ffStatus];

            [transactionElement addChild:itemIdElement];
            [transactionElement addChild:amountElement];
            [transactionElement addChild:currencyElement];
            [transactionElement addChild:paymentTypeElement];
            [transactionElement addChild:transactionIdElement];
            [transactionElement addChild:trackElement];
            [transactionElement addChild:seatElement];
            [transactionElement addChild:fareElement];
            [transactionElement addChild:ffstElement];
            
            if(transac.eMVApplicationIdentifierField.length > 0)
            {
                [self BuildEMVElement:transac transactionElement:transactionElement];
            }
            [paymentReportElement addChild:transactionElement];
        }

        GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement:paymentReportElement];
        NSData *xmlData = document.XMLData;

        NSString *filePath = [self dataFilePath :fileName :true];
        NSLog(@"Saving xml data to %@...", filePath);
        [xmlData writeToFile:filePath atomically:YES];
    }
    @catch(NSException *e)
    {
        NSLog(@"Exception %@...", e.reason);
        @throw;
    }
}

- (bool)CheckExistance: (NSString*) uid :(Transactions*) trans
{
    for(TransactionVO *tran in trans.transactionRecords)
    {
        if ([tran.uniqueTransactionId isEqualToString:uid])
        {
            return true;
        }
    }
    return false;
}

- (void)InsertTransaction:(TransactionVO *)transaction :(GeneralInfoVO*) info
{
    bool isExist = false;
    @try
    {
        NSMutableString *fileName = [NSMutableString stringWithString:info.deviceId];
        [fileName appendString:@"-"];
        [fileName appendString:info.FlightNum];
        [fileName appendString:@"-"];
        [fileName appendString:info.OriginatingAirport];
        [fileName appendString:@"-"];
        [fileName appendString:info.DestinationAirport];
        [fileName appendString:@"-"];
        [fileName appendString:[self dateToString:@"yyyyMMdd" :info.DepartureTime]];
        [fileName appendString:@".xml"];
        
        Transactions *transacs = [self loadTransactions :fileName];
        if(transacs == nil)
        {
            transacs = [[Transactions alloc] init];
            
            transacs.info = [[GeneralInfoVO alloc] initWithName:info.companyId crewId:info.crewId deviceId:info.deviceId depTime:info.DepartureTime fltNum:info.FlightNum origAiport:info.OriginatingAirport destAirport:info.DestinationAirport];
            [transacs.transactionRecords addObject: transaction];
        }
        else
        {
            //check duplicate
            isExist = [self CheckExistance:transaction.uniqueTransactionId :transacs];
            if(!isExist)
            {
                [transacs.transactionRecords addObject: transaction];
            }
        }
        if(!isExist)
        {
            [self saveTransactions:transacs :fileName];
        }
    }
    @catch (NSException *e)
    {
        NSLog(@"Exception %@...", e.reason);
    }
  
}
@end

