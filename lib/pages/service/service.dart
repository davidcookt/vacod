import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:vacod/pages/service/edit/edit_service.dart';
import 'package:vacod/pages/service/widgets/group_list_header.dart';
import 'package:vacod/providers/service.dart';
import 'package:vacod/utils/debouncer.dart';
import 'package:vacod/utils/index.dart';
import 'package:vacod/widgets/index.dart';

import 'create/create_service.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);
  static const route = '/service';

  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final _debouncer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<ServiceProvider>().getServices();
    });
  }

  Future<void> _onRefresh() async {
    context.read<ServiceProvider>().getServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý dịch vụ'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(CreateServicePage.route);
            },
            borderRadius: BorderRadius.circular(30),
            child: const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: AppDimension.sizePadding25,
          left: AppDimension.sizePadding20,
          right: AppDimension.sizePadding20,
        ),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: 44,
              width: 256,
              child: TextFormField(
                // controller: _filterController,
                decoration: const InputDecoration(
                  hintText: 'Tìm kiếm',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  _debouncer.run(() {
                    if (value.isNotEmpty && value.length > 0)
                      context.read<ServiceProvider>().filterService(value);
                    else
                      context.read<ServiceProvider>().getServices();
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: Consumer<ServiceProvider>(
                  builder: (context, data, _) {
                    if (data.isLoading!) {
                      return LoadingView();
                    } else if (data.isFailed!) {
                      return const Center(
                        child: Text('Lỗi'),
                      );
                    } else if (data.isNotFound!) {
                      return const Center(
                        child: Text('Không tìm thấy dịch vụ này'),
                      );
                    } else {
                      if (data.serviceCount == 0) {
                        return const Center(
                          child: Text(
                              'Không có dữ liệu dịch vụ! Vui lòng tạo mới'),
                        );
                      }
                      return GroupedListView<dynamic, String>(
                        elements: data.services,
                        groupBy: (element) => element.houseID,
                        useStickyGroupSeparators: true,
                        groupSeparatorBuilder: (String value) =>
                            GroupListHeader(
                          houseID: value,
                          key: ValueKey(value),
                        ),
                        itemBuilder: (context, element) {
                          return GestureDetector(
                            onTap: () async {
                              await context
                                  .read<ServiceProvider>()
                                  .getDetailService(element.serviceID);
                              Navigator.of(context).pushNamed(
                                  EditServicePage.route,
                                  arguments: {'serviceID': element.serviceID});
                            },
                            child: ListTile(
                              leading: Container(
                                height: 40,
                                width: 40,
                                color: Colors.purple,
                              ),
                              title: Text('Dịch vụ ${element.serviceName}'),
                              subtitle: Text(
                                  'Đơn giá: ${AppConstant.formatMoney(element.unitPrice)}'),
                            ),
                          );
                        },
                      );
                      // return ListView.builder(
                      //   itemBuilder: (context, i) {
                      //     return GestureDetector(
                      //       onTap: () async {
                      //         await context
                      //             .read<ServiceProvider>()
                      //             .getDetailService(
                      //                 data.getService(i).serviceID);
                      //         Navigator.of(context)
                      //             .pushNamed(EditServicePage.route, arguments: {
                      //           'serviceID': data.getService(i).serviceID
                      //         });
                      //       },
                      //       child: ListTile(
                      //         leading: Container(
                      //           height: 40,
                      //           width: 40,
                      //           color: Colors.purple,
                      //         ),
                      //         title: Text(
                      //             'Dịch vụ ${data.getService(i).serviceName}'),
                      //         subtitle: Text(
                      //             'Đơn giá: ${AppConstant.formatMoney(data.getService(i).unitPrice)}'),
                      //       ),
                      //     );
                      //   },
                      //   itemCount: data.serviceCount,
                      // );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
