import 'package:flutter/material.dart';
import 'package:vacod/pages/room/create/create_room.dart';
import 'package:vacod/utils/index.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({Key? key}) : super(key: key);
  static const String route = '/room';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý phòng'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(CreateRoomPage.route);
              // showModalBottomSheet(
              //   context: context,
              //   isScrollControlled: true,
              //   backgroundColor: Colors.transparent,
              //   builder: (context) => Container(
              //     height: MediaQuery.of(context).size.height * 0.95,
              //     decoration: new BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: new BorderRadius.only(
              //         topLeft: const Radius.circular(25.0),
              //         topRight: const Radius.circular(25.0),
              //       ),
              //     ),
              //     child: Center(
              //       child: Text("Modal content goes here"),
              //     ),
              //   ),
              // );
              // showDialog(
              //     context: context,
              //     builder: (context) {
              //       return AlertDialog(
              //         backgroundColor: lightBackgroundColor,
              //         title: Center(child: Text('Tạo nhà')),
              //         content: Container(
              //           height: 150,
              //           width: 600,
              //           child: SingleChildScrollView(
              //             child: Form(
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   TextFormField(
              //                     decoration: InputDecoration(
              //                       hintText: 'Tên nhà',
              //                     ),
              //                   ),
              //                   SizedBox(height: 10),
              //                   TextFormField(
              //                     decoration: InputDecoration(
              //                       hintText: 'Loại nhà',
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //         actions: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               SizedBox(
              //                 width: 140,
              //                 child: DefaultButton(
              //                   widget: Text('Cancel'),
              //                   onPressed: () {},
              //                   buttonColor: Colors.grey,
              //                 ),
              //               ),
              //               SizedBox(
              //                 width: 140,
              //                 child: DefaultButton(
              //                   widget: Text('OK'),
              //                   onPressed: () {},
              //                   buttonColor: Colors.red,
              //                 ),
              //               ),
              //             ],
              //           )
              //         ],
              //       );
              //     });
            },
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 25,
          left: 25,
          right: 25,
        ),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 44,
              width: 256,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 4 / 3),
                itemBuilder: (context, i) {
                  return Material(
                    color: lightAccentColor,
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.ac_unit),
                            SizedBox(height: 10),
                            Center(
                              child: Text('Phòng số $i',
                                  style: TextStyles.bodyS14B.copyWith(
                                    color: lightPrimaryColor,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
