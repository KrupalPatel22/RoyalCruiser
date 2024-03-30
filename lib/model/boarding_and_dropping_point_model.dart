
//Old Code
// class BoardingDroppingPointDetails {
//   late String PickUpID;
//   late String PickUpName;
//   late String PickUpTime;
//   late String PickupPhone;
//
//
//   BoardingDroppingPointDetails({
//     required this.PickUpID,
//     required this.PickUpName,
//     required this.PickUpTime,
//     required this.PickupPhone,
//
//   });
//
//   BoardingDroppingPointDetails.fromJson(Map<String, dynamic> json) {
//     PickUpID = json['PickUpID'];
//     PickUpName = json['PickUpName'];
//     PickUpTime = json['PickUpTime'];
//     PickupPhone = json['PickupPhone'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = Map<String, dynamic>();
//     data['PickUpID'] = this.PickUpID;
//     data['PickUpName'] = this.PickUpName;
//     data['PickUpTime'] = this.PickUpTime;
//     data['PickupPhone'] = this.PickupPhone;
//     return data;
//   }
// }

//New Code

class BoardingDroppingPointDetails {
  String? diffgrId;
  String? msdataRowOrder;
  String? PickUpID;
  String? PickUpName;
  String? PickUpTime;
  String? pickUpAddress;
  String? PickupPhone;
  String? pSIDepartTime;
  String? pickupDrop;
  String? latitude;
  String? longitude;
  String? onlyPickupName;

  BoardingDroppingPointDetails(
      {this.diffgrId,
        this.msdataRowOrder,
        this.PickUpID,
        this.PickUpName,
        this.PickUpTime,
        this.pickUpAddress,
        this.PickupPhone,
        this.pSIDepartTime,
        this.pickupDrop,
        this.latitude,
        this.longitude,
        this.onlyPickupName});

  BoardingDroppingPointDetails.fromJson(Map<String, dynamic> json) {
    diffgrId = json['-diffgr:id'];
    msdataRowOrder = json['-msdata:rowOrder'];
    PickUpID = json['PickUpID'];
    PickUpName = json['PickUpName'];
    PickUpTime = json['PickUpTime'];
    pickUpAddress = json['PickUpAddress'];
    PickupPhone = json['PickupPhone'];
    pSIDepartTime = json['PSI_departTime'];
    pickupDrop = json['PickupDrop'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    onlyPickupName = json['OnlyPickupName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['-diffgr:id'] = this.diffgrId;
    data['-msdata:rowOrder'] = this.msdataRowOrder;
    data['PickUpID'] = this.PickUpID;
    data['PickUpName'] = this.PickUpName;
    data['PickUpTime'] = this.PickUpTime;
    data['PickUpAddress'] = this.pickUpAddress;
    data['PickupPhone'] = this.PickupPhone;
    data['PSI_departTime'] = this.pSIDepartTime;
    data['PickupDrop'] = this.pickupDrop;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['OnlyPickupName'] = this.onlyPickupName;
    return data;
  }
}

