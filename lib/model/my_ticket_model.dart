class MyTicketModel {
  String? pNR;
  String? jMBookingDateTime;
  String? jMJourneyStartDate;
  String? cMCompanyLogo;
  String? cMEmail;
  String? cMWebsite;
  String? companyName;
  String? cMAddress;
  String? taxPayableONRev;
  String? invoiceNo;
  String? invoiceDate;
  String? invDescription;
  String? baseFare;
  String? discount;
  String? taxableValue;
  String? cGST;
  String? sGST;
  String? iGST;
  String? iGSTLbl;
  String? sGSTLbl;
  String? cGSTLbl;
  String? totalInvAmt;
  String? amountInWords;
  String? jMEmailID;
  String? jMPassengerName;
  String? jMPassengerAddress;
  String? custState;
  String? custStateCode;
  String? custGSTRegNo;
  String? journeyFromState;
  String? fromCity;
  String? toCity;
  String? cOACH;
  String? pickupName;
  String? paxDetails;
  String? jMGSTCompanyName;
  String? pickupNameShort;
  String? refundIGST;
  String? refundAmount;
  String? cancellationAmount;
  String? pANCard;
  String? jMRefundCharges;
  String? jMRefundServiceTax;
  String? jMServiceTax;
  String? companyStateCode;
  String? seatNo;
  String? pMPickupID;
  String? dMDropID;
  String? pickuptime;
  String? pickupDate;
  String? Droptime;
  String? DropDate;
  String? serverFilePath;
  String? sDiffgrId;
  String? sMsdataRowOrder;
  String? PickupLatitude;
  String? PickupLongitude;
  String? DropLatitude;
  String? DropLongitude;
  String? DropName;
  String? DropName_Short;
  String? DriverPhone;

  MyTicketModel(
      {this.pNR,
        this.jMBookingDateTime,
        this.jMJourneyStartDate,
        this.cMCompanyLogo,
        this.cMEmail,
        this.cMWebsite,
        this.companyName,
        this.cMAddress,
        this.taxPayableONRev,
        this.invoiceNo,
        this.invoiceDate,
        this.invDescription,
        this.baseFare,
        this.discount,
        this.taxableValue,
        this.cGST,
        this.sGST,
        this.iGST,
        this.iGSTLbl,
        this.sGSTLbl,
        this.cGSTLbl,
        this.totalInvAmt,
        this.amountInWords,
        this.jMEmailID,
        this.jMPassengerName,
        this.jMPassengerAddress,
        this.custState,
        this.custStateCode,
        this.custGSTRegNo,
        this.journeyFromState,
        this.fromCity,
        this.toCity,
        this.cOACH,
        this.pickupName,
        this.paxDetails,
        this.jMGSTCompanyName,
        this.pickupNameShort,
        this.refundIGST,
        this.refundAmount,
        this.cancellationAmount,
        this.pANCard,
        this.jMRefundCharges,
        this.jMRefundServiceTax,
        this.jMServiceTax,
        this.companyStateCode,
        this.seatNo,
        this.pMPickupID,
        this.dMDropID,
        this.pickuptime,
        this.pickupDate,
        this.serverFilePath,
        this.sDiffgrId,
        this.sMsdataRowOrder,
        this.PickupLatitude,
        this.PickupLongitude,
        this.DropLatitude,
        this.DropLongitude,
        this.Droptime,
        this.DropDate,
        this.DropName,
        this.DropName_Short,
        this.DriverPhone,
      });

  MyTicketModel.fromJson(Map<String, dynamic> json) {
    pNR = json['PNR'];
    jMBookingDateTime = json['JM_BookingDateTime'];
    jMJourneyStartDate = json['JM_JourneyStartDate'];
    cMCompanyLogo = json['CM_CompanyLogo'];
    cMEmail = json['CM_Email'];
    cMWebsite = json['CM_Website'];
    companyName = json['CompanyName'];
    cMAddress = json['CM_Address'];
    taxPayableONRev = json['TaxPayableONRev'];
    invoiceNo = json['InvoiceNo'];
    invoiceDate = json['InvoiceDate'];
    invDescription = json['InvDescription'];
    baseFare = json['BaseFare'];
    discount = json['Discount'];
    taxableValue = json['TaxableValue'];
    cGST = json['CGST'];
    sGST = json['SGST'];
    iGST = json['IGST'];
    iGSTLbl = json['IGSTLbl'];
    sGSTLbl = json['SGSTLbl'];
    cGSTLbl = json['CGSTLbl'];
    totalInvAmt = json['TotalInvAmt'];
    amountInWords = json['AmountInWords'];
    jMEmailID = json['JM_EmailID'];
    jMPassengerName = json['JM_PassengerName'];
    jMPassengerAddress = json['JM_PassengerAddress'];
    custState = json['CustState'];
    custStateCode = json['CustStateCode'];
    custGSTRegNo = json['CustGSTRegNo'];
    journeyFromState = json['JourneyFromState'];
    fromCity = json['FromCity'];
    toCity = json['ToCity'];
    cOACH = json['COACH'];
    pickupName = json['PickupName'];
    paxDetails = json['PaxDetails'];
    jMGSTCompanyName = json['JM_GSTCompanyName'];
    pickupNameShort = json['PickupName_Short'];
    refundIGST = json['RefundIGST'];
    refundAmount = json['RefundAmount'];
    cancellationAmount = json['CancellationAmount'];
    pANCard = json['PANCard'];
    jMRefundCharges = json['JM_RefundCharges'];
    jMRefundServiceTax = json['JM_RefundServiceTax'];
    jMServiceTax = json['JM_ServiceTax'];
    companyStateCode = json['CompanyStateCode'];
    seatNo = json['SeatNo'];
    pMPickupID = json['PM_PickupID'];
    dMDropID = json['DM_DropID'];
    pickuptime = json['Pickuptime'];
    pickupDate = json['PickupDate'];
    serverFilePath = json['ServerFilePath'];
    sDiffgrId = json['_diffgr:id'];
    sMsdataRowOrder = json['_msdata:rowOrder'];
    PickupLatitude = json['PickupLatitude'];
    PickupLongitude = json['PickupLongitude'];
    DropLatitude = json['DropLatitude'];
    DropLongitude = json['DropLongitude'];
    Droptime = json['Droptime'];
    DropDate = json['DropDate'];
    DropName = json['DropName'];
    DropName_Short = json['DropName_Short'];
    DriverPhone = json['DriverPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PNR'] = this.pNR;
    data['JM_BookingDateTime'] = this.jMBookingDateTime;
    data['JM_JourneyStartDate'] = this.jMJourneyStartDate;
    data['CM_CompanyLogo'] = this.cMCompanyLogo;
    data['CM_Email'] = this.cMEmail;
    data['CM_Website'] = this.cMWebsite;
    data['CompanyName'] = this.companyName;
    data['CM_Address'] = this.cMAddress;
    data['TaxPayableONRev'] = this.taxPayableONRev;
    data['InvoiceNo'] = this.invoiceNo;
    data['InvoiceDate'] = this.invoiceDate;
    data['InvDescription'] = this.invDescription;
    data['BaseFare'] = this.baseFare;
    data['Discount'] = this.discount;
    data['TaxableValue'] = this.taxableValue;
    data['CGST'] = this.cGST;
    data['SGST'] = this.sGST;
    data['IGST'] = this.iGST;
    data['IGSTLbl'] = this.iGSTLbl;
    data['SGSTLbl'] = this.sGSTLbl;
    data['CGSTLbl'] = this.cGSTLbl;
    data['TotalInvAmt'] = this.totalInvAmt;
    data['AmountInWords'] = this.amountInWords;
    data['JM_EmailID'] = this.jMEmailID;
    data['JM_PassengerName'] = this.jMPassengerName;
    data['JM_PassengerAddress'] = this.jMPassengerAddress;
    data['CustState'] = this.custState;
    data['CustStateCode'] = this.custStateCode;
    data['CustGSTRegNo'] = this.custGSTRegNo;
    data['JourneyFromState'] = this.journeyFromState;
    data['FromCity'] = this.fromCity;
    data['ToCity'] = this.toCity;
    data['COACH'] = this.cOACH;
    data['PickupName'] = this.pickupName;
    data['PaxDetails'] = this.paxDetails;
    data['JM_GSTCompanyName'] = this.jMGSTCompanyName;
    data['PickupName_Short'] = this.pickupNameShort;
    data['RefundIGST'] = this.refundIGST;
    data['RefundAmount'] = this.refundAmount;
    data['CancellationAmount'] = this.cancellationAmount;
    data['PANCard'] = this.pANCard;
    data['JM_RefundCharges'] = this.jMRefundCharges;
    data['JM_RefundServiceTax'] = this.jMRefundServiceTax;
    data['JM_ServiceTax'] = this.jMServiceTax;
    data['CompanyStateCode'] = this.companyStateCode;
    data['SeatNo'] = this.seatNo;
    data['PM_PickupID'] = this.pMPickupID;
    data['DM_DropID'] = this.dMDropID;
    data['Pickuptime'] = this.pickuptime;
    data['PickupDate'] = this.pickupDate;
    data['ServerFilePath'] = this.serverFilePath;
    data['_diffgr:id'] = this.sDiffgrId;
    data['_msdata:rowOrder'] = this.sMsdataRowOrder;
    data['PickupLatitude'] = this.PickupLatitude;
    data['PickupLongitude'] = this.PickupLongitude;
    data['DropLatitude'] = this.DropLatitude;
    data['DropLongitude'] = this.DropLongitude;
    data['Droptime'] = this.Droptime;
    data['DropDate'] = this.DropDate;
    data['DropName'] = this.DropName;
    data['DropName_Short'] = this.DropName_Short;
    data['DriverPhone'] = this.DriverPhone;
    return data;
  }
}
