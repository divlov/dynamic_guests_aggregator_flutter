import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:room_selection_flutter/controllers/guests_controller.dart';
import 'package:room_selection_flutter/screens/room_selection_screen.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.off(const RoomSelectionScreen());
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Summary'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GetBuilder<GuestController>(
                builder: (GuestController controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.adultsNames.keys.length,
                      itemBuilder: (ctx, index) {
                        final roomNumber =
                            controller.adultsNames.keys.elementAt(index);
                        if (controller.adultsNames[roomNumber]!.isEmpty &&
                            controller.childrenNames[roomNumber]!.isEmpty) {
                          return null;
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Room Number: $roomNumber'),
                            const Text('Adults:'),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    controller.adultsNames[roomNumber]!.length,
                                itemBuilder: (ctx, index) {
                                  return Text(
                                      'Name: ${controller.adultsNames[roomNumber]![index]}, Age: ${controller.adultsAges[roomNumber]![index]}');
                                }),
                            const Text('Children:'),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller
                                    .childrenNames[roomNumber]!.length,
                                itemBuilder: (ctx, index) {
                                  return Text(
                                      'Name: ${controller.childrenNames[roomNumber]![index]}, Age: ${controller.childrenAges[roomNumber]![index]}');
                                }),
                          ],
                        );
                      })
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
