import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/providers/index.dart';
import 'package:vacod/providers/renter.dart';
import 'package:vacod/utils/debouncer.dart';
import 'package:vacod/utils/index.dart';

import 'create/create_renter.dart';

class RenterPage extends StatefulWidget {
  const RenterPage({Key? key}) : super(key: key);
  static const String route = '/renter';
  @override
  _RenterPageState createState() => _RenterPageState();
}

class _RenterPageState extends State<RenterPage> {
  var _filterController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<RenterProvider>().getRenters();
    });
  }

  Future<void> _onRefresh() async {
    context.read<RenterProvider>().getRenters();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quản lý khách thuê'),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(CreateRenterPage.route);
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
                        context.read<RenterProvider>().getRenters();
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: Consumer<RenterProvider>(
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

  GridView _buildGridViewHouses(RenterProvider data) {
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
              // Navigator.of(context).pushNamed(EditHousePage.route,
              //     arguments: {'houseId': data.getHouse(i).houseID});
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
                    child: Text(data.getRenter(i).renterName!,
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
      itemCount: data.renterCount,
    );
  }
}
