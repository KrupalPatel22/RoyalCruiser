class ITSSources {
   String? CM_CityID;
   String? CM_CityName;


  ITSSources({
    required this.CM_CityID,
    required this.CM_CityName,

  });

  ITSSources.from(Map<String, dynamic> json) {
    CM_CityID = json['CM_CityID'];
    CM_CityName = json['CM_CityName'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CM_CityID'] = CM_CityID;
    data['CM_CityName'] = CM_CityName;

    return data;
  }
}
