import 'package:get/get.dart';

class GuestController extends GetxController{


  final Map<int,List<String>> _adultsNames={1:[],2:[],3:[],4:[],5:[]};
  final Map<int,List<String>>  _childrenNames={1:[],2:[],3:[],4:[],5:[]};
  final Map<int,List<int>> _adultsAges={1:[],2:[],3:[],4:[],5:[]};
  final Map<int,List<int>> _childrenAges={1:[],2:[],3:[],4:[],5:[]};

  void addAdultGuest(String name,int age, int roomNumber){
    if(_adultsAges[roomNumber]!=null) {
      _adultsAges[roomNumber]!.add(age);
      _adultsNames[roomNumber]!.add(name);
    }
    // else{
    //   _adultsAges[roomNumber]=[age];
    //   _adultsNames[roomNumber]=[name];
    // }
    update();
  }
  void addAdultGuestsList(List<String> names,List<int> ages, int roomNumber){
    if(_adultsAges[roomNumber]!=null) {
      _adultsAges[roomNumber]!.addAll(ages);
      _adultsNames[roomNumber]!.addAll(names);
    }
    // else{
    //   _adultsAges[roomNumber]=ages;
    //   _adultsNames[roomNumber]=names;
    // }
    update();
  }
  void addChildGuest(String name,int age, int roomNumber){
    if(_childrenAges[roomNumber]!=null) {
      _childrenAges[roomNumber]!.add(age);
      _childrenNames[roomNumber]!.add(name);
    }
    // else{
    //   _childrenAges[roomNumber]=[age];
    //   _childrenNames[roomNumber]=[name];
    // }
    update();
  }
  void addChildGuestsList(List<String> names,List<int> ages, int roomNumber){
    if(_childrenAges[roomNumber]!=null) {
      _childrenAges[roomNumber]!.addAll(ages);
      _childrenNames[roomNumber]!.addAll(names);
    }
    // else{
    //   _childrenAges[roomNumber]=ages;
    //   _childrenNames[roomNumber]=names;
    // }
    update();
  }

  Map<int, List<int>> get childrenAges => {..._childrenAges};

  Map<int, List<int>> get adultsAges => {..._adultsAges};

  Map<int, List<String>> get childrenNames => {..._childrenNames};

  Map<int, List<String>> get adultsNames => {..._adultsNames};
}