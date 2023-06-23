// import 'package:pttbus/model/seat_arrangement_stax_model.dart';
//
// class PassengerDetailsModel {
//   late String gender;
//   ITSSeatDetails? itsSeatDetails;
//
//   PassengerDetailsModel({
//     required this.itsSeatDetails,
//     required this.gender,
//   });
//
//   PassengerDetailsModel.fromJson(Map<String, dynamic> json) {
//     gender = json['gender'];
//     itsSeatDetails = json['itsSeatDetails'] != null
//         ? new ITSSeatDetails.fromJson(json['itsSeatDetails'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['gender'] = gender;
//     if (this.itsSeatDetails != null) {
//       data['itsSeatDetails'] = this.itsSeatDetails!.toJson();
//     }
//     return data;
//   }
// }

class PassangersModel {
  late String passengerName;
  late String seatNo;
  late String passengerAge;
  late String passengerGender;
  late int seatBasefare;
  late double seatGst;

  PassangersModel(
      {this.passengerName = '',
        this.seatNo = '',
        this.passengerAge = '',
        this.passengerGender = '',
        this.seatBasefare = 0,
        this.seatGst = 0.0});

}
