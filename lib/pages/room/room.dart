import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacod/pages/room/create/create_room.dart';
import 'package:vacod/pages/room/edit/edit_room.dart';
import 'package:vacod/providers/index.dart';
import 'package:vacod/utils/debouncer.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/widgets/index.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({Key? key}) : super(key: key);
  static const String route = '/room';

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  final _debouncer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<RoomProvider>().getRooms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý phòng'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(CreateRoomPage.route);
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
                onChanged: (value) {
                  _debouncer.run(() {
                    if (value.isNotEmpty && value.length > 0)
                      context.read<RoomProvider>().filterRoom(value);
                    else
                      context.read<RoomProvider>().getRooms();
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: Consumer<RoomProvider>(
                  builder: (context, data, _) {
                    if (data.isLoading!) {
                      return LoadingView();
                    } else if (data.isNotFound!) {
                      return Center(
                        child: Text('Không có kết quả nào được tìm thấy'),
                      );
                    } else {
                      if (data.roomCount == 0) {
                        return const Center(
                          child: Text('Không có dữ liệu! Vui lòng tạo mới'),
                        );
                      }
                      return _buildListRooms(data);
                    }

                    // return Container();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    context.read<RoomProvider>().getRooms();
  }

  GridView _buildListRooms(RoomProvider data) {
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
            onTap: () async {
              await context
                  .read<RoomProvider>()
                  .getDetailRoom(data.getRoom(i).roomID);
              Navigator.of(context).pushNamed(EditRoomPage.route, arguments: {
                'roomID': data.getRoom(i).roomID,
              });
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
                    child: Text('Phòng ${data.getRoom(i).name}',
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
      itemCount: data.roomCount,
    );
  }
}
