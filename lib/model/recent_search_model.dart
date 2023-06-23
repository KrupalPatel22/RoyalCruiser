class RecentSeaechModel {
  late String S_CityID;
  late String D_CityID;
  late String S_CityName;
  late String D_CityName;
  late String J_Date;


  RecentSeaechModel({
    required this.S_CityID,
    required this.D_CityID,
    required this.S_CityName,
    required this.D_CityName,
    required this.J_Date,

  });

  RecentSeaechModel.fromJson(Map<String, dynamic> json) {
    S_CityID = json['S_CityID'];
    D_CityID = json['D_CityID'];
    S_CityName = json['S_CityName'];
    D_CityName = json['D_CityName'];
    J_Date = json['J_Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['S_CityID'] = S_CityID;
    data['D_CityID'] = D_CityID;
    data['S_CityName'] = S_CityName;
    data['D_CityName'] = D_CityName;
    data['J_Date'] = J_Date;
    return data;
  }
}
