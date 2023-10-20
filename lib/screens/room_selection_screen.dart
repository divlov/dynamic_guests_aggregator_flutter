import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_selection_flutter/controllers/guests_controller.dart';
import 'package:room_selection_flutter/screens/summary_screen.dart';

class RoomSelectionScreen extends StatefulWidget {
  const RoomSelectionScreen({super.key});

  @override
  RoomSelectionScreenState createState() => RoomSelectionScreenState();
}

class RoomSelectionScreenState extends State<RoomSelectionScreen> {
  int selectedRoom = 1;
  int adultCount = 0;
  int childCount = 0;
  List<String> adultNames = [];
  List<String> childNames = [];
  List<int> adultAges = [];
  List<int> childAges = [];
  bool isNumberOfGuestsEntered = false;
  final numberOfAdultsController = TextEditingController();
  final numberOfChildrenController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(GuestController());
  }

  void resetFlags() {
    isNumberOfGuestsEntered = false;
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      if (!isNumberOfGuestsEntered) {
        setState(() {
          adultCount = int.parse(numberOfAdultsController.text);
          childCount = int.parse(numberOfChildrenController.text);
          isNumberOfGuestsEntered = true;
        });
        return;
      }
      Get.find<GuestController>()
        ..addAdultGuestsList(adultNames, adultAges, selectedRoom)
        ..addChildGuestsList(childNames, childAges, selectedRoom);

      // Navigate to the summary page
      formKey.currentState!.reset();
      resetFlags();
      Get.off(() => const SummaryScreen());
    }
    else{
      adultNames.clear();
      childNames.clear();
      adultAges.clear();
      childAges.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Selection'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                DropdownButton<int>(
                  value: selectedRoom,
                  items: [1, 2, 3, 4, 5].map((roomNumber) {
                    return DropdownMenuItem<int>(
                      value: roomNumber,
                      child: Text('Room $roomNumber'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRoom = value!;
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: numberOfAdultsController,
                  decoration:
                      const InputDecoration(labelText: 'Number of Adults'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the number of adults';
                    }
                    int? adults = int.tryParse(value);
                    if (adults == null || adults < 0) {
                      return 'Invalid number of adults';
                    }
                    adultCount = adults;
                    return null;
                  },
                ),
                TextFormField(
                  controller: numberOfChildrenController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Number of Children'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the number of children';
                    }
                    int? children = int.tryParse(value);
                    if (children == null || children < 0) {
                      return 'Invalid number of children';
                    }
                    childCount = children;
                    return null;
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: adultCount,
                    itemBuilder: (ctx,i){
                  return Column(
                    children: [
                      TextFormField(
                        decoration:
                        InputDecoration(labelText: 'Adult Name ${i + 1}'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the adult\'s name';
                          }
                          adultNames.add(value);
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration:
                        InputDecoration(labelText: 'Adult Age ${i + 1}'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the adult\'s age';
                          }
                          int? age = int.tryParse(value);
                          if (age == null || age <= 18) {
                            return 'Age should be above 18';
                          }
                          adultAges.add(age);
                          return null;
                        },
                      ),
                    ],
                  );
                }),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: childCount,
                    itemBuilder: (ctx, i) {
                  return Column(
                    children: [
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Child Name ${i + 1}'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the child\'s name';
                          }
                          childNames.add(value);
                          return null;
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(labelText: 'Child Age ${i + 1}'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the child\'s age';
                          }
                          int? age = int.tryParse(value);
                          if (age == null || age >= 18) {
                            return 'Age should be below 18';
                          }
                          childAges.add(age);
                          return null;
                        },
                      ),
                    ],
                  );
                }),
                ElevatedButton(
                  onPressed: submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
