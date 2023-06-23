class AllRouteBusLists {
  late String CompanyID;
  late String CompanyName;
  late String FromCityId;
  late String FromCityName;
  late String ToCityId;
  late String ToCityName;
  late String RouteID;
  late String RouteTimeID;
  late String RouteName;
  late String RouteTime;
  late String Kilometer;
  late String CityTime;
  late String ArrivalTime;
  late String BusType;
  late String BusTypeName;
  late String BookingDate;
  late String ArrangementID;
  late String ArrangementName;
  late String AcSeatRate;
  late String AcSleeperRate;
  late String AcSlumberRate;
  late String NonAcSeatRate;
  late String NonAcSleeperRate;
  late String NonAcSlumberRate;
  late String BoardingPoints;
  late String DroppingPoints;
  late String EmptySeats;
  late String ReferenceNumber;
  late String IsSameDay;
  late String RouteAmenities;
  late String IsPackage;
  late String PackageAmenities;
  late String AcSeatServiceTax;
  late String AcSlpServiceTax;
  late String AcSlmbServiceTax;
  late String NonAcSeatServiceTax;
  late String NonAcSlpServiceTax;
  late String NonAcSlmbServiceTax;
  late String BaseAcSeat;
  late String BaseAcSlp;
  late String BaseAcSlmb;
  late String BaseNonAcSeat;
  late String BaseNonAcSlp;
  late String BaseNonAcSlmb;
  late String AcSeatSurcharges;
  late String AcSlpSurcharges;
  late String AcSlmbSurcharges;
  late String NonAcSeatSurcharges;
  late String NonAcSlpSurcharges;
  late String NonAcSlmbSurcharges;
  late String BusSeatType;
  late String IsChargeAmenities;
  late String ServiceTax;
  late String ServiceTaxRoundUp;
  late String IsIncludeTax;
  late String OnlineACSeatCharge;
  late String OnlineACSlumberCharge;
  late String OnlineACSleeperCharge;
  late String OnlineNonACSeatCharge;
  late String OnlineNonACSlumberCharge;
  late String OnlineNonACSleeperCharge;
  late String Duration;
  late String CM_CGST;
  late String CM_SGST;
  late String CompanyStateID;
  late String FromCityState;
  late String StrikeOutACSeatFare;
  late String StrikeOutACSleeperFare;
  late String StrikeOutACSlumberFare;
  late String StrikeOutNonACSeatFare;
  late String StrikeOutNonACSleeperFare;
  late String StrikeOutNonACSlumberFare;
  late String RouteType;
  late String ID;
  late String TripNo;
  late String HoldTime;
  late String REV_ExtraValue;
  late String REV_ValueType;
  late String CityTime24;
  late String ArrivalTime24;
  late String RouteScheduleCode;
  late String DurationMinutes;
  late String RT_IsNonStopSchedule;
  late String RTPD_CityList;
  late String DiscountRate;
  late String ApproxArrival;
  late String AreaIDName;
  late String PickupIDNameTimeDetails;
  late String TotalRating;
  late String RatingAVG;

  AllRouteBusLists({
    required this.CompanyID,
    required this.CompanyName,
    required this.FromCityId,
    required this.FromCityName,
    required this.ToCityId,
    required this.ToCityName,
    required this.RouteID,
    required this.RouteTimeID,
    required this.RouteName,
    required this.RouteTime,
    required this.Kilometer,
    required this.CityTime,
    required this.ArrivalTime,
    required this.BusType,
    required this.BusTypeName,
    required this.BookingDate,
    required this.ArrangementID,
    required this.ArrangementName,
    required this.AcSeatRate,
    required this.AcSleeperRate,
    required this.AcSlumberRate,
    required this.NonAcSeatRate,
    required this.NonAcSleeperRate,
    required this.NonAcSlumberRate,
    required this.BoardingPoints,
    required this.DroppingPoints,
    required this.EmptySeats,
    required this.ReferenceNumber,
    required this.IsSameDay,
    required this.RouteAmenities,
    required this.IsPackage,
    required this.PackageAmenities,
    required this.AcSeatServiceTax,
    required this.AcSlpServiceTax,
    required this.AcSlmbServiceTax,
    required this.NonAcSeatServiceTax,
    required this.NonAcSlpServiceTax,
    required this.NonAcSlmbServiceTax,
    required this.BaseAcSeat,
    required this.BaseAcSlp,
    required this.BaseAcSlmb,
    required this.BaseNonAcSeat,
    required this.BaseNonAcSlp,
    required this.BaseNonAcSlmb,
    required this.AcSeatSurcharges,
    required this.AcSlpSurcharges,
    required this.AcSlmbSurcharges,
    required this.NonAcSeatSurcharges,
    required this.NonAcSlpSurcharges,
    required this.NonAcSlmbSurcharges,
    required this.BusSeatType,
    required this.IsChargeAmenities,
    required this.ServiceTax,
    required this.ServiceTaxRoundUp,
    required this.IsIncludeTax,
    required this.OnlineACSeatCharge,
    required this.OnlineACSlumberCharge,
    required this.OnlineACSleeperCharge,
    required this.OnlineNonACSeatCharge,
    required this.OnlineNonACSlumberCharge,
    required this.OnlineNonACSleeperCharge,
    required this.Duration,
    required this.CM_CGST,
    required this.CM_SGST,
    required this.CompanyStateID,
    required this.FromCityState,
    required this.StrikeOutACSeatFare,
    required this.StrikeOutACSleeperFare,
    required this.StrikeOutACSlumberFare,
    required this.StrikeOutNonACSeatFare,
    required this.StrikeOutNonACSleeperFare,
    required this.StrikeOutNonACSlumberFare,
    required this.RouteType,
    required this.ID,
    required this.TripNo,
    required this.HoldTime,
    required this.REV_ExtraValue,
    required this.REV_ValueType,
    required this.CityTime24,
    required this.ArrivalTime24,
    required this.RouteScheduleCode,
    required this.DurationMinutes,
    required this.RT_IsNonStopSchedule,
    required this.RTPD_CityList,
    required this.DiscountRate,
    required this.ApproxArrival,
    required this.AreaIDName,
    required this.PickupIDNameTimeDetails,
    required this.TotalRating,
    required this.RatingAVG,
  });

  AllRouteBusLists.fromJson(Map<String, dynamic> json) {
    CompanyID = json['CompanyID'];
    CompanyName = json['CompanyName'];
    FromCityId = json['FromCityId'];
    FromCityName = json['FromCityName'];
    ToCityId = json['ToCityId'];
    ToCityName = json['ToCityName'];
    RouteID = json['RouteID'];
    RouteTimeID = json['RouteTimeID'];
    RouteName = json['RouteName'];
    RouteTime = json['RouteTime'];
    Kilometer = json['Kilometer'];
    CityTime = json['CityTime'];
    ArrivalTime = json['ArrivalTime'];
    BusType = json['BusType'];
    BusTypeName = json['BusTypeName'];
    BookingDate = json['BookingDate'];
    ArrangementID = json['ArrangementID'];
    ArrangementName = json['ArrangementName'];
    AcSeatRate = json['AcSeatRate'];
    AcSleeperRate = json['AcSleeperRate'];
    AcSlumberRate = json['AcSlumberRate'];
    NonAcSeatRate = json['NonAcSeatRate'];
    NonAcSleeperRate = json['NonAcSleeperRate'];
    NonAcSlumberRate = json['NonAcSlumberRate'];
    BoardingPoints = json['BoardingPoints'];
    DroppingPoints = json['DroppingPoints'];
    EmptySeats = json['EmptySeats'];
    ReferenceNumber = json['ReferenceNumber'];
    IsSameDay = json['IsSameDay'];
    RouteAmenities = json['RouteAmenities'];
    IsPackage = json['IsPackage'];
    PackageAmenities = json['PackageAmenities'];
    AcSeatServiceTax = json['AcSeatServiceTax'];
    AcSlpServiceTax = json['AcSlpServiceTax'];
    AcSlmbServiceTax = json['AcSlmbServiceTax'];
    NonAcSeatServiceTax = json['NonAcSeatServiceTax'];
    NonAcSlpServiceTax = json['NonAcSlpServiceTax'];
    NonAcSlmbServiceTax = json['NonAcSlmbServiceTax'];
    BaseAcSeat = json['BaseAcSeat'];
    BaseAcSlp = json['BaseAcSlp'];
    BaseAcSlmb = json['BaseAcSlmb'];
    BaseNonAcSeat = json['BaseNonAcSeat'];
    BaseNonAcSlp = json['BaseNonAcSlp'];
    BaseNonAcSlmb = json['BaseNonAcSlmb'];
    AcSeatSurcharges = json['AcSeatSurcharges'];
    AcSlpSurcharges = json['AcSlpSurcharges'];
    AcSlmbSurcharges = json['AcSlmbSurcharges'];
    NonAcSeatSurcharges = json['NonAcSeatSurcharges'];
    NonAcSlpSurcharges = json['NonAcSlpSurcharges'];
    NonAcSlmbSurcharges = json['NonAcSlmbSurcharges'];
    BusSeatType = json['BusSeatType'];
    IsChargeAmenities = json['IsChargeAmenities'];
    ServiceTax = json['ServiceTax'];
    ServiceTaxRoundUp = json['ServiceTaxRoundUp'];
    IsIncludeTax = json['IsIncludeTax'];
    OnlineACSeatCharge = json['OnlineACSeatCharge'];
    OnlineACSlumberCharge = json['OnlineACSlumberCharge'];
    OnlineACSleeperCharge = json['OnlineACSleeperCharge'];
    OnlineNonACSeatCharge = json['OnlineNonACSeatCharge'];
    OnlineNonACSlumberCharge = json['OnlineNonACSlumberCharge'];
    OnlineNonACSleeperCharge = json['OnlineNonACSleeperCharge'];
    Duration = json['Duration'];
    CM_CGST = json['CM_CGST'];
    CM_SGST = json['CM_SGST'];
    CompanyStateID = json['CompanyStateID'];
    FromCityState = json['FromCityState'];
    StrikeOutACSeatFare = json['StrikeOutACSeatFare'];
    StrikeOutACSleeperFare = json['StrikeOutACSleeperFare'];
    StrikeOutACSlumberFare = json['StrikeOutACSlumberFare'];
    StrikeOutNonACSeatFare = json['StrikeOutNonACSeatFare'];
    StrikeOutNonACSleeperFare = json['StrikeOutNonACSleeperFare'];
    StrikeOutNonACSlumberFare = json['StrikeOutNonACSlumberFare'];
    RouteType = json['RouteType'];
    ID = json['ID'];
    TripNo = json['TripNo'];
    HoldTime = json['HoldTime'];
    REV_ExtraValue = json['REV_ExtraValue'];
    REV_ValueType = json['REV_ValueType'];
    CityTime24 = json['CityTime24'];
    ArrivalTime24 = json['ArrivalTime24'];
    RouteScheduleCode = json['RouteScheduleCode'];
    DurationMinutes = json['DurationMinutes'];
    RT_IsNonStopSchedule = json['RT_IsNonStopSchedule'];
    RTPD_CityList = json['RTPD_CityList'];

    DiscountRate = json['DiscountRate'];
    ApproxArrival = json['ApproxArrival'];
    AreaIDName = json['AreaIDName'];
    PickupIDNameTimeDetails = json['PickupIDNameTimeDetails'];
    TotalRating = json['TotalRating'];
    RatingAVG = json['RatingAVG'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['CompanyID'] = this.CompanyID;
    data['CompanyName'] = this.CompanyName;
    data['FromCityId'] = this.FromCityId;
    data['FromCityName'] = this.FromCityName;
    data['ToCityId'] = this.ToCityId;
    data['ToCityName'] = this.ToCityName;
    data['RouteID'] = this.RouteID;
    data['RouteTimeID'] = this.RouteTimeID;
    data['RouteName'] = this.RouteName;
    data['RouteTime'] = this.RouteTime;
    data['Kilometer'] = this.Kilometer;
    data['CityTime'] = this.CityTime;
    data['ArrivalTime'] = this.ArrivalTime;
    data['BusType'] = this.BusType;
    data['BusTypeName'] = this.BusTypeName;
    data['BookingDate'] = this.BookingDate;
    data['ArrangementID'] = this.ArrangementID;
    data['ArrangementName'] = this.ArrangementName;
    data['AcSeatRate'] = this.AcSeatRate;
    data['AcSleeperRate'] = this.AcSleeperRate;
    data['AcSlumberRate'] = this.AcSlumberRate;
    data['NonAcSeatRate'] = this.NonAcSeatRate;
    data['NonAcSleeperRate'] = this.NonAcSleeperRate;
    data['NonAcSlumberRate'] = this.NonAcSlumberRate;
    data['BoardingPoints'] = this.BoardingPoints;
    data['DroppingPoints'] = this.DroppingPoints;
    data['EmptySeats'] = this.EmptySeats;
    data['ReferenceNumber'] = this.ReferenceNumber;
    data['IsSameDay'] = this.IsSameDay;
    data['RouteAmenities'] = this.RouteAmenities;
    data['IsPackage'] = this.IsPackage;
    data['PackageAmenities'] = this.PackageAmenities;
    data['AcSeatServiceTax'] = this.AcSeatServiceTax;
    data['AcSlpServiceTax'] = this.AcSlpServiceTax;
    data['AcSlmbServiceTax'] = this.AcSlmbServiceTax;
    data['NonAcSeatServiceTax'] = this.NonAcSeatServiceTax;
    data['NonAcSlpServiceTax'] = this.NonAcSlpServiceTax;
    data['NonAcSlmbServiceTax'] = this.NonAcSlmbServiceTax;
    data['BaseAcSeat'] = this.BaseAcSeat;
    data['BaseAcSlp'] = this.BaseAcSlp;
    data['BaseAcSlmb'] = this.BaseAcSlmb;
    data['BaseNonAcSeat'] = this.BaseNonAcSeat;
    data['BaseNonAcSlp'] = this.BaseNonAcSlp;
    data['BaseNonAcSlmb'] = this.BaseNonAcSlmb;
    data['AcSeatSurcharges'] = this.AcSeatSurcharges;
    data['AcSlpSurcharges'] = this.AcSlpSurcharges;
    data['AcSlmbSurcharges'] = this.AcSlmbSurcharges;
    data['NonAcSeatSurcharges'] = this.NonAcSeatSurcharges;
    data['NonAcSlpSurcharges'] = this.NonAcSlpSurcharges;
    data['NonAcSlmbSurcharges'] = this.NonAcSlmbSurcharges;
    data['BusSeatType'] = this.BusSeatType;
    data['IsChargeAmenities'] = this.IsChargeAmenities;
    data['ServiceTax'] = this.ServiceTax;
    data['ServiceTaxRoundUp'] = this.ServiceTaxRoundUp;
    data['IsIncludeTax'] = this.IsIncludeTax;
    data['OnlineACSeatCharge'] = this.OnlineACSeatCharge;
    data['OnlineACSlumberCharge'] = this.OnlineACSlumberCharge;
    data['OnlineACSleeperCharge'] = this.OnlineACSleeperCharge;
    data['OnlineNonACSeatCharge'] = this.OnlineNonACSeatCharge;
    data['OnlineNonACSlumberCharge'] = this.OnlineNonACSlumberCharge;
    data['OnlineNonACSleeperCharge'] = this.OnlineNonACSleeperCharge;
    data['Duration'] = this.Duration;
    data['CM_CGST'] = this.CM_CGST;
    data['CM_SGST'] = this.CM_SGST;
    data['CompanyStateID'] = this.CompanyStateID;
    data['FromCityState'] = this.FromCityState;
    data['StrikeOutACSeatFare'] = this.StrikeOutACSeatFare;
    data['StrikeOutACSleeperFare'] = this.StrikeOutACSleeperFare;
    data['StrikeOutACSlumberFare'] = this.StrikeOutACSlumberFare;
    data['StrikeOutNonACSeatFare'] = this.StrikeOutNonACSeatFare;
    data['StrikeOutNonACSleeperFare'] = this.StrikeOutNonACSleeperFare;
    data['StrikeOutNonACSlumberFare'] = this.StrikeOutNonACSlumberFare;
    data['RouteType'] = this.RouteType;
    data['ID'] = this.ID;
    data['TripNo'] = this.TripNo;
    data['HoldTime'] = this.HoldTime;
    data['REV_ExtraValue'] = this.REV_ExtraValue;
    data['REV_ValueType'] = this.REV_ValueType;
    data['CityTime24'] = this.CityTime24;
    data['ArrivalTime24'] = this.ArrivalTime24;
    data['RouteScheduleCode'] = this.RouteScheduleCode;
    data['DurationMinutes'] = this.DurationMinutes;
    data['RT_IsNonStopSchedule'] = this.RT_IsNonStopSchedule;
    data['RTPD_CityList'] = this.RTPD_CityList;
    data['DiscountRate'] = this.DiscountRate;
    data['ApproxArrival'] = this.ApproxArrival;
    data['AreaIDName'] = this.AreaIDName;
    data['PickupIDNameTimeDetails'] = this.PickupIDNameTimeDetails;
    data['TotalRating'] = this.TotalRating;
    data['RatingAVG'] = this.RatingAVG;
    return data;
  }
}
