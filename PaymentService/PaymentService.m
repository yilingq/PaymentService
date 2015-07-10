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

- (void)BuildEMVTransaction:(GDataXMLElement *)transReportMember tran:(TransactionVO *)tran
{
    //[self BuildEMVTransaction:transReportMember :&tran];
    NSArray *aips = [transReportMember elementsForName:EMVApplicationInterchangeProfileTAG];
    if (aips.count > 0)
    {
        GDataXMLElement *aip = (GDataXMLElement *) [aips objectAtIndex:0];
        tran.eMVApplicationInterchangeProfileField = aip.stringValue;
    }
    else
    {
        tran.eMVApplicationInterchangeProfileField = @"";
    }
    NSArray *aids = [transReportMember elementsForName:EMVapplidentifierTAG];
    if (aids.count > 0)
    {
        GDataXMLElement *aid = (GDataXMLElement *) [aids objectAtIndex:0];
        tran.eMVApplicationIdentifierField = aid.stringValue;
    }
    else
    {
        tran.eMVApplicationIdentifierField = @"";
    }
    NSArray *tvrs = [transReportMember elementsForName:EMVTerminalVerificationResultsTAG];
    if (tvrs.count > 0)
    {
        GDataXMLElement *tvr = (GDataXMLElement *) [tvrs objectAtIndex:0];
        tran.eMVTerminalVerificationResultsField = tvr.stringValue;
    }
    else
    {
        tran.eMVTerminalVerificationResultsField = @"";
    }
    NSArray *tds = [transReportMember elementsForName:EMVTransactionDateTAG];
    if (tds.count > 0)
    {
        GDataXMLElement *td = (GDataXMLElement *) [tds objectAtIndex:0];
        tran.eMVTransactionDateField = td.stringValue;
    }
    else
    {
        tran.eMVTransactionDateField = @"";
    }
    NSArray *ctts = [transReportMember elementsForName:EMVCryptogramTransactionTypeTAG];
    if (ctts.count > 0)
    {
        GDataXMLElement *ctt = (GDataXMLElement *) [ctts objectAtIndex:0];
        tran.eMVCryptogramTransactionTypeField = ctt.stringValue;
    }
    else
    {
        tran.eMVTransactionDateField = @"";
    }
    NSArray *dfns = [transReportMember elementsForName:EMVDedicatedFileNameTAG];
    if (dfns.count > 0)
    {
        GDataXMLElement *dfn = (GDataXMLElement *) [dfns objectAtIndex:0];
        tran.eMVDedicatedFileNameField = dfn.stringValue;
    }
    else
    {
        tran.eMVDedicatedFileNameField = @"";
    }
    NSArray *iccs = [transReportMember elementsForName:EMVIssuerCountryCodeTAG];
    if (iccs.count > 0)
    {
        GDataXMLElement *icc = (GDataXMLElement *) [iccs objectAtIndex:0];
        tran.eMVIssuerCountryCodeField = icc.stringValue;
    }
    else
    {
        tran.eMVIssuerCountryCodeField = @"";
    }
    NSArray *tccs = [transReportMember elementsForName:EMVTransactionCurrencyCodeTAG];
    if (tccs.count > 0)
    {
        GDataXMLElement *tcc = (GDataXMLElement *) [tccs objectAtIndex:0];
        tran.eMVTransactionCurrencyCodeField = tcc.stringValue;
    }
    else
    {
        tran.eMVTransactionCurrencyCodeField = @"";
    }
    NSArray *tas = [transReportMember elementsForName:EMVTransactionAmountTAG];
    if (tas.count > 0)
    {
        GDataXMLElement *ta = (GDataXMLElement *) [tas objectAtIndex:0];
        tran.eMVTransactionAmountField = ta.stringValue;
    }
    else
    {
        tran.eMVTransactionAmountField = @"";
    }
    NSArray *avs = [transReportMember elementsForName:EMVApplicationVersionNumberTAG];
    if (avs.count > 0)
    {
        GDataXMLElement *av = (GDataXMLElement *) [avs objectAtIndex:0];
        tran.eMVApplicationVersionNumberField = av.stringValue;
    }
    else
    {
        tran.eMVApplicationVersionNumberField = @"";
    }
    NSArray *iads = [transReportMember elementsForName:EMVIssuerApplicationDataTAG];
    if (iads.count > 0)
    {
        GDataXMLElement *iad = (GDataXMLElement *) [iads objectAtIndex:0];
        tran.eMVIssuerApplicationDataField = iad.stringValue;
    }
    else
    {
        tran.eMVIssuerApplicationDataField = @"";
    }
    NSArray *teccs = [transReportMember elementsForName:EMVTerminalCountryCodeTAG];
    if (teccs.count > 0)
    {
        GDataXMLElement *tecc = (GDataXMLElement *) [teccs objectAtIndex:0];
        tran.eMVTerminalCountryCodeField = tecc.stringValue;
    }
    else
    {
        tran.eMVTerminalCountryCodeField = @"";
    }
    NSArray *idsns = [transReportMember elementsForName:EMVInterfaceDeviceSerialNumberTAG];
    if (idsns.count > 0)
    {
        GDataXMLElement *idsn = (GDataXMLElement *) [idsns objectAtIndex:0];
        tran.eMVInterfaceDeviceSerialNumberField = idsn.stringValue;
    }
    else
    {
        tran.eMVInterfaceDeviceSerialNumberField = @"";
    }
    NSArray *acs = [transReportMember elementsForName:EMVApplicationCryptogramTAG];
    if (acs.count > 0)
    {
        GDataXMLElement *ac = (GDataXMLElement *) [acs objectAtIndex:0];
        tran.eMVApplicationCryptogramField = ac.stringValue;
    }
    else
    {
        tran.eMVApplicationCryptogramField = @"";
    }
    NSArray *cids = [transReportMember elementsForName:EMVCryptogramInformationDataTAG];
    if (cids.count > 0)
    {
        GDataXMLElement *cid = (GDataXMLElement *) [cids objectAtIndex:0];
        tran.eMVCryptogramInformationDataField = cid.stringValue;
    }
    else
    {
        tran.eMVCryptogramInformationDataField = @"";
    }
    NSArray *tcs = [transReportMember elementsForName:EMVTerminalCapabilitiesTAG];
    if (tcs.count > 0)
    {
        GDataXMLElement *tc = (GDataXMLElement *) [tcs objectAtIndex:0];
        tran.eMVTerminalCapabilitiesField = tc.stringValue;
    }
    else
    {
        tran.eMVTerminalCapabilitiesField = @"";
    }
    NSArray *chvms = [transReportMember elementsForName:EMVCardholderVerificationMethodResultTAG];
    if (chvms.count > 0)
    {
        GDataXMLElement *chvm = (GDataXMLElement *) [chvms objectAtIndex:0];
        tran.eMVCardholderVerificationMethodResultsField = chvm.stringValue;
    }
    else
    {
        tran.eMVCardholderVerificationMethodResultsField = @"";
    }
    NSArray *tts = [transReportMember elementsForName:EMVTerminalTypeTAG];
    if (tts.count > 0)
    {
        GDataXMLElement *tt = (GDataXMLElement *) [tts objectAtIndex:0];
        tran.eMVTerminalTypeField = tt.stringValue;
    }
    else
    {
        tran.eMVTerminalTypeField = @"";
    }
    NSArray *atcs = [transReportMember elementsForName:EMVApplicationTransactionCounterTAG];
    if (atcs.count > 0)
    {
        GDataXMLElement *atc = (GDataXMLElement *) [atcs objectAtIndex:0];
        tran.eMVApplicationTransactionCounterField = atc.stringValue;
    }
    else
    {
        tran.eMVApplicationTransactionCounterField = @"";
    }
    NSArray *uns = [transReportMember elementsForName:EMVUnpredictableNumberTAG];
    if (uns.count > 0)
    {
        GDataXMLElement *un = (GDataXMLElement *) [uns objectAtIndex:0];
        tran.eMVUnpredictableNumberField = un.stringValue;
    }
    else
    {
        tran.eMVUnpredictableNumberField = @"";
    }
    NSArray *tscis = [transReportMember elementsForName:EMVTransactionSequenceCounterIDTAG];
    if (tscis.count > 0)
    {
        GDataXMLElement *tsci = (GDataXMLElement *) [tscis objectAtIndex:0];
        tran.eMVTransactionSequenceCounterIDField = tsci.stringValue;
    }
    else
    {
        tran.eMVTransactionSequenceCounterIDField = @"";
    }
    NSArray *accs = [transReportMember elementsForName:EMVApplicationCurrencyCodeTAG];
    if (accs.count > 0)
    {
        GDataXMLElement *acc = (GDataXMLElement *) [accs objectAtIndex:0];
        tran.eMVApplicationCurrencyCodeField = acc.stringValue;
    }
    else
    {
        tran.eMVApplicationCurrencyCodeField = @"";
    }
    NSArray *tccos = [transReportMember elementsForName:EMVTransactionCategoryCodeTAG];
    if (tccos.count > 0)
    {
        GDataXMLElement *tcco = (GDataXMLElement *) [tccos objectAtIndex:0];
        tran.eMVTransactionCategoryCodeField = tcco.stringValue;
    }
    else
    {
        tran.eMVTransactionCategoryCodeField = @"";
    }
    NSArray *isrs = [transReportMember elementsForName:EMVIssuerScriptResultsTAG];
    if (isrs.count > 0)
    {
        GDataXMLElement *isr = (GDataXMLElement *) [isrs objectAtIndex:0];
        tran.eMVIssuerScriptResultsField = isr.stringValue;
    }
    else
    {
        tran.eMVIssuerScriptResultsField = @"";
    }
    NSArray *arcs = [transReportMember elementsForName:EMVAuthorisationResponseCodeTAG];
    if (arcs.count > 0)
    {
        GDataXMLElement *arc = (GDataXMLElement *) [arcs objectAtIndex:0];
        tran.eMVAuthorizationResponseCodeField = arc.stringValue;
    }
    else
    {
        tran.eMVAuthorizationResponseCodeField = @"";
    }
    NSArray *iacds = [transReportMember elementsForName:EMVIssuerActionCodeDefaultTAG];
    if (iacds.count > 0)
    {
        GDataXMLElement *iacd = (GDataXMLElement *) [iacds objectAtIndex:0];
        tran.eMVIssuerActionCodeDefaultField = iacd.stringValue;
    }
    else
    {
        tran.eMVIssuerActionCodeDefaultField = @"";
    }
    NSArray *iacdns = [transReportMember elementsForName:EMVIssuerActionCodeDenialTAG];
    if (iacdns.count > 0)
    {
        GDataXMLElement *iacdn = (GDataXMLElement *) [iacdns objectAtIndex:0];
        tran.eMVIssuerActionCodeDenialField = iacdn.stringValue;
    }
    else
    {
        tran.eMVIssuerActionCodeDenialField = @"";
    }
    NSArray *iacos = [transReportMember elementsForName:EMVIssuerActionCodeOnlineTAG];
    if (iacos.count > 0)
    {
        GDataXMLElement *iaco = (GDataXMLElement *) [iacos objectAtIndex:0];
        tran.eMVIssuerActionCodeOnlineField = iaco.stringValue;
    }
    else
    {
        tran.eMVIssuerActionCodeOnlineField = @"";
    }
    NSArray *aucs = [transReportMember elementsForName:EMVApplicationUsageControlTAG];
    if (aucs.count > 0)
    {
        GDataXMLElement *auc = (GDataXMLElement *) [aucs objectAtIndex:0];
        tran.eMVApplicationUsageControlField = auc.stringValue;
    }
    else
    {
        tran.eMVApplicationUsageControlField = @"";
    }
    NSArray *tsis = [transReportMember elementsForName:EMVTransactionStatusInformationTAG];
    if (tsis.count > 0)
    {
        GDataXMLElement *tsi = (GDataXMLElement *) [tsis objectAtIndex:0];
        tran.eMVTransactionStatusInformationField = tsi.stringValue;
    }
    else
    {
        tran.eMVTransactionStatusInformationField = @"";
    }
    NSArray *sfis = [transReportMember elementsForName:EMVShortFileIdentifierTAG];
    if (sfis.count > 0)
    {
        GDataXMLElement *sfi = (GDataXMLElement *) [sfis objectAtIndex:0];
        tran.eMVShortFileIdentifier = sfi.stringValue;
    }
    else
    {
        tran.eMVShortFileIdentifier = @"";
    }
    NSArray *psns = [transReportMember elementsForName:EMVPanSequenceNumberTAG];
    if (psns.count > 0)
    {
        GDataXMLElement *psn = (GDataXMLElement *) [psns objectAtIndex:0];
        tran.eMVPanSequenceNumber = psn.stringValue;
    }
    else
    {
        tran.eMVPanSequenceNumber = @"";
    }
    NSArray *scs = [transReportMember elementsForName:EMVServiceCodeTAG];
    if (scs.count > 0)
    {
        GDataXMLElement *sc = (GDataXMLElement *) [scs objectAtIndex:0];
        tran.eMVServiceCode = sc.stringValue;
    }
    else
    {
        tran.eMVServiceCode = @"";
    }
}

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
        
        NSArray *companyIds = [genInfoMember elementsForName:CompanyIdTAG];
        if (companyIds.count > 0)
        {
            GDataXMLElement *cmpId = (GDataXMLElement *) [companyIds objectAtIndex:0];
            
            compId = (int)[cmpId.stringValue integerValue];
        }
        NSArray *crewIds = [genInfoMember elementsForName:CrewIdTAG];
        if (crewIds.count > 0)
        {
            GDataXMLElement *creId = (GDataXMLElement *) [crewIds objectAtIndex:0];
            crId = (int)[creId.stringValue integerValue];
        }
        NSArray *deviceIds = [genInfoMember elementsForName:DeviceIdTAG];
        if (deviceIds.count > 0)
        {
            GDataXMLElement *devid = (GDataXMLElement *) [deviceIds objectAtIndex:0];
            devId = devid.stringValue;
        }
        NSArray *fltIds = [genInfoMember elementsForName:FlightNumberTAG];
        if (fltIds.count > 0)
        {
            GDataXMLElement *fltid = (GDataXMLElement *) [fltIds objectAtIndex:0];
            fltNum = fltid.stringValue;
        }
        NSArray *orgAirports = [genInfoMember elementsForName:OriginatingAirportTAG];
        if (orgAirports.count > 0)
        {
            GDataXMLElement *orgAirport = (GDataXMLElement *) [orgAirports objectAtIndex:0];
            origAiport = orgAirport.stringValue;
        }
        NSArray *destAirports = [genInfoMember elementsForName:DestinationAirportTAG];
        if (destAirports.count > 0)
        {
            GDataXMLElement *dstAirport = (GDataXMLElement *) [destAirports objectAtIndex:0];
            destAirport = dstAirport.stringValue;
        }
        NSArray *deptimes = [genInfoMember elementsForName:DepartureTimeTAG];
        if (deptimes.count > 0)
        {
            GDataXMLElement *depttime = (GDataXMLElement *) [deptimes objectAtIndex:0];
            depTime = [self StringToDate: @"yyyy-MM-dd" :depttime.stringValue];
        }

        trans.info = [[GeneralInfoVO alloc] initWithName :compId crewId:crId deviceId:devId depTime:depTime fltNum:fltNum origAiport:origAiport destAirport:destAirport];
        
        for (GDataXMLElement *transReportMember in transMembers)
        {
            NSArray *itemIds = [transReportMember elementsForName:ItemIdTAG];
            if (itemIds.count > 0)
            {
                GDataXMLElement *itId = (GDataXMLElement *) [itemIds objectAtIndex:0];
                itmId = (int)[itId.stringValue integerValue];
            }
            else
            {
                continue;
            }
            NSArray *amts = [transReportMember elementsForName:AmountTAG];
            if (amts.count > 0)
            {
                GDataXMLElement *amut = (GDataXMLElement *) [amts objectAtIndex:0];
                amt = [NSDecimalNumber decimalNumberWithString:amut.stringValue];
            }
            else
            {
                continue;
            }
            NSArray *currencies = [transReportMember elementsForName:CurrencyTAG];
            if (currencies.count > 0)
            {
                GDataXMLElement *curr = (GDataXMLElement *) [currencies objectAtIndex:0];
                cur = curr.stringValue;
            }
            else
            {
                continue;
            }
            NSArray *seatNumbers = [transReportMember elementsForName:SeatNumberTAG];
            if (seatNumbers.count > 0)
            {
                GDataXMLElement *seats = (GDataXMLElement *) [seatNumbers objectAtIndex:0];
                seat = seats.stringValue;
            }
            else
            {
                continue;
            }
            NSArray *fareClasses = [transReportMember elementsForName:FareClassTAG];
            if (fareClasses.count > 0)
            {
                GDataXMLElement *fares = (GDataXMLElement *) [fareClasses objectAtIndex:0];
                fare = fares.stringValue;
            }
            else
            {
                continue;
            }
            NSArray *ffStatuses = [transReportMember elementsForName:FFStatusTAG];
            if (ffStatuses.count > 0)
            {
                GDataXMLElement *statuses = (GDataXMLElement *) [ffStatuses objectAtIndex:0];
                ffSt = statuses.stringValue;
            }
            else
            {
                continue;
            }
            NSArray *paymentTypes = [transReportMember elementsForName:PaymentTypeTAG];
            if (paymentTypes.count > 0)
            {
                GDataXMLElement *pt = (GDataXMLElement *) [paymentTypes objectAtIndex:0];
                payType = pt.stringValue;
            }
            else
            {
                continue;
            }
            NSArray *tracks = [transReportMember elementsForName:TrackTAG];
            if (tracks.count > 0)
            {
                GDataXMLElement *tck = (GDataXMLElement *) [tracks objectAtIndex:0];
                trck = tck.stringValue;
            }
            else
            {
                continue;
            }
            NSArray *uids = [transReportMember elementsForName:UniqueTransactionIdTAG];
            if (uids.count > 0)
            {
                GDataXMLElement *uid = (GDataXMLElement *) [uids objectAtIndex:0];
                uniTranId = uid.stringValue;
            }
            else
            {
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

