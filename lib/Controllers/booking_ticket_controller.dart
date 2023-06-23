import 'package:get/get.dart';

class BookingTicketController extends GetxController{

  var selectedDate = DateTime.now().obs;
  var dateList = <DateTime>[].obs;

  changeSelectedDate(DateTime dt){
    selectedDate(dt);
  }

  get30DaysDate(){
    dateList.clear();
    for(int i =1;i<=30;i++){
      if(i==1){
        dateList.add(DateTime.now());
      }else{
        dateList.add(DateTime.now().add(Duration(days: i-1)));
      }
    }
  }
}