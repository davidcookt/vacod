import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/pages/house/create/create_house.dart';
import 'package:vacod/pages/house/edit/edit_house.dart';
import 'package:vacod/providers/house.dart';
import 'package:vacod/utils/colors.dart';
import 'package:vacod/utils/debouncer.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/widgets/index.dart';

class HousePage extends StatefulWidget {
  const HousePage({Key? key}) : super(key: key);
  static const String route = '/house';

  @override
  _HousePageState createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {
  var _filterController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<HouseProvider>().getHouses();
    });
  }

  Future<void> _onRefresh() async {
    context.read<HouseProvider>().getHouses();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quản lý nhà'),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(CreateHousePage.route);
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
                  controller: _filterController,
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    _debouncer.run(() {
                      if (value.isNotEmpty && value.length > 0)
                        context.read<HouseProvider>().filterHouse(value);
                      else
                        context.read<HouseProvider>().getHouses();
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: Consumer<HouseProvider>(
                    builder: (context, data, _) {
                      if (data.isLoading!) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (data.isNotFound!) {
                        return Center(
                          child: Text('Không có kết quả nào được tìm thấy'),
                        );
                      } else {
                        return _buildGridViewHouses(data);
                      }

                      // return Container();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  GridView _buildGridViewHouses(HouseProvider data) {
    return GridView.builder(
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
            onTap: () {
              Navigator.of(context).pushNamed(EditHousePage.route,
                  arguments: {'houseId': data.getHouse(i).houseID});
            },
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
                    child: Text(data.getHouse(i).name,
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
      itemCount: data.houseCount,
    );
  }
}
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