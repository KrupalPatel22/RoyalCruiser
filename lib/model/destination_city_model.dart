class ITSDestinations {
  late String CM_CityID;
  late String CM_CityName;

  ITSDestinations({
    required this.CM_CityID,
    required this.CM_CityName,
  });

  ITSDestinations.from(Map<String, dynamic> json) {
    CM_CityID = json['CM_CityID'];
    CM_CityName = json['CM_CityName'];
  }

  Map<String, dynamic> toJson() {
   final Map<String, dynamic> data = Map<String, dynamic>();
    data['CM_CityID'] = CM_CityID;
    data['CM_CityName'] = CM_CityName;
    return data;
  }
}
