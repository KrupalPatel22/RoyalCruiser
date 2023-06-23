class ITSSeatDetails {
  late String SeatNo;
  late String IsLadiesSeat;
  late String Available;
  late String SeatType;
  late String Row;
  late String Column;
  late String UpLowBerth;
  late String BlockType;
  late String RowSpan;
  late String ColumnSpan;
  late String SeatCategory;
  late String SeatRate;
  late String IsLowPrice;
  late String BaseFare;
  late String ServiceTax;
  late String Surcharges;
  late String OnlineCharge;

  late String BaseFareServicTax;
  late String IsHomePickup;
  late String IsHomeDrop;
  late String DiscountAmount;
  late String OriginalSeatRate;
  late String InsuranceCharges;
  late String SocialDistanceTransactionType;
  late String SocialDistancePercentage;
  late String IsSocialDistanceBlockSeat;
  late String CDH_DiscountIfDoubleSeatBooked;
  late String CouponCodeDetails;


  ITSSeatDetails({
    required this.SeatNo,
    required this.IsLadiesSeat,
    required this.Available,
    required this.SeatType,
    required this.Row,
    required this.Column,
    required this.UpLowBerth,
    required this.BlockType,
    required this.RowSpan,
    required this.ColumnSpan,
    required this.SeatCategory,
    required this.SeatRate,
    required this.IsLowPrice,
    required this.BaseFare,
    required this.ServiceTax,
    required this.Surcharges,
    required this.OnlineCharge,
    required this.BaseFareServicTax,
    required this.IsHomePickup,
    required this.IsHomeDrop,
    required this.DiscountAmount,
    required this.OriginalSeatRate,
    required this.InsuranceCharges,
    required this.SocialDistanceTransactionType,
    required this.SocialDistancePercentage,
    required this.IsSocialDistanceBlockSeat,
    required this.CDH_DiscountIfDoubleSeatBooked,
    required this.CouponCodeDetails,

  });

  ITSSeatDetails.fromJson(Map<String, dynamic> json) {
    SeatNo = json['SeatNo'];
    IsLadiesSeat = json['IsLadiesSeat'];
    Available = json['Available'];
    SeatType = json['SeatType'];
    Row = json['Row'];
    Column = json['Column'];
    UpLowBerth = json['UpLowBerth'];
    BlockType = json['BlockType'];
    RowSpan = json['RowSpan'];
    ColumnSpan = json['ColumnSpan'];
    SeatCategory = json['SeatCategory'];
    SeatRate = json['SeatRate'];
    IsLowPrice = json['IsLowPrice'];
    BaseFare = json['BaseFare'];
    ServiceTax = json['ServiceTax'];
    Surcharges = json['Surcharges'];
    OnlineCharge = json['OnlineCharge'];
    BaseFareServicTax = json['BaseFareServicTax'];
    IsHomePickup= json['IsHomePickup'];
    IsHomeDrop= json['IsHomeDrop'];
    DiscountAmount= json['DiscountAmount'];
    OriginalSeatRate= json['OriginalSeatRate'];
    InsuranceCharges= json['InsuranceCharges'];
    SocialDistanceTransactionType= json['SocialDistanceTransactionType'];
    SocialDistancePercentage= json['SocialDistancePercentage'];
    IsSocialDistanceBlockSeat= json['IsSocialDistanceBlockSeat'];
    CDH_DiscountIfDoubleSeatBooked= json['CDH_DiscountIfDoubleSeatBooked'];
    CouponCodeDetails= json['CouponCodeDetails'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['SeatNo'] = this.SeatNo;
    data['IsLadiesSeat'] = this.IsLadiesSeat;
    data['Available'] = this.Available;
    data['SeatType'] = this.SeatType;
    data['Row'] = this.Row;
    data['Column'] = this.Column;
    data['UpLowBerth'] = this.UpLowBerth;
    data['BlockType'] = this.BlockType;
    data['RowSpan'] = this.RowSpan;
    data['ColumnSpan'] = this.ColumnSpan;
    data['SeatCategory'] = this.SeatCategory;
    data['SeatRate'] = this.SeatRate;
    data['IsLowPrice'] = this.IsLowPrice;
    data['BaseFare'] = this.BaseFare;
    data['ServiceTax'] = this.ServiceTax;
    data['Surcharges'] = this.Surcharges;
    data['OnlineCharge'] = this.OnlineCharge;


    data['BaseFareServicTax'] = this.BaseFareServicTax;
    data['IsHomePickup'] = this.IsHomePickup;
    data['IsHomeDrop'] = this.IsHomeDrop;
    data['DiscountAmount'] = this.DiscountAmount;
    data['OriginalSeatRate'] = this.OriginalSeatRate;
    data['InsuranceCharges'] = this.InsuranceCharges;
    data['SocialDistanceTransactionType'] = this.SocialDistanceTransactionType;
    data['SocialDistancePercentage'] = this.SocialDistancePercentage;
    data['IsSocialDistanceBlockSeat'] = this.IsSocialDistanceBlockSeat;
    data['CDH_DiscountIfDoubleSeatBooked'] = this.CDH_DiscountIfDoubleSeatBooked;
    data['CouponCodeDetails'] = this.CouponCodeDetails;

    return data;
  }
}
