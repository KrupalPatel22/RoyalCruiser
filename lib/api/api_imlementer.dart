import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:royalcruiser/api/api_url.dart';
import 'package:logger/logger.dart';
import 'package:royalcruiser/api/dio_client.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

import '../constants/common_constance.dart';

class ApiImplementer {
  static String ApplicationName = ApiUrls.APP_NAME;
  static String VerifyCall = ApiUrls.str_Key;
  static String CompanyID = ApiUrls.COMPANY_ID;
  static String AppType = ApiUrls.ApplicationType;
  static String RequestType = "2";
  static String ApplicationVersion =
      NavigatorConstants.APPLICATION_VERSION_NAME;
  static String ApplicationVersionCode =
      NavigatorConstants.APPLICATION_VERSION_CODE;
  static String DeviceID = NavigatorConstants.DEVICE_ID;
  static String DeviceOsVersion = NavigatorConstants.DEVICE_OS_VERSION;
  //static String UserId = NavigatorConstants.USER_ID;
  static Map<String, dynamic> getHeader = {
    "VerifyCall": "$VerifyCall",
    "Content-Type": "application/json"
  };
  static Logger logger = Logger();

  static Future<XmlDocument> applicationVersionCheckApiImplementer() async {
    var body = '''<?xml version="1.0" encoding="utf-8"?>
             <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
             xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
               <soapenv:Header/>
               <soapenv:Body>
                    <tem:ApplicationVersionCheck>
                       <tem:ParaComman>
                          <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                          <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                          <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                          <ns:DeviceID>$DeviceID</ns:DeviceID>
                          <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                          <ns:RequestType>$RequestType</ns:RequestType>
                          <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                          <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                       </tem:ParaComman>
                    </tem:ApplicationVersionCheck>
               </soapenv:Body>
            </soapenv:Envelope>''';

    logger.d(body);
    final response = await DioClient.getDioClient()!.post(
      '',
      options: Options(headers: {
        'soapaction': '${'${ApiUrls.str_SOAPActURL}ApplicationVersionCheck'}',
      }),
      data: body,
    );

    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      return xmlDocument;
    } else {
      throw Exception(response.statusMessage.toString());
    }
  }

  static Future<XmlDocument> PartialCancellationDetailsApiImplementer({
    required String EmailID,
    required String FromCityID,
    required String JourneyDate,
    required String PNRNo,
    required String SeatNo,
    required String ToCityID,
    required String EmailID_R,
    required String FromCityID_R,
    required String JourneyDate_R,
    required String PNRNo_R,
    required String SeatNo_R,
    required String ToCityID_R,
    required String Type,
  }) async {
    print("Type ${Type}");
    var body = Type == "0"
        ? '''<?xml version="1.0" encoding="utf-8"?>
                              <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                              xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                                 <soapenv:Header/>
                                 <soapenv:Body>
                                    <tem:PartialCancellationDetails>
                                       <tem:ParaComman>
                                          <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                          <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                          <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                          <ns:DeviceID>$DeviceID</ns:DeviceID>
                                          <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                          <ns:RequestType>$RequestType</ns:RequestType>
                                          <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                          <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                       </tem:ParaComman>
                                       <tem:ParaCancellationDetails>
                                          <ns:PROP_REG_PartialCancellationDetails>
                                             <ns:EmailID>$EmailID</ns:EmailID>
                                             <ns:FromCityID>$FromCityID</ns:FromCityID>
                                             <ns:JourneyDate>$JourneyDate</ns:JourneyDate>
                                             <ns:PNRNo>$PNRNo</ns:PNRNo>
                                             <ns:SeatNo>$SeatNo</ns:SeatNo>
                                             <ns:ToCityID>$ToCityID</ns:ToCityID>
                                          </ns:PROP_REG_PartialCancellationDetails>
                                       </tem:ParaCancellationDetails>
                                    </tem:PartialCancellationDetails>
                                 </soapenv:Body>
                              </soapenv:Envelope>'''
        : '''<?xml version="1.0" encoding="utf-8"?>
                                        <soapenv:Envelope
                                        	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                                        	xmlns:tem="http://tempuri.org/"
                                        	xmlns:ns="http://schemas.datacontract.org/2004/07/">
                                        	<soapenv:Header/>
                                        	<soapenv:Body>
                                        		<tem:PartialCancellationDetails>
                                        			<tem:ParaComman>
                                        				<ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                        				<ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                        				<ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                        				<ns:DeviceID>$DeviceID</ns:DeviceID>
                                        				<ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                        				<ns:RequestType>$RequestType</ns:RequestType>
                                        				<ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                        				<ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                        			</tem:ParaComman>
                                        			<tem:ParaCancellationDetails>
                                        				<ns:PROP_REG_PartialCancellationDetails>
                                        					<ns:EmailID>$EmailID</ns:EmailID>
                                        					<ns:FromCityID>$FromCityID</ns:FromCityID>
                                        					<ns:JourneyDate>$JourneyDate</ns:JourneyDate>
                                        					<ns:PNRNo>$PNRNo</ns:PNRNo>
                                        					<ns:SeatNo>$SeatNo</ns:SeatNo>
                                        					<ns:ToCityID>$ToCityID</ns:ToCityID>
                                        				</ns:PROP_REG_PartialCancellationDetails>
                                        				<ns:PROP_REG_PartialCancellationDetails>
                                        					<ns:EmailID>$EmailID_R</ns:EmailID>
                                        					<ns:FromCityID>$FromCityID_R</ns:FromCityID>
                                        					<ns:JourneyDate>$JourneyDate_R</ns:JourneyDate>
                                        					<ns:PNRNo>$PNRNo_R</ns:PNRNo>
                                        					<ns:SeatNo>$SeatNo_R</ns:SeatNo>
                                        					<ns:ToCityID>$ToCityID_R</ns:ToCityID>
                                        				</ns:PROP_REG_PartialCancellationDetails>
                                        			</tem:ParaCancellationDetails>
                                        		</tem:PartialCancellationDetails>
                                        	</soapenv:Body>
                                        </soapenv:Envelope>''';

    logger.d(body);
    final response = await DioClient.getDioClient()!.post(
      '',
      options: Options(headers: {
        'soapaction':
            '${'${ApiUrls.str_SOAPActURL}PartialCancellationDetails'} ',
      }),
      data: body,
    );
    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      return xmlDocument;
    } else {
      throw Exception(response.statusMessage.toString());
    }
  }

  static Future<XmlDocument> PartialConfirmCancellationApiImplementer({
    required String OrderDetailsID,
    required String OrderID,
    required String OrderNo,
    required String PNRNo,
    required String RefundAmount,
    required String SeatNo,
    required String OrderDetailsID_R,
    required String OrderID_R,
    required String OrderNo_R,
    required String PNRNo_R,
    required String RefundAmount_R,
    required String SeatNo_R,
  }) async {
    print("OrderDetailsID_R ${OrderDetailsID_R},");
    var body = OrderDetailsID_R != null && OrderDetailsID_R.isNotEmpty
        ? '''<?xml version="1.0" encoding="utf-8"?>
                                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                                xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                                   <soapenv:Header/>
                                   <soapenv:Body>
                                      <tem:PartialConfirmCancellation>
                                         <tem:ParaComman>
                                            <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                            <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                            <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                            <ns:DeviceID>$DeviceID</ns:DeviceID>
                                            <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                            <ns:RequestType>$RequestType</ns:RequestType>
                                            <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                            <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                         </tem:ParaComman>
                                         <tem:ParaConfirmCancellation>
                                            <ns:PROP_REG_PartialConfirmCancellation>
                                               <ns:OrderDetailsID>$OrderDetailsID</ns:OrderDetailsID>
                                               <ns:OrderID>$OrderID</ns:OrderID>
                                               <ns:OrderNo>$OrderNo</ns:OrderNo>
                                               <ns:PNRNo>$PNRNo</ns:PNRNo>
                                               <ns:RefundAmount>$RefundAmount</ns:RefundAmount>
                                               <ns:SeatNo>$SeatNo</ns:SeatNo>
                                            </ns:PROP_REG_PartialConfirmCancellation>
                                               <ns:PROP_REG_PartialConfirmCancellation>
                                               <ns:OrderDetailsID>$OrderDetailsID_R</ns:OrderDetailsID>
                                               <ns:OrderID>$OrderID_R</ns:OrderID>
                                               <ns:OrderNo>$OrderNo_R</ns:OrderNo>
                                               <ns:PNRNo>$PNRNo_R</ns:PNRNo>
                                               <ns:RefundAmount>$RefundAmount_R</ns:RefundAmount>
                                               <ns:SeatNo>$SeatNo_R</ns:SeatNo>
                                            </ns:PROP_REG_PartialConfirmCancellation>  
                                         </tem:ParaConfirmCancellation>
                                      </tem:PartialConfirmCancellation>
                                   </soapenv:Body>
                                </soapenv:Envelope>'''
        : '''<?xml version="1.0" encoding="utf-8"?>
                                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                                xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                                   <soapenv:Header/>
                                   <soapenv:Body>
                                      <tem:PartialConfirmCancellation>
                                         <tem:ParaComman>
                                            <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                            <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                            <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                            <ns:DeviceID>$DeviceID</ns:DeviceID>
                                            <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                            <ns:RequestType>$RequestType</ns:RequestType>
                                            <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                            <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                         </tem:ParaComman>
                                         <tem:ParaConfirmCancellation>
                                            <ns:PROP_REG_PartialConfirmCancellation>
                                               <ns:OrderDetailsID>$OrderDetailsID</ns:OrderDetailsID>
                                               <ns:OrderID>$OrderID</ns:OrderID>
                                               <ns:OrderNo>$OrderNo</ns:OrderNo>
                                               <ns:PNRNo>$PNRNo</ns:PNRNo>
                                               <ns:RefundAmount>$RefundAmount</ns:RefundAmount>
                                               <ns:SeatNo>$SeatNo</ns:SeatNo>
                                            </ns:PROP_REG_PartialConfirmCancellation>
                                             </tem:ParaConfirmCancellation>
                                      </tem:PartialConfirmCancellation>
                                   </soapenv:Body>
                                </soapenv:Envelope>''';

    logger.d(body);
    final response = await DioClient.getDioClient()!.post(
      '',
      options: Options(headers: {
        'soapaction':
            '${'${ApiUrls.str_SOAPActURL}PartialConfirmCancellation'} ',
      }),
      data: body,
    );
    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      return xmlDocument;
    } else {
      throw Exception(response.statusMessage.toString());
    }

    // return XmlDocument();
  }

  static Future<XmlDocument>
      CheckValidPNRNOAndFetchTicketPrintDataApiImplementer({
    required String PNRNo,
  }) async {
    print("object");
    var body = '''<?xml version="1.0" encoding="utf-8"?>
                        <soapenv:Envelope
                        	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                        	xmlns:tem="http://tempuri.org/"
                        	xmlns:ns="http://schemas.datacontract.org/2004/07/">
                        	<soapenv:Header/>
                        	<soapenv:Body>
                        		<tem:CheckValidPNRNOAndFetchTicketPrintData>
                        			<tem:ParaComman>
                        				<ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                        				<ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                        				<ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                        				<ns:DeviceID>$DeviceID</ns:DeviceID>
                        				<ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                        				<ns:RequestType>$RequestType</ns:RequestType>
                        				<ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                        				<ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                        			</tem:ParaComman>
                        			<tem:Para_TE>
                        				<ns:API_CompanyID>$CompanyID</ns:API_CompanyID>
                        				<ns:CompanyID>1</ns:CompanyID>
                        				<ns:CustPhone></ns:CustPhone>
                        				<ns:PNRNo>$PNRNo</ns:PNRNo>
                        				<ns:SenderIP></ns:SenderIP>
                        				<ns:SiteID>3</ns:SiteID>
                        			</tem:Para_TE>
                        		</tem:CheckValidPNRNOAndFetchTicketPrintData>
                        	</soapenv:Body>
                        </soapenv:Envelope>''';

    logger.d(body);

    final response = await DioClient.getDioClient()!.post(
      '',
      options: Options(headers: {
        'soapaction':
            '${'${ApiUrls.str_SOAPActURL}CheckValidPNRNOAndFetchTicketPrintData'} ',
      }),
      data: body,
    );

    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      return xmlDocument;
    } else {
      throw Exception(response.statusMessage.toString());
    }
  }

  static Future<XmlDocument> applicationSplashScreenListApiImplementer(
      {required String currentDate,
      required String height,
      required String width}) async {
    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction':
            '${'${ApiUrls.str_SOAPActURL}ApplicationSplashScreenList'} ',
      },
      body: '''<?xml version="1.0" encoding="utf-8"?>
                        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                        xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                           <soapenv:Header/>
                           <soapenv:Body>
                              <tem:ApplicationSplashScreenList>
                                 <tem:ParaComman>
                                    <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                    <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                    <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                    <ns:DeviceID>$DeviceID</ns:DeviceID>
                                    <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                    <ns:RequestType>$RequestType</ns:RequestType>
                                    <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                    <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                 </tem:ParaComman>
                                 <tem:ParaSplashScreen>
                                    <ns:CurrentDate>$currentDate</ns:CurrentDate>
                                    <ns:Height>$height</ns:Height>
                                    <ns:Width>$width</ns:Width>
                                 </tem:ParaSplashScreen>
                              </tem:ApplicationSplashScreenList>
                           </soapenv:Body>
                        </soapenv:Envelope>''',
    );
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception('${response.body}');
    }
  }

  static Future<XmlDocument> getSourceB2Cv2ApiImplementer() async {
    final response = await DioClient.getDioClient()!.post(
      '',
      options: Options(headers: {
        'soapaction': '${'${ApiUrls.str_SOAPActURL}GetSources'} ',
      }),
      data: '''<?xml version="1.0" encoding="utf-8"?>
                        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                        xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                           <soapenv:Header/>
                           <soapenv:Body>
                              <tem:GetSources>
                                 <tem:ParaComman>
                                    <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                    <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                    <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                    <ns:DeviceID>$DeviceID</ns:DeviceID>
                                    <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                    <ns:RequestType>$RequestType</ns:RequestType>
                                    <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                    <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                 </tem:ParaComman>
                              </tem:GetSources>
                           </soapenv:Body>
                        </soapenv:Envelope>''',
    );
    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      return xmlDocument;
    } else {
      throw Exception(response.statusMessage.toString());
    }
  }

  static Future<XmlDocument> getDestinationsBasedOnSourceApiImplementer(
      {required String sourceID}) async {
    final response = await DioClient.getDioClient()!.post(
      '',
      options: Options(headers: {
        'soapaction':
            '${'${ApiUrls.str_SOAPActURL}GetDestinationsBasedOnSource'} ',
      }),
      data: '''<?xml version="1.0" encoding="utf-8"?>
              <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                 <soapenv:Header/>
                 <soapenv:Body>
                    <tem:GetDestinationsBasedOnSource>
                       <tem:ParaDes>
                          <ns:SourceID>$sourceID</ns:SourceID>
                       </tem:ParaDes>
                       <tem:ParaComman>
                          <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                          <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                          <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                          <ns:DeviceID>$DeviceID</ns:DeviceID>
                          <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                          <ns:RequestType>$RequestType</ns:RequestType>
                          <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                          <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                       </tem:ParaComman>
                    </tem:GetDestinationsBasedOnSource>
                 </soapenv:Body>
              </soapenv:Envelope>''',
    );
    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      return xmlDocument;
    } else {
      throw Exception(response.statusMessage.toString());
    }
  }

  static Future<XmlDocument> chkRegCust({
    required String mailId,
    required String phnNo,
  }) async {
    var body = '''<?xml version="1.0" encoding="utf-8"?>
                      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                      xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                                     <soapenv:Header/>
                                     <soapenv:Body>
                                        <tem:Cheack_RegisterdCustomer>
                       		                <tem:VerifyCall>$VerifyCall</tem:VerifyCall>
                                          <tem:CustEmail>$mailId</tem:CustEmail>
                                          <tem:CustMobile>$phnNo</tem:CustMobile>
                       		             </tem:Cheack_RegisterdCustomer>
                                     </soapenv:Body>
                                  </soapenv:Envelope>''';
    logger.d(body);
    final http.Response response = await http.post(
      Uri.parse(ApiUrls.str_URL),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}Cheack_RegisterdCustomer'} ',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception(response.body);
    }
  }

  static Future<XmlDocument> getOTPLoginApiImplementer({
    required String CustMobile,
  }) async {
    var a = 0;
    a++;
    print('hi: $a');
    var body = '''<?xml version="1.0" encoding="utf-8"?>
                      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                      xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                                     <soapenv:Header/>
                                     <soapenv:Body>
                                        <tem:OTPBaseLogin>
                                           <tem:ParaComman>
                                              <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                              <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                              <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                              <ns:DeviceID>$DeviceID</ns:DeviceID>
                                              <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                              <ns:RequestType>$RequestType</ns:RequestType>
                                              <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                              <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                           </tem:ParaComman>
                                           <tem:CustMobile>$CustMobile</tem:CustMobile>
                                        </tem:OTPBaseLogin>
                                     </soapenv:Body>
                                  </soapenv:Envelope>''';
    logger.d(body);
    final http.Response response = await http.post(
      Uri.parse(ApiUrls.str_URL),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}OTPBaseLogin'} ',
      },
      body: body,
    );

    logger.d(body);

    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception(response.body);
    }
  }

  static Future<XmlDocument> getApplicationExtraSettingsApiImplementer() async {
    var data = '''<?xml version="1.0" encoding="utf-8"?>
                        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                        xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                           <soapenv:Header/>
                           <soapenv:Body>
                              <tem:GetApplicationExtraSettings>
                                 <tem:ParaComman>
                                    <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                    <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                    <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                    <ns:DeviceID>$DeviceID</ns:DeviceID>
                                    <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                    <ns:RequestType>$RequestType</ns:RequestType>
                                    <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                    <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                 </tem:ParaComman>
                              </tem:GetApplicationExtraSettings>
                           </soapenv:Body>
                        </soapenv:Envelope>''';
    final response = await DioClient.getDioClient()!.post(
      '',
      options: Options(headers: {
        'soapaction':
            '${'${ApiUrls.str_SOAPActURL}GetApplicationExtraSettings'} ',
      }),
      data: data,
    );
    // logger.d(data);
    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      return xmlDocument;
    } else {
      throw Exception(response.statusMessage.toString());
    }
  }

  static Future<XmlDocument> getCompanyAboutUsApiImplementer() async {
    final response = await DioClient.getDioClient()!.post(
      '',
      options: Options(headers: {
        'soapaction': '${'${ApiUrls.str_SOAPActURL}GetCompanyAboutus'} ',
      }),
      data: '''<?xml version="1.0" encoding="utf-8"?>
                          <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                          xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                             <soapenv:Header/>
                             <soapenv:Body>
                                <GetCompanyAboutus xmlns="http://tempuri.org/">
                                   <tem:ParaComman>
                                      <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                      <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                      <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                      <ns:DeviceID>$DeviceID</ns:DeviceID>
                                      <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                      <ns:RequestType>$RequestType</ns:RequestType>
                                      <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                      <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                   </tem:ParaComman>
                                </GetCompanyAboutus>
                             </soapenv:Body>
                          </soapenv:Envelope>''',
    );
    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      return xmlDocument;
    } else {
      throw Exception(response.statusMessage.toString());
    }
  }

  static Future<XmlDocument> getAvailableRouteSTaxApiImplementer({
    required String FromID,
    required String ToID,
    required String JourneyDate,
  }) async {
    var data = '''<?xml version="1.0" encoding="utf-8"?>
                        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                        xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                           <soapenv:Header/>
                           <soapenv:Body>
                              <tem:GetAvailableRoutes_STax>
                                 <tem:ParaComman>
                                    <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                    <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                    <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                    <ns:DeviceID>$DeviceID</ns:DeviceID>
                                    <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                    <ns:RequestType>$RequestType</ns:RequestType>
                                    <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                    <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                 </tem:ParaComman>
                                 <tem:FromID>$FromID</tem:FromID>
                                 <tem:ToID>$ToID</tem:ToID>
                                 <tem:JourneyDate>$JourneyDate</tem:JourneyDate>
                              </tem:GetAvailableRoutes_STax>
                           </soapenv:Body>
                        </soapenv:Envelope>''';
    logger.d(data);
    final response = await DioClient.getDioClient()!.post(
      '',
      options: Options(headers: {
        'soapaction': '${'${ApiUrls.str_SOAPActURL}GetAvailableRoutes_STax'} ',
      }),
      data: data,
    );

    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      return xmlDocument;
    } else {
      throw Exception(response.statusMessage.toString());
    }
  }

  static Future<XmlDocument> getSeatArrabgementDetailsSTaxApiImplementer({
    required String ReferenceNumber,
  }) async {
    var data = '''<?xml version="1.0" encoding="utf-8"?>
                  <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                     <soapenv:Header/>
                     <soapenv:Body>
                        <tem:GetSeatArrangementDetails_STax>
                           <tem:ParaComman>
                              <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                              <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                              <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                              <ns:DeviceID>$DeviceID</ns:DeviceID>
                              <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                              <ns:RequestType>$RequestType</ns:RequestType>
                              <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                              <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                           </tem:ParaComman>
                           <tem:ReferenceNumber>${ReferenceNumber.toString()}</tem:ReferenceNumber>
                        </tem:GetSeatArrangementDetails_STax>
                     </soapenv:Body>
                  </soapenv:Envelope>''';
    logger.d(data);

    final response = await DioClient.getDioClient()!.post(
      '',
      options: Options(headers: {
        'soapaction':
            '${'${ApiUrls.str_SOAPActURL}GetSeatArrangementDetails_STax'} ',
      }),
      data: data,
    );
    // logger.d(data);
    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      return xmlDocument;
    } else {
      throw Exception(response.statusMessage.toString());
    }
  }

  static Future<XmlDocument> getTermsAndConditionApiImplementer() async {
    /*var data1 = '''<?xml version="1.0" encoding="utf-8"?>
                    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                    xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                       <soapenv:Header/>
                       <soapenv:Body>
                          <tem:GetTermsAndConditions>
                             <tem:ParaComman>
                                <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                <ns:DeviceID>$DeviceID</ns:DeviceID>
                                <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                <ns:RequestType>$RequestType</ns:RequestType>
                                <ns:UserId>$UserId</ns:UserId>
                                <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                             </tem:ParaComman>
                          </tem:GetTermsAndConditions>
                       </soapenv:Body>
                    </soapenv:Envelope>''';*/
    final response = await DioClient.getDioClient()!.post(
      '',
      options: Options(headers: {
        'soapaction': '${'${ApiUrls.str_SOAPActURL}GetTermsAndConditions'} ',
      }),
      data: '''<?xml version="1.0" encoding="utf-8"?>
                    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                    xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                       <soapenv:Header/>
                       <soapenv:Body>
                          <tem:GetTermsAndConditions>
                             <tem:ParaComman>
                                <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                <ns:DeviceID>$DeviceID</ns:DeviceID>
                                <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                <ns:RequestType>$RequestType</ns:RequestType>
                                <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                             </tem:ParaComman>
                          </tem:GetTermsAndConditions>
                       </soapenv:Body>
                    </soapenv:Envelope>''',
    );
    //logger.d(data1);
    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      return xmlDocument;
    } else {
      throw Exception(response.statusMessage.toString());
    }
  }

  static Future<XmlDocument> getCancellationPolicyApiImplementer() async {
    final response = await DioClient.getDioClient()!.post(
      '',
      options: Options(headers: {
        'soapaction': '${'${ApiUrls.str_SOAPActURL}GetCancellationPolicy'} ',
      }),
      data: '''<?xml version="1.0" encoding="utf-8"?>
                      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                      xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                         <soapenv:Header/>
                         <soapenv:Body>
                            <tem:GetCancellationPolicy>
                               <tem:ParaComman>
                                  <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                  <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                  <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                  <ns:DeviceID>$DeviceID</ns:DeviceID>
                                  <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                  <ns:RequestType>$RequestType</ns:RequestType>
                                  <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                  <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                               </tem:ParaComman>
                            </tem:GetCancellationPolicy>
                         </soapenv:Body>
                      </soapenv:Envelope>''',
    );
    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      return xmlDocument;
    } else {
      throw Exception(response.statusMessage.toString());
    }
  }

  //Todo create dio client

  static Future<XmlDocument> getSendFeedback({
    required String EmailID,
    required String MobileNo,
    required String Name,
    required String Observation,
    required String Subject,
    required String Type,
  }) async {
    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}Send_Feedback'} ',
      },
      body: '''<?xml version="1.0" encoding="utf-8"?>
                              <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/"
                              	xmlns:ns="http://schemas.datacontract.org/2004/07/">
                              	<soapenv:Header/>
                              	<soapenv:Body>
                              		<tem:Send_Feedback>
                              			<tem:ParaComman>
                              				<ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                              				<ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                              				<ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                              				<ns:DeviceID>$DeviceID</ns:DeviceID>
                              				<ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                              				<ns:RequestType>$RequestType</ns:RequestType>
                              				<ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                              				<ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                              			</tem:ParaComman>
                              			<tem:paraFeedback>
                              				<ns:EmailID>$EmailID</ns:EmailID>
                              				<ns:MobileNo>$MobileNo</ns:MobileNo>
                              				<ns:Name>$Name</ns:Name>
                              				<ns:Observation>$Observation : $DeviceID</ns:Observation>
                              				<ns:Subject>$Subject</ns:Subject>
                              				<ns:Type>$Type</ns:Type>
                              			</tem:paraFeedback>
                              		</tem:Send_Feedback>
                              	</soapenv:Body>
                              </soapenv:Envelope>''',
    );
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception('${response.body}');
    }
  }

  static Future<XmlDocument> getForgetPasswordApiImplementer({
    required String EmailID,
    required String MobileNo,
  }) async {
    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}ForgetPassword'} ',
      },
      body: '''<?xml version="1.0" encoding="utf-8"?>
                          <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                          xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                             <soapenv:Header/>
                             <soapenv:Body>
                                <tem:ForgetPassword>
                                   <tem:ParaComman>
                                      <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                      <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                      <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                      <ns:DeviceID>$DeviceID</ns:DeviceID>
                                      <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                      <ns:RequestType>$RequestType</ns:RequestType>
                                      <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                      <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                   </tem:ParaComman>
                                   <tem:paraForgetPassword>
                                      <ns:EmailID>$EmailID</ns:EmailID>
                                      <ns:MobileNo>$MobileNo</ns:MobileNo>
                                   </tem:paraForgetPassword>
                                </tem:ForgetPassword>
                             </soapenv:Body>
                          </soapenv:Envelope>''',
    );
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception('${response.body}');
    }
  }

  static Future<XmlDocument> getContactDetailsListApiImplementer() async {
    var body = '''<?xml version="1.0" encoding="utf-8"?>
                      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                      xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                         <soapenv:Header/>
                         <soapenv:Body>
                            <tem:ContactDetailsList>
                               <tem:ParaComman>
                                  <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                  <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                  <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                  <ns:DeviceID>$DeviceID</ns:DeviceID>
                                  <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                  <ns:RequestType>$RequestType</ns:RequestType>
                                  <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                  <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                               </tem:ParaComman>
                               <tem:ParaContactDetails>
                                  <ns:LastModifyDate></ns:LastModifyDate>
                               </tem:ParaContactDetails>
                            </tem:ContactDetailsList>
                         </soapenv:Body>
                      </soapenv:Envelope>''';

    logger.d(body);
    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}ContactDetailsList'} ',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception('${response.body}');
    }
  }

  static Future<XmlDocument> getDeleteCoutomerApiImplementer({
    required String CustID,
    required String CustMobileNumber,
    required String CustEmail,
  }) async {
    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}Delete_Coutomer'} ',
      },
      body: '''<?xml version="1.0" encoding="utf-8"?>
                <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                xmlns:tem="http://tempuri.org/">
                   <soapenv:Header/>
                   <soapenv:Body>
                      <tem:Delete_Coutomer>
                         <tem:CustID>$CustID</tem:CustID>
                         <tem:CustMobileNumber>$CustMobileNumber</tem:CustMobileNumber>
                         <tem:CustEmail>$CustEmail</tem:CustEmail>
                      </tem:Delete_Coutomer>
                   </soapenv:Body>
                </soapenv:Envelope>''',
    );
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception('${response.body}');
    }
  }

  static Future<XmlDocument> geAppRegApiImplementer({
    required String EmailID,
    required String Gender,
    required String MobileNo,
    required String Name,
    required String Password,
  }) async {
    var body = '''<?xml version="1.0" encoding="utf-8"?>
                     <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                     xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                       <soapenv:Header/>
                       <soapenv:Body>
                          <tem:ApplicationRegistration_V2>
                             <tem:ParaComman>
                                 <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                 <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                 <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                 <ns:DeviceID>$DeviceID</ns:DeviceID>
                                 <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                 <ns:RequestType>$RequestType</ns:RequestType>
                                 <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                 <ns:VerifyCall>$VerifyCall </ns:VerifyCall>
                             </tem:ParaComman>
                             <tem:ParaRegistration>
                                 <ns:BookingType>0</ns:BookingType>
                                 <ns:EmailID>$EmailID</ns:EmailID>
                                 <ns:Gender>$Gender</ns:Gender>
                                 <ns:MobileNo>$MobileNo</ns:MobileNo>
                                 <ns:Name>$Name</ns:Name>
                                 <ns:Password>$Password</ns:Password>
                                 <ns:Phone>$MobileNo</ns:Phone>
                                 <ns:SocialID></ns:SocialID>
                             </tem:ParaRegistration>
                          </tem:ApplicationRegistration_V2>
                       </soapenv:Body>
                     </soapenv:Envelope>''';
    logger.d(body);
    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction':
            '${'${ApiUrls.str_SOAPActURL}ApplicationRegistration_V2'} ',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception('${response.body}');
    }
  }

  static Future<XmlDocument> getApplicationVerifyVerificationCode({
    required String EmailID,
    required String MobileNo,
    required String VerificationCode,
  }) async {
    var body = '''<?xml version="1.0" encoding="utf-8"?>                    
                     <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                     xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                       <soapenv:Header/>
                       	<soapenv:Body>
                       		<tem:ApplicationVerifyVerificationCode>
                       			<tem:ParaComman>
                       				<ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                       				<ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                       				<ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                       				<ns:DeviceID>$DeviceID</ns:DeviceID>
                       				<ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                       				<ns:RequestType>$RequestType</ns:RequestType>
                       				<ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                       				<ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                       			</tem:ParaComman>
                       			<tem:ParaVerifyVerificationCode>
                       				<ns:EmailID>$EmailID</ns:EmailID>
                       				<ns:MobileNo>$MobileNo</ns:MobileNo>
                       				<ns:VerificationCode>$VerificationCode</ns:VerificationCode>
                       			</tem:ParaVerifyVerificationCode>
                       		</tem:ApplicationVerifyVerificationCode>
                       	</soapenv:Body>
                       </soapenv:Envelope>''';
    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction':
            '${'${ApiUrls.str_SOAPActURL}ApplicationVerifyVerificationCode'} ',
      },
      body: body,
    );
    print(body);
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception('${response.body}');
    }
  }

  static Future<XmlDocument> MyBookingLoginApiImplementer({
    required String EmailID,
    required String Password,
  }) async {
    var body = '''<?xml version="1.0" encoding="utf-8"?>
                        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                          xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                              <soapenv:Header/>
                              <soapenv:Body>
                                  <tem:MyBookingLogin>
                                      <tem:ParaComman>
                                          <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                          <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                          <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                          <ns:DeviceID>$DeviceID</ns:DeviceID>
                                          <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                          <ns:RequestType>$RequestType</ns:RequestType>
                                          <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                          <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                      </tem:ParaComman>
                                      <tem:ParaMyBookingLogin>
                                          <ns:EmailID>$EmailID</ns:EmailID>
                                          <ns:Password>$Password</ns:Password>
                                      </tem:ParaMyBookingLogin>
                                  </tem:MyBookingLogin>
                              </soapenv:Body>
                        </soapenv:Envelope>''';
    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}MyBookingLogin'} ',
      },
      body: body,
    );
    print(body);
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception('${response.body}');
    }
  }

  static Future<XmlDocument> CancellationDetailsApiImplementer({
    required String EmailID,
    required String FromCityID,
    required String JourneyDate,
    required String PNRNo,
    required String ToCityID,
  }) async {
    var body = '''<?xml version="1.0" encoding="utf-8"?>
                          <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                          xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                              <soapenv:Header/>
                              <soapenv:Body>
                                  <tem:CancellationDetails>
                                      <tem:ParaComman>
                                          <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                          <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                          <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                          <ns:DeviceID>$DeviceID</ns:DeviceID>
                                          <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                          <ns:RequestType>$RequestType</ns:RequestType>
                                          <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                          <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                      </tem:ParaComman>
                                      <tem:ParaCancellationDetails>
                                          <ns:EmailID>$EmailID</ns:EmailID>
                                          <ns:FromCityID>$FromCityID</ns:FromCityID>
                                          <ns:JourneyDate>$JourneyDate</ns:JourneyDate>
                                          <ns:PNRNo>$PNRNo</ns:PNRNo>
                                          <ns:ToCityID>$ToCityID</ns:ToCityID>
                                      </tem:ParaCancellationDetails>
                                  </tem:CancellationDetails>
                              </soapenv:Body>
                          </soapenv:Envelope>''';
    logger.d(body);
    final http.Response response =
        await http.post(Uri.parse('${ApiUrls.str_URL}'),
            headers: {
              'Content-Type': 'text/xml; charset=utf-8',
              'soapaction':
                  '${'${ApiUrls.str_SOAPActURL}CancellationDetails'} ',
            },
            body: body);
    if (response.statusCode == 200) {
      // logger.d(body);
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception('${response.body}');
    }
  }

  static Future<XmlDocument> ConfirmCancellationApiImplementer({
    required String OrderDetailsID,
    required String OrderNo,
    required String PNRNo,
    required String RefundAmount,
    required String OrderDetailsID_Return,
    required String PNRNo_Return,
  }) async {
    var body = '''<?xml version="1.0" encoding="utf-8"?>
                      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                      xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                          <soapenv:Header/>
                          <soapenv:Body>
                              <tem:ConfirmCancellation>
                                  <tem:ParaComman>
                                      <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                      <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                      <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                      <ns:DeviceID>$DeviceID</ns:DeviceID>
                                      <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                      <ns:RequestType>$RequestType</ns:RequestType>
                                      <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                      <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                  </tem:ParaComman>
                                  <tem:ParaConfirmCancellation>
                                      <ns:OrderDetailsID>$OrderDetailsID</ns:OrderDetailsID>
                                      <ns:OrderDetailsID_Return>$OrderDetailsID_Return</ns:OrderDetailsID_Return>
                                      <ns:OrderNo>$OrderNo</ns:OrderNo>
                                      <ns:PNRNo>$PNRNo</ns:PNRNo>
                                      <ns:PNRNo_Return>$PNRNo_Return</ns:PNRNo_Return>
                                      <ns:RefundAmount>$RefundAmount</ns:RefundAmount>
                                  </tem:ParaConfirmCancellation>
                              </tem:ConfirmCancellation>
                          </soapenv:Body>
                      </soapenv:Envelope>''';
    logger.d(body);
    final http.Response response =
        await http.post(Uri.parse('${ApiUrls.str_URL}'),
            headers: {
              'Content-Type': 'text/xml; charset=utf-8',
              'soapaction': '${'${ApiUrls.str_SOAPActURL}ConfirmCancellation'}',
            },
            body: body);
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      logger.d(body);
      return document;
    } else {
      throw Exception('${response.body}');
    }
    // throw Exception('conf cancellation');
  }

  static Future<XmlDocument> Fetch_MyBookingsApiImplementer({
    required String EmailID,
    required String Password,
  }) async {
    var data = '''<?xml version="1.0" encoding="utf-8"?>
                        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                        xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                            <soapenv:Header/>
                            <soapenv:Body>
                                <tem:Fetch_MyBookings>
                                    <tem:ParaComman>
                                        <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                        <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                        <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                        <ns:DeviceID>$DeviceID</ns:DeviceID>
                                        <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                        <ns:RequestType>$RequestType</ns:RequestType>
                                        <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                        <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                    </tem:ParaComman>
                                    <tem:paraMyBookings>
                                        <ns:EmailID>$EmailID</ns:EmailID>
                                        <ns:Password>$Password</ns:Password>
                                        <ns:CustID>${NavigatorConstants.USER_ID}</ns:CustID>
                                    </tem:paraMyBookings>
                                </tem:Fetch_MyBookings>
                            </soapenv:Body>
                        </soapenv:Envelope>''';
    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}Fetch_MyBookings'} ',
      },
      body: data,
    );
    logger.d(data);
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception('${response.body}');
    }
  }

  static Future<XmlDocument> getFetchDefaultDiscountCouponApiImplementer({
    required String TripType,
    required String EmailID,
    required String JourneyDate,
    required String MobileNo,
    required String Name,
    required String ReferenceNumber,
    String? Return_JourneyDate,
    String? Return_ReferenceNumber,
  }) async {
    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction':
            '${'${ApiUrls.str_SOAPActURL}FetchDefaultDiscountCoupon'} ',
      },
      body: TripType.compareTo("1") == 0
          ? '''<?xml version="1.0" encoding="utf-8"?>
                      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                      xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                         <soapenv:Header/>
                         <soapenv:Body>
                            <tem:FetchDefaultDiscountCoupon>
                               <tem:ParaComman>
                                  <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                  <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                  <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                  <ns:DeviceID>$DeviceID</ns:DeviceID>
                                  <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                  <ns:RequestType>$RequestType</ns:RequestType>
                                  <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                  <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                               </tem:ParaComman>
                               <tem:ParaDefaultCouponDetails>
                                  <ns:AppType>$AppType</ns:AppType>
                                  <ns:CompanyID>$CompanyID</ns:CompanyID>
                                  <ns:EmailID>$EmailID</ns:EmailID>
                                  <ns:JourneyDate>$JourneyDate</ns:JourneyDate>
                                  <ns:MobileNo>$MobileNo</ns:MobileNo>
                                  <ns:Name>$Name</ns:Name>
                                  <ns:ReferenceNumber>$ReferenceNumber</ns:ReferenceNumber>
                                  <ns:Return_JourneyDate/>
                                  <ns:Return_ReferenceNumber/>
                                  <ns:TripType>$TripType</ns:TripType>
                               </tem:ParaDefaultCouponDetails>
                            </tem:FetchDefaultDiscountCoupon>
                         </soapenv:Body>
                      </soapenv:Envelope>'''
          : '''<?xml version="1.0" encoding="utf-8"?>
                      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                      xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                         <soapenv:Header/>
                         <soapenv:Body>
                            <tem:FetchDefaultDiscountCoupon>
                               <tem:ParaComman>
                                  <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                  <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                  <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                  <ns:DeviceID>$DeviceID</ns:DeviceID>
                                  <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                  <ns:RequestType>$RequestType</ns:RequestType>
                                  <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                  <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                               </tem:ParaComman>
                               <tem:ParaDefaultCouponDetails>
                                  <ns:AppType>$AppType</ns:AppType>
                                  <ns:CompanyID>$CompanyID</ns:CompanyID>
                                  <ns:EmailID>$EmailID</ns:EmailID>
                                  <ns:JourneyDate>$JourneyDate</ns:JourneyDate>
                                  <ns:MobileNo>$MobileNo</ns:MobileNo>
                                  <ns:Name>$Name</ns:Name>
                                  <ns:ReferenceNumber>$ReferenceNumber</ns:ReferenceNumber>
                                  <ns:Return_JourneyDate>$Return_JourneyDate</ns:Return_JourneyDate>
                                  <ns:Return_ReferenceNumber>$Return_ReferenceNumber</ns:Return_ReferenceNumber>
                                  <ns:TripType>$TripType</ns:TripType>
                               </tem:ParaDefaultCouponDetails>
                            </tem:FetchDefaultDiscountCoupon>
                         </soapenv:Body>
                      </soapenv:Envelope>''',
    );
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception('${response.body}');
    }
  }

  static Future<XmlDocument> getApplyDiscountCouponApiImplementer({
    required String TripType,
    required String CouponCode,
    required String EmailID,
    required String MobileNo,
    required String ReferenceNumber,
    required String IsIncludeTax,
    required String OnwardSeatTotal,
    required String OnwardTotalAmount,
    required String SeatDetails,
    required String ServiceTaxPer,
    required String ServiceTaxRoundUP,
    required String isInsurance,
    String? RReferenceNumber,
    String? RIsIncludeTax,
    String? ReturnSeatTotal,
    String? ReturnTotalAmount,
    String? RSeatDetails,
    String? RServiceTaxPer,
    String? RServiceTaxRoundUP,
  }) async {
    var data = TripType.compareTo("1") == 0
        ? '''<?xml version="1.0" encoding="utf-8"?>
                    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                    xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                       <soapenv:Header/>
                       <soapenv:Body>
                          <tem:ApplyDiscountCoupon_V2>
                             <tem:ParaComman>
                                <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                <ns:DeviceID>$DeviceID</ns:DeviceID>
                                <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                <ns:RequestType>$RequestType</ns:RequestType>
                                <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                             </tem:ParaComman>
                             <tem:ParaDiscountCouponsCode>
                                <ns:AndroidID>$DeviceID</ns:AndroidID>
                                <ns:ApplicationType>$AppType</ns:ApplicationType>
                                <ns:CouponCode>$CouponCode</ns:CouponCode>
                                <ns:EmailID>$EmailID</ns:EmailID>
                                <ns:Isinsurance>$isInsurance</ns:Isinsurance>
                                <ns:IsIncludeTax>$IsIncludeTax</ns:IsIncludeTax>
                                <ns:IsIncludeTax_Return>0</ns:IsIncludeTax_Return>
                                <ns:JourneyType>$TripType</ns:JourneyType>
                                <ns:MobileNo>$MobileNo</ns:MobileNo>
                                <ns:OnwardSeatTotal>$OnwardSeatTotal</ns:OnwardSeatTotal>
                                <ns:OnwardTotalAmount>$OnwardTotalAmount</ns:OnwardTotalAmount>
                                <ns:ReferenceNumber>$ReferenceNumber</ns:ReferenceNumber>
                                <ns:ReferenceNumber_Return/>
                                <ns:RegisterMobileNo>$MobileNo</ns:RegisterMobileNo>
                                <ns:ReturnSeatTotal>0</ns:ReturnSeatTotal>
                                <ns:ReturnTotalAmount>0.0</ns:ReturnTotalAmount>
                                <ns:RouteDetails/>
                                <ns:RouteDetails_Return/>
                                <ns:SeatDetails>$SeatDetails</ns:SeatDetails>
                                <ns:SeatDetails_Return/>
                                <ns:ServiceTaxPer>$ServiceTaxPer</ns:ServiceTaxPer>
                                <ns:ServiceTaxPer_Return>0.0</ns:ServiceTaxPer_Return>
                                <ns:ServiceTaxRoundUP>$ServiceTaxRoundUP</ns:ServiceTaxRoundUP>
                                <ns:ServiceTaxRoundUP_Return>0</ns:ServiceTaxRoundUP_Return>
                             </tem:ParaDiscountCouponsCode>
                          </tem:ApplyDiscountCoupon_V2>
                       </soapenv:Body>
                    </soapenv:Envelope>'''
        : '''<?xml version="1.0" encoding="utf-8"?>
                    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                    xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                       <soapenv:Header/>
                       <soapenv:Body>
                          <tem:ApplyDiscountCoupon_V2>
                             <tem:ParaComman>
                                <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                <ns:DeviceID>$DeviceID</ns:DeviceID>
                                <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                <ns:RequestType>$RequestType</ns:RequestType>
                                <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                             </tem:ParaComman>
                             <tem:ParaDiscountCouponsCode>
                                <ns:AndroidID>$DeviceID</ns:AndroidID>
                                <ns:ApplicationType>$AppType</ns:ApplicationType>
                                <ns:CouponCode>$CouponCode</ns:CouponCode>
                                <ns:EmailID>$EmailID</ns:EmailID>
                                <ns:Isinsurance>$isInsurance</ns:Isinsurance>
                                <ns:IsIncludeTax>$IsIncludeTax</ns:IsIncludeTax>
                                <ns:IsIncludeTax_Return>$RIsIncludeTax</ns:IsIncludeTax_Return>
                                <ns:JourneyType>$TripType</ns:JourneyType>
                                <ns:MobileNo>$MobileNo</ns:MobileNo>
                                <ns:OnwardSeatTotal>$OnwardSeatTotal</ns:OnwardSeatTotal>
                                <ns:OnwardTotalAmount>$OnwardTotalAmount</ns:OnwardTotalAmount>
                                <ns:ReferenceNumber>$ReferenceNumber</ns:ReferenceNumber>
                                <ns:ReferenceNumber_Return>$RReferenceNumber</ns:ReferenceNumber_Return>
                                <ns:RegisterMobileNo>$MobileNo</ns:RegisterMobileNo>
                                <ns:ReturnSeatTotal>$ReturnSeatTotal</ns:ReturnSeatTotal>
                                <ns:ReturnTotalAmount>$ReturnTotalAmount</ns:ReturnTotalAmount>
                                <ns:RouteDetails></ns:RouteDetails>
                                <ns:RouteDetails_Return/>
                                <ns:SeatDetails>$SeatDetails</ns:SeatDetails>
                                <ns:SeatDetails_Return>$RSeatDetails</ns:SeatDetails_Return>
                                <ns:ServiceTaxPer>$ServiceTaxPer</ns:ServiceTaxPer>
                                <ns:ServiceTaxPer_Return>$RServiceTaxPer</ns:ServiceTaxPer_Return>
                                <ns:ServiceTaxRoundUP>$ServiceTaxRoundUP</ns:ServiceTaxRoundUP>
                                <ns:ServiceTaxRoundUP_Return>$RServiceTaxRoundUP</ns:ServiceTaxRoundUP_Return>
                             </tem:ParaDiscountCouponsCode>
                          </tem:ApplyDiscountCoupon_V2>
                       </soapenv:Body>
                    </soapenv:Envelope>''';
    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}ApplyDiscountCoupon_V2'} ',
      },
      body: data,
    );
    logger.d(data);
    print("My res status ${response.statusCode}");
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      print("My res status ${response.statusCode}");
      throw Exception('${response.body}');
    }
  }

  static Future<XmlDocument> blockTypeV2ApiImplementer({
    required String ReferenceNumber,
    required String PassengerName,
    required String SeatNames,
    required String Email,
    required String Phone,
    required String PickupID,
    required String PayableAmount,
    required String TotalPassengers,
  }) async {
    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}BlockSeatV2'} ',
      },
      body: '''<?xml version="1.0" encoding="utf-8"?>
                 <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                   xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                       <soapenv:Header/>
                       <soapenv:Body>
                           <tem:BlockSeatV2>
                               <tem:ParaComman>
                                   <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                   <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                   <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                   <ns:DeviceID>$DeviceID</ns:DeviceID>
                                   <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                   <ns:RequestType>$RequestType</ns:RequestType>
                                   <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                   <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                               </tem:ParaComman>
                                  <tem:ReferenceNumber>$ReferenceNumber</tem:ReferenceNumber>
                                  <tem:PassengerName>$PassengerName</tem:PassengerName>
                                  <tem:SeatNames>$SeatNames</tem:SeatNames>
                                  <tem:Email>$Email</tem:Email>
                                  <tem:Phone>$Phone</tem:Phone>
                                  <tem:PickupID>$PickupID</tem:PickupID>
                                  <tem:PayableAmount>$PayableAmount</tem:PayableAmount>
                                  <tem:TotalPassengers>$TotalPassengers</tem:TotalPassengers>
                           </tem:BlockSeatV2>
                        </soapenv:Body>
                 </soapenv:Envelope>''',
    );
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception('${response.body}');
    }
  }

  static Future<XmlDocument> insertOrderApiImplementer({
    required String TripType,
    required String CouponCode,
    required String CouponID,
    required String EmailID,
    required String MobileNo,
    required String Name,
    required String OrderAmount,
    required String OrderDiscount,
    required String Surcharges_total,

/////////////////////////////////////////////////////////////

    String? Surcharges,
    required String AgeList,
    required String ArrangementID,
    required String ArrangementName,
    required String BaseFare,
    required String BaseFareList,
    required String BusType,
    required String BusTypeName,
    required String CityTime,
    required String DiscPerAmount,
    required String DiscountSeatDetails,
    required String DropID,
    required String DropName,
    required String DropTime,
    required String FromCityId,
    required String FromCityName,
    required String ITS_SeatString,
    required String IsIncludeTax,
    required String JourneyDate,
    required String MainRouteName,
    required String OriginalAmount,
    required String PNRAmount,
    required String Passengerlist,
    required String PickUpID,
    required String PickupName,
    required String PickupTime,
    required String ReferenceNumber,
    required String RoundUpList,
    required String RouteId,
    required String RouteTime,
    required String RouteTimeId,
    required String STax,
    required String STaxRoundUp,
    required String SeatFares,
    required String SeatGenders,
    required String SeatList,
    required String SeatNames,
    required String ServiceTax,
    required String ServiceTaxList,
    required String ServiceTaxPer,
    required String ServiceTaxRoundUP,
    required String SubRoute,
    required String ToCityId,
    required String ToCityName,
    required String TotalPax,
    required String TotalSeaterAmt,
    required String TotalSeaters,
    required String TotalSemiSleeperAmt,
    required String TotalSemiSleepers,
    required String TotalSleeperAmt,
    required String TotalSleepers,
//////////////////////////////////////////////

    String? Surcharges_total_R,
    String? AgeList_R,
    String? Surcharges_R,
    String? ArrangementID_R,
    String? ArrangementName_R,
    String? BaseFare_R,
    String? BaseFareList_R,
    String? BusType_R,
    String? BusTypeName_R,
    String? CityTime_R,
    String? DiscPerAmount_R,
    String? DiscountSeatDetails_R,
    String? DropID_R,
    String? DropName_R,
    String? DropTime_R,
    String? FromCityId_R,
    String? FromCityName_R,
    String? ITS_SeatString_R,
    String? IsIncludeTax_R,
    String? JourneyDate_R,
    String? MainRouteName_R,
    String? OriginalAmount_R,
    String? PNRAmount_R,
    String? Passengerlist_R,
    String? PickUpID_R,
    String? PickupName_R,
    String? PickupTime_R,
    String? ReferenceNumber_R,
    String? RoundUpList_R,
    String? RouteId_R,
    String? RouteTime_R,
    String? RouteTimeId_R,
    String? STax_R,
    String? STaxRoundUp_R,
    String? SeatFares_R,
    String? SeatGenders_R,
    String? SeatList_R,
    String? SeatNames_R,
    String? ServiceTax_R,
    String? ServiceTaxList_R,
    String? ServiceTaxPer_R,
    String? ServiceTaxRoundUP_R,
    String? SubRoute_R,
    String? ToCityId_R,
    String? ToCityName_R,
    String? TotalPax_R,
    String? TotalSeaterAmt_R,
    String? TotalSeaters_R,
    String? TotalSemiSleeperAmt_R,
    String? TotalSemiSleepers_R,
    String? TotalSleeperAmt_R,
    String? TotalSleepers_R,
    String? TotalInsuranceChargeOnword,
    String? TotalInsuranceCharge_R,
    String? InsuranceListOnward,
    String? InsuranceChargeOnward,
    String? InsuranceList_R,
    String? InsuranceCharge_R,
  }) async {
    var body = TripType == "0"
        ? '''<?xml version="1.0" encoding="utf-8"?>
                             <soapenv:Envelope
                             	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                             	xmlns:tem="http://tempuri.org/"
                             	xmlns:ns="http://schemas.datacontract.org/2004/07/">
                             	<soapenv:Header/>
                             	<soapenv:Body>
                             		<tem:Insert_Order>
                             			<tem:ParaComman>
                             				<ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                             				<ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                             				<ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                             				<ns:DeviceID>$DeviceID</ns:DeviceID>
                             				<ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                             				<ns:RequestType>$RequestType</ns:RequestType>
                             				<ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                             				<ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                             			</tem:ParaComman>
                             			<tem:ParaOrderMaster>
                             				<ns:CouponCode>$CouponCode</ns:CouponCode>
                             				<ns:CouponID>$CouponID</ns:CouponID>
                             				<ns:EmailID>$EmailID</ns:EmailID>
                             				<ns:IsCardBooking>0</ns:IsCardBooking>
                             				<ns:IsMobileSite>2</ns:IsMobileSite>
                             				<ns:IsPhoneConfirm>0</ns:IsPhoneConfirm>
                             				<ns:MobileNo>$MobileNo</ns:MobileNo>
                             				<ns:Name>$Name</ns:Name>
                             				<ns:OrderAmount>$OrderAmount</ns:OrderAmount>
                             				<ns:OrderDiscount>$OrderDiscount</ns:OrderDiscount>
                             				<ns:OrderIsB2CPhone>0</ns:OrderIsB2CPhone>
                             				<ns:Phone>$MobileNo</ns:Phone>
                             				<ns:Remarks></ns:Remarks>
                             				<ns:Surcharges>$Surcharges</ns:Surcharges>
                             				<ns:TotalInsuranceCharge>$TotalInsuranceChargeOnword</ns:TotalInsuranceCharge>
                             			</tem:ParaOrderMaster>
                             			<tem:ParaOrderDetails>
                             				<ns:PROP_REG_OrderDetails>
                             					<ns:AgeList>$AgeList</ns:AgeList>
                             					<ns:ArrangementID>$ArrangementID</ns:ArrangementID>
                             					<ns:ArrangementName>$ArrangementName</ns:ArrangementName>
                             					<ns:BaseFare>$BaseFare</ns:BaseFare>
                             					<ns:BaseFareList>$BaseFareList</ns:BaseFareList>
                             					<ns:BusType>$BusType</ns:BusType>
                             					<ns:BusTypeName>$BusTypeName</ns:BusTypeName>
                             					<ns:CityTime>$CityTime</ns:CityTime>
                             					<ns:CompanyID>$CompanyID</ns:CompanyID>
                             					<ns:DiscPerAmount>$DiscPerAmount</ns:DiscPerAmount>
                             					<ns:DiscountSeatDetails>$DiscountSeatDetails</ns:DiscountSeatDetails>
                             					<ns:DropID>$DropID</ns:DropID>
                             					<ns:DropName>$DropName</ns:DropName>
                             					<ns:DropTime>$DropTime</ns:DropTime>
                             					<ns:FromCityId>$FromCityId</ns:FromCityId>
                             					<ns:FromCityName>$FromCityName</ns:FromCityName>
                             					<ns:ITS_SeatString>$ITS_SeatString</ns:ITS_SeatString>
                             					<ns:InsuranceCharge>$InsuranceChargeOnward</ns:InsuranceCharge>
                             					<ns:InsuranceList>$InsuranceListOnward</ns:InsuranceList>
                             					<ns:IsIncludeTax>$IsIncludeTax</ns:IsIncludeTax>
                             					<ns:JourneyDate>$JourneyDate</ns:JourneyDate>
                             					<ns:MainRouteName>$MainRouteName</ns:MainRouteName>
                             					<ns:OriginalAmount>$OriginalAmount</ns:OriginalAmount>
                             					<ns:PNRAmount>$PNRAmount</ns:PNRAmount>
                             					<ns:Passengerlist>$Passengerlist</ns:Passengerlist>
                             					<ns:PickUpID>$PickUpID</ns:PickUpID>
                             					<ns:PickupName>$PickupName</ns:PickupName>
                             					<ns:PickupTime>$PickupTime</ns:PickupTime>
                             					<ns:ReferenceNumber>$ReferenceNumber</ns:ReferenceNumber>
                             					<ns:Remarks></ns:Remarks>
                             					<ns:RoundUpList>$RoundUpList</ns:RoundUpList>
                             					<ns:RouteId>$RouteId</ns:RouteId>
                             					<ns:RouteTime>$RouteTime</ns:RouteTime>
                             					<ns:RouteTimeId>$RouteTimeId</ns:RouteTimeId>
                             					<ns:STax>$STax</ns:STax>
                             					<ns:STaxRoundUp>$STaxRoundUp</ns:STaxRoundUp>
                             					<ns:SeatFares>$SeatFares</ns:SeatFares>
                             					<ns:SeatGenders>$SeatGenders</ns:SeatGenders>
                             					<ns:SeatList>$SeatList</ns:SeatList>
                             					<ns:SeatNames>$SeatNames</ns:SeatNames>
                             					<ns:ServiceTax>$ServiceTax</ns:ServiceTax>
                             					<ns:ServiceTaxList>$ServiceTaxList</ns:ServiceTaxList>
                             					<ns:ServiceTaxPer>$ServiceTaxPer</ns:ServiceTaxPer>
                             					<ns:ServiceTaxRoundUP>$ServiceTaxRoundUP</ns:ServiceTaxRoundUP>
                             					<ns:SubRoute>$SubRoute</ns:SubRoute>
                             					<ns:Surcharges>$Surcharges</ns:Surcharges>
                             					<ns:ToCityId>$ToCityId</ns:ToCityId>
                             					<ns:ToCityName>$ToCityName</ns:ToCityName>
                             					<ns:TotalPax>$TotalPax</ns:TotalPax>
                             					<ns:TotalSeaterAmt>$TotalSeaterAmt</ns:TotalSeaterAmt>
                             					<ns:TotalSeaters>$TotalSeaters</ns:TotalSeaters>
                             					<ns:TotalSemiSleeperAmt>$TotalSemiSleeperAmt</ns:TotalSemiSleeperAmt>
                             					<ns:TotalSemiSleepers>$TotalSemiSleepers</ns:TotalSemiSleepers>
                             					<ns:TotalSleeperAmt>$TotalSleeperAmt</ns:TotalSleeperAmt>
                             					<ns:TotalSleepers>$TotalSleepers</ns:TotalSleepers>
                             				</ns:PROP_REG_OrderDetails>
                             			</tem:ParaOrderDetails>
                             		</tem:Insert_Order>
                             	</soapenv:Body>
                             </soapenv:Envelope>'''
        : '''<?xml version="1.0" encoding="utf-8"?>
              <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
                    <soapenv:Header/>
                    <soapenv:Body>
                              <tem:Insert_Order>
                                  <tem:ParaComman>
                                      <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
                                      <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
                                      <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
                                      <ns:DeviceID>$DeviceID</ns:DeviceID>
                                      <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
                                      <ns:RequestType>$RequestType</ns:RequestType>
                                      <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
                                      <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
                                  </tem:ParaComman>
                                  <tem:ParaOrderMaster>
                                      <ns:CouponCode>$CouponCode</ns:CouponCode>
                                      <ns:CouponID>$CouponID</ns:CouponID>
                                      <ns:EmailID>$EmailID</ns:EmailID>
                                      <ns:IsCardBooking>0</ns:IsCardBooking>
                                      <ns:IsMobileSite>2</ns:IsMobileSite>
                                      <ns:IsPhoneConfirm>0</ns:IsPhoneConfirm>
                                      <ns:MobileNo>$MobileNo</ns:MobileNo>
                                      <ns:Name>$Name</ns:Name>
                                      <ns:OrderAmount>$OrderAmount</ns:OrderAmount>
                                      <ns:OrderDiscount>$OrderDiscount</ns:OrderDiscount>
                                      <ns:OrderIsB2CPhone>0</ns:OrderIsB2CPhone>
                                      <ns:Phone>$MobileNo</ns:Phone>
                                      <ns:Remarks></ns:Remarks>
                                      <ns:Surcharges>$Surcharges_total_R</ns:Surcharges>
                                      <ns:TotalInsuranceCharge>$TotalInsuranceCharge_R</ns:TotalInsuranceCharge>
                                  </tem:ParaOrderMaster>
                                  <tem:ParaOrderDetails>
                                <ns:PROP_REG_OrderDetails>
                                          <ns:AgeList>$AgeList</ns:AgeList>
                                          <ns:ArrangementID>$ArrangementID</ns:ArrangementID>
                                          <ns:ArrangementName>$ArrangementName</ns:ArrangementName>
                                          <ns:BaseFare>$BaseFare</ns:BaseFare>
                                          <ns:BaseFareList>$BaseFareList</ns:BaseFareList>
                                          <ns:BusType>$BusType</ns:BusType>
                                          <ns:BusTypeName>$BusTypeName</ns:BusTypeName>
                                          <ns:CityTime>$CityTime</ns:CityTime>
                                          <ns:CompanyID>$CompanyID</ns:CompanyID>
                                          <ns:DiscPerAmount>$DiscPerAmount</ns:DiscPerAmount>
                                          <ns:DiscountSeatDetails>$DiscountSeatDetails</ns:DiscountSeatDetails>                                          
                                          <ns:DropID>$DropID</ns:DropID>
                                          <ns:DropName>$DropName</ns:DropName>
                                          <ns:DropTime>$DropTime</ns:DropTime>
                                          <ns:FromCityId>$FromCityId</ns:FromCityId>
                                          <ns:FromCityName>$FromCityName</ns:FromCityName>
                                          <ns:ITS_SeatString>$ITS_SeatString</ns:ITS_SeatString>
                                          <ns:InsuranceCharge>$InsuranceChargeOnward</ns:InsuranceCharge>
                                          <ns:InsuranceList>$InsuranceListOnward</ns:InsuranceList>
                                          <ns:IsIncludeTax>$IsIncludeTax</ns:IsIncludeTax>
                                          <ns:JourneyDate>$JourneyDate</ns:JourneyDate>
                                          <ns:MainRouteName>$MainRouteName</ns:MainRouteName>
                                          <ns:OriginalAmount>$OriginalAmount</ns:OriginalAmount>
                                          <ns:PNRAmount>$PNRAmount</ns:PNRAmount>
                                          <ns:Passengerlist>$Passengerlist</ns:Passengerlist>
                                          <ns:PickUpID>$PickUpID</ns:PickUpID>
                                          <ns:PickupName>$PickupName</ns:PickupName>
                                          <ns:PickupTime>$PickupTime</ns:PickupTime>
                                          <ns:ReferenceNumber>$ReferenceNumber</ns:ReferenceNumber>
                                          <ns:Remarks></ns:Remarks>
                                          <ns:RoundUpList>$RoundUpList</ns:RoundUpList>
                                          <ns:RouteId>$RouteId</ns:RouteId>
                                          <ns:RouteTime>$RouteTime</ns:RouteTime>
                                          <ns:RouteTimeId>$RouteTimeId</ns:RouteTimeId>
                                          <ns:STax>$STax</ns:STax>
                                          <ns:STaxRoundUp>$STaxRoundUp</ns:STaxRoundUp>
                                          <ns:SeatFares>$SeatFares</ns:SeatFares>
                                          <ns:SeatGenders>$SeatGenders</ns:SeatGenders>
                                          <ns:SeatList>$SeatList</ns:SeatList>
                                          <ns:SeatNames>$SeatNames</ns:SeatNames>
                                          <ns:ServiceTax>$ServiceTax</ns:ServiceTax>
                                          <ns:ServiceTaxList>$ServiceTaxList</ns:ServiceTaxList>
                                          <ns:ServiceTaxPer>$ServiceTaxPer</ns:ServiceTaxPer>
                                          <ns:ServiceTaxRoundUP>$ServiceTaxRoundUP</ns:ServiceTaxRoundUP>
                                          <ns:SubRoute>$SubRoute</ns:SubRoute>
                                          <ns:Surcharges>$Surcharges</ns:Surcharges>
                                          <ns:ToCityId>$ToCityId</ns:ToCityId>
                                          <ns:ToCityName>$ToCityName</ns:ToCityName>
                                          <ns:TotalPax>$TotalPax</ns:TotalPax>
                                          <ns:TotalSeaterAmt>$TotalSeaterAmt</ns:TotalSeaterAmt>
                                          <ns:TotalSeaters>$TotalSeaters</ns:TotalSeaters>
                                          <ns:TotalSemiSleeperAmt>$TotalSemiSleeperAmt</ns:TotalSemiSleeperAmt>
                                          <ns:TotalSemiSleepers>$TotalSemiSleepers</ns:TotalSemiSleepers>
                                          <ns:TotalSleeperAmt>$TotalSleeperAmt</ns:TotalSleeperAmt>
                                          <ns:TotalSleepers>$TotalSleepers</ns:TotalSleepers>
                                </ns:PROP_REG_OrderDetails>
                                <ns:PROP_REG_OrderDetails>
                                          <ns:AgeList>$AgeList_R</ns:AgeList>
                                          <ns:ArrangementID>$ArrangementID_R</ns:ArrangementID>
                                          <ns:ArrangementName>$ArrangementName_R</ns:ArrangementName>
                                          <ns:BaseFare>$BaseFare_R</ns:BaseFare>
                                          <ns:BaseFareList>$BaseFareList_R</ns:BaseFareList>
                                          <ns:BusType>$BusType_R</ns:BusType>
                                          <ns:BusTypeName>$BusTypeName_R</ns:BusTypeName>
                                          <ns:CityTime>$CityTime_R</ns:CityTime>
                                          <ns:CompanyID>$CompanyID</ns:CompanyID>
                                          <ns:DiscPerAmount>$DiscPerAmount_R</ns:DiscPerAmount>
                                          <ns:DiscountSeatDetails>$DiscountSeatDetails_R</ns:DiscountSeatDetails>                             
                                          <ns:DropID>$DropID_R</ns:DropID>
                                          <ns:DropName>$DropName_R</ns:DropName>
                                          <ns:DropTime>$DropTime_R</ns:DropTime>
                                          <ns:FromCityId>$FromCityId_R</ns:FromCityId>
                                          <ns:FromCityName>$FromCityName_R</ns:FromCityName>
                                          <ns:ITS_SeatString>$ITS_SeatString_R</ns:ITS_SeatString>
                                          <ns:InsuranceCharge>$InsuranceCharge_R</ns:InsuranceCharge>
                                          <ns:InsuranceList>$InsuranceList_R</ns:InsuranceList>
                                          <ns:IsIncludeTax>$IsIncludeTax_R</ns:IsIncludeTax>
                                          <ns:JourneyDate>$JourneyDate_R</ns:JourneyDate>
                                          <ns:MainRouteName>$MainRouteName_R</ns:MainRouteName>
                                          <ns:OriginalAmount>$OriginalAmount_R</ns:OriginalAmount>
                                          <ns:PNRAmount>$PNRAmount_R</ns:PNRAmount>
                                          <ns:Passengerlist>$Passengerlist_R</ns:Passengerlist>
                                          <ns:PickUpID>$PickUpID_R</ns:PickUpID>
                                          <ns:PickupName>$PickupName_R</ns:PickupName>
                                          <ns:PickupTime>$PickupTime_R</ns:PickupTime>
                                          <ns:ReferenceNumber>$ReferenceNumber_R</ns:ReferenceNumber>
                                          <ns:Remarks></ns:Remarks>
                                          <ns:RoundUpList>$RoundUpList_R</ns:RoundUpList>
                                          <ns:RouteId>$RouteId_R</ns:RouteId>
                                          <ns:RouteTime>$RouteTime_R</ns:RouteTime>
                                          <ns:RouteTimeId>$RouteTimeId_R</ns:RouteTimeId>
                                          <ns:STax>$STax_R</ns:STax>
                                          <ns:STaxRoundUp>$STaxRoundUp_R</ns:STaxRoundUp>
                                          <ns:SeatFares>$SeatFares_R</ns:SeatFares>
                                          <ns:SeatGenders>$SeatGenders_R</ns:SeatGenders>
                                          <ns:SeatList>$SeatList_R</ns:SeatList>
                                          <ns:SeatNames>$SeatNames_R</ns:SeatNames>
                                          <ns:ServiceTax>$ServiceTax_R</ns:ServiceTax>
                                          <ns:ServiceTaxList>$ServiceTaxList_R</ns:ServiceTaxList>
                                          <ns:ServiceTaxPer>$ServiceTaxPer_R</ns:ServiceTaxPer>
                                          <ns:ServiceTaxRoundUP>$ServiceTaxRoundUP_R</ns:ServiceTaxRoundUP>
                                          <ns:SubRoute>$SubRoute_R</ns:SubRoute>
                                          <ns:Surcharges>$Surcharges_R</ns:Surcharges>
                                          <ns:ToCityId>$ToCityId_R</ns:ToCityId>
                                          <ns:ToCityName>$ToCityName_R</ns:ToCityName>
                                          <ns:TotalPax>$TotalPax_R</ns:TotalPax>
                                          <ns:TotalSeaterAmt>$TotalSeaterAmt_R</ns:TotalSeaterAmt>
                                          <ns:TotalSeaters>$TotalSeaters_R</ns:TotalSeaters>
                                          <ns:TotalSemiSleeperAmt>$TotalSemiSleeperAmt_R</ns:TotalSemiSleeperAmt>
                                          <ns:TotalSemiSleepers>$TotalSemiSleepers_R</ns:TotalSemiSleepers>
                                          <ns:TotalSleeperAmt>$TotalSleeperAmt_R</ns:TotalSleeperAmt>
                                          <ns:TotalSleepers>$TotalSleepers_R</ns:TotalSleepers>
                                </ns:PROP_REG_OrderDetails>
                            </tem:ParaOrderDetails>
                        </tem:Insert_Order>
                    </soapenv:Body>
                </soapenv:Envelope>''';
    logger.d(body);

    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}Insert_Order'}',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception('Exception====>${response.body}');
    }
  }

  static Future<XmlDocument> getBoardingDropDetails_V2ApiImplementer({
    required String ReferenceNumber,
  }) async {
    var data =
        '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
   <soapenv:Header/>
   <soapenv:Body>
      <tem:GetBoardingDropDetails_V2>
         <!--Optional:-->
         <tem:ParaComman>
            <!--Optional:-->
               <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
            <!--Optional:-->
            <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
            <!--Optional:-->
            <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
            <!--Optional:-->
            <ns:DeviceID>$DeviceID</ns:DeviceID>
            <!--Optional:-->
            <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
            <!--Optional:-->
            <ns:RequestType>$RequestType</ns:RequestType>
            <!--Optional:-->
            <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
            <!--Optional:-->
            <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
         </tem:ParaComman>
         <!--Optional:-->
         <tem:ReferenceNumber>${ReferenceNumber.toString()}</tem:ReferenceNumber>
      </tem:GetBoardingDropDetails_V2>
   </soapenv:Body>
</soapenv:Envelope>''';

    final response = await DioClient.getDioClient()!.post(
      '',
      options: Options(headers: {
        'soapaction': '${'${ApiUrls.str_SOAPActURL}GetBoardingDropDetails_V2'}',
      }),
      data: data,
    );
    logger.d(data);
    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      return xmlDocument;
    } else {
      throw Exception(response.statusMessage.toString());
    }
  }

  static Future<XmlDocument> getGetTicketPrintDataApiImplementer({
    required String OrderId,
  }) async {
    var data =
        '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
   <soapenv:Header/>
   <soapenv:Body>
      <tem:GetTicketPrintData>
         <!--Optional:-->
         <tem:ParaComman>
            <!--Optional:-->
            <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
            <!--Optional:-->
            <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
            <!--Optional:-->
            <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
            <!--Optional:-->
            <ns:DeviceID>$DeviceID</ns:DeviceID>
            <!--Optional:-->
            <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
            <!--Optional:-->
            <ns:RequestType>$RequestType</ns:RequestType>
            <!--Optional:-->
            <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
            <!--Optional:-->
            <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
         </tem:ParaComman>
         <!--Optional:-->
         <tem:OrderId>${OrderId.toString()}</tem:OrderId>
      </tem:GetTicketPrintData>
   </soapenv:Body>  
</soapenv:Envelope>''';
    logger.d(data);

    final response = await DioClient.getDioClient()!.post(
      '',
      options: Options(headers: {
        'soapaction': '${'${ApiUrls.str_SOAPActURL}GetTicketPrintData'} ',
      }),
      data: data,
    );

    if (response.statusCode == 200) {
      XmlDocument xmlDocument = XmlDocument.parse(response.data);
      print("PickupLatitude => statusCode ${response.statusCode}");
      logger.d(response.data);
      return xmlDocument;
    } else {
      print("PickupLatitude => StatusCode ${response.statusCode}");
      throw Exception(response.statusMessage.toString());
    }
  }

  /* New api added by krupal Start */

  ///change api because login flow change(31 May 2024)
  ///New Login Flow
  /// - User can login with only mobile number
  /// - User need to verify Otp for login or register both
  /// - without otp verify user can not register.

  static Future<XmlDocument> getOTPBaseLogin_MobileBase({
    required String CustMobile,
  }) async {
    var a = 0;
    a++;
    print('hi: $a');
    var body =
        '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
   <soapenv:Header/>
   <soapenv:Body>
      <tem:OTPBaseLogin_MobileBase>
         <tem:ParaComman>
            <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
            <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
            <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
            <ns:DeviceID>$DeviceID</ns:DeviceID>
            <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
            <ns:RequestType>$RequestType</ns:RequestType>
            <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
            <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
         </tem:ParaComman>
         <!--Optional:-->
         <tem:CustMobile>$CustMobile</tem:CustMobile>
      </tem:OTPBaseLogin_MobileBase>
   </soapenv:Body>
</soapenv:Envelope>''';

    logger.d(body);
    final http.Response response = await http.post(
      Uri.parse(ApiUrls.str_URL),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}OTPBaseLogin_MobileBase'} ',
      },
      body: body,
    );

    logger.d(body);

    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception(response.body);
    }
  }

  static Future<XmlDocument> NewUser_GetOTPApiImplimenter({
    required String CustMobile,
  }) async {
    var a = 0;
    a++;
    print('hi: $a');
    var body =
        '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
   <soapenv:Header/>
   <soapenv:Body>
      <tem:NewUser_GetOTP>
         <tem:ParaComman>
            <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
            <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
            <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
            <ns:DeviceID>$DeviceID</ns:DeviceID>
            <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
            <ns:RequestType>$RequestType</ns:RequestType>
            <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
            <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
         </tem:ParaComman>
         <tem:CustMobile>$CustMobile</tem:CustMobile>
      </tem:NewUser_GetOTP>
   </soapenv:Body>
</soapenv:Envelope>''';

    logger.d(body);
    final http.Response response = await http.post(
      Uri.parse(ApiUrls.str_URL),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}NewUser_GetOTP'} ',
      },
      body: body,
    );

    logger.d(body);

    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception(response.body);
    }
  }

  static Future<XmlDocument> VerifyOTPApiImplimenter({
    required String CustMobile,
    required String CustVerificationCode,
  }) async {
    var a = 0;
    a++;

    var body =
        '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
   <soapenv:Header/>
   <soapenv:Body>
      <tem:VerifyOTP>
         <tem:VerifyCall>$VerifyCall</tem:VerifyCall>
         <tem:CustVerificationCode>$CustVerificationCode</tem:CustVerificationCode>
         <tem:CustMobile>$CustMobile</tem:CustMobile>
      </tem:VerifyOTP>
   </soapenv:Body>
</soapenv:Envelope>''';

    logger.d(body);
    final http.Response response = await http.post(
      Uri.parse(ApiUrls.str_URL),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}VerifyOTP'} ',
      },
      body: body,
    );


    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception(response.body);
    }
  }

  static Future<XmlDocument> ApplicationRegistration_MobileBase_V2({
    required String EmailID,
    required String Gender,
    required String MobileNo,
    required String Name,
    required String Password,
  }) async
  {
    var body =
        '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
   <soapenv:Header/>
   <soapenv:Body>
      <tem:ApplicationRegistration_MobileBase_V2>
         <!--Optional:-->
         <tem:ParaComman>
            <!--Optional:-->
            <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
            <!--Optional:-->
            <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
            <!--Optional:-->
            <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
            <!--Optional:-->
            <ns:DeviceID>$DeviceID</ns:DeviceID>
            <!--Optional:-->
            <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
            <!--Optional:-->
            <ns:RequestType>$RequestType</ns:RequestType>
            <!--Optional:-->
            <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
            <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
         </tem:ParaComman>
         
         <tem:ParaRegistration>
            <ns:EmailID>$EmailID</ns:EmailID>
            <!--Optional:-->
            <ns:Gender>$Gender</ns:Gender>
            <!--Optional:-->
            <ns:MobileNo>$MobileNo</ns:MobileNo>
            <!--Optional:-->
            <ns:Name>$Name</ns:Name>
            <!--Optional:-->
            <ns:Password>$Password</ns:Password>
            <!--Optional:-->
            <ns:Phone>$MobileNo</ns:Phone>
         </tem:ParaRegistration>
      </tem:ApplicationRegistration_MobileBase_V2>
   </soapenv:Body>
</soapenv:Envelope>''';
    logger.d(body);
    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction':
            '${'${ApiUrls.str_SOAPActURL}ApplicationRegistration_MobileBase_V2'} ',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception('${response.body}');
    }
  }

  static Future<XmlDocument> Select_OrderWithPaxName(
      {required String OrderID}) async {
    var body =
        '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
   <soapenv:Header/>
   <soapenv:Body>
      <tem:Select_OrderWithPaxName>
         <tem:OrderID>$OrderID</tem:OrderID>
      </tem:Select_OrderWithPaxName>
   </soapenv:Body>
</soapenv:Envelope>''';

    logger.d(body);
    final http.Response response = await http.post(
      Uri.parse('${ApiUrls.str_URL}'),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}Select_OrderWithPaxName'} ',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      log("error My res :-${response.body}");
      throw Exception('${response.body}');
    }
  }


  static Future<XmlDocument> GetTicketPrintURLApiImplimenter({
    required String PNRNO,
    required String OrderId,
  }) async {
    var a = 0;
    a++;
    print('hi: $a');
    var body =
    '''<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/" xmlns:ns="http://schemas.datacontract.org/2004/07/">
   <soapenv:Header/>
   <soapenv:Body>
      <tem:GetTicketPrintURL>
         <tem:ParaComman>
            <ns:ApplicationName>$ApplicationName</ns:ApplicationName>
            <ns:ApplicationVersion>$ApplicationVersion</ns:ApplicationVersion>
            <ns:ApplicationVersionCode>$ApplicationVersionCode</ns:ApplicationVersionCode>
            <ns:DeviceID>$DeviceID</ns:DeviceID>
            <ns:DeviceOsVersion>$DeviceOsVersion</ns:DeviceOsVersion>
            <ns:RequestType>$RequestType</ns:RequestType>
            <ns:UserId>${NavigatorConstants.USER_ID}</ns:UserId>
            <ns:VerifyCall>$VerifyCall</ns:VerifyCall>
         </tem:ParaComman>
         <tem:PNRNO>$PNRNO</tem:PNRNO>
         <tem:OrderId>$OrderId</tem:OrderId>
      </tem:GetTicketPrintURL>
   </soapenv:Body>
</soapenv:Envelope>''';

    logger.d(body);
    final http.Response response = await http.post(
      Uri.parse(ApiUrls.str_URL),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'soapaction': '${'${ApiUrls.str_SOAPActURL}GetTicketPrintURL'} ',
      },
      body: body,
    );

    logger.d(body);

    if (response.statusCode == 200) {
      XmlDocument document = XmlDocument.parse(response.body);
      return document;
    } else {
      throw Exception(response.body);
    }
  }



}