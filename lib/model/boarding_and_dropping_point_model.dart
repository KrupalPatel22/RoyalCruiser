class BoardingDroppingPointDetails {
  late String PickUpID;
  late String PickUpName;
  late String PickUpTime;
  late String PickupPhone;


  BoardingDroppingPointDetails({
    required this.PickUpID,
    required this.PickUpName,
    required this.PickUpTime,
    required this.PickupPhone,

  });

  BoardingDroppingPointDetails.fromJson(Map<String, dynamic> json) {
    PickUpID = json['PickUpID'];
    PickUpName = json['PickUpName'];
    PickUpTime = json['PickUpTime'];
    PickupPhone = json['PickupPhone'];

  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['PickUpID'] = this.PickUpID;
    data['PickUpName'] = this.PickUpName;
    data['PickUpTime'] = this.PickUpTime;
    data['PickupPhone'] = this.PickupPhone;
    return data;
  }
}
