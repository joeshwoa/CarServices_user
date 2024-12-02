import 'package:autoflex/controllers/menu/orders_controller.dart';
import 'package:autoflex/controllers/menu/tabButton_controller.dart';
import 'package:autoflex/models/item_model.dart';
import 'package:autoflex/models/orders.dart' as Orders;
import 'package:autoflex/shared/components/cart_item.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/components/order_item.dart';
import 'package:autoflex/shared/components/serviceButton.dart';
import 'package:autoflex/styles/colors.dart';
import 'package:autoflex/styles/icons_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final TabButtonController tabController = Get.put(TabButtonController());
  final ordersController = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: ConstantColors.backgroundColor,
            title: Text(
              'MY ORDERS'.tr,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            leading: IconButton(
              icon: Get.locale?.languageCode == 'en'
                  ? SvgPicture.asset(arrowBack)
                  : Transform.rotate(
                      angle: 3.14,
                      child: SvgPicture.asset(arrowBack),
                    ),
              onPressed: () {
                tabController.changeTab(0);
                Get.back();
              },
            ),
          ),
          body: DefaultTabController(
            length: 2,
            child: Builder(builder: (context) {
              final tab = DefaultTabController.of(context);
              tab.addListener(() {
                if (tab.index != tab.previousIndex) {
                  tabController.changeTab(tab.index);
                }
              });
              return Column(
                children: [
                  Container(
                    child: Obx(
                      () => TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.center,
                        labelPadding: EdgeInsets.symmetric(horizontal: 4),
                        indicator: ShapeDecoration(
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        tabs: [
                          Tab(
                            child: OutlinedButton.icon(
                              onPressed: null,
                              icon: SvgPicture.asset(pending,
                                  color: tabController.tab.value.index == 0
                                      ? tabController.tab.value.activeColor
                                      : tabController.tab.value.color),
                              label: Text(
                                ' Upcoming Orders  '.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontSize: 11),
                              ),
                              style: OutlinedButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                    color: tabController.tab.value.index == 0
                                        ? tabController.tab.value.activeColor
                                        : ConstantColors.borderColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Tab(
                            child: OutlinedButton.icon(
                              onPressed: null,
                              icon: SvgPicture.asset(
                                done,
                                color: tabController.tab.value.index == 1
                                    ? tabController.tab.value.activeColor
                                    : tabController.tab.value.color,
                              ),
                              label: Text(
                                ' Completed Orders  '.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontSize: 11),
                              ),
                              style: OutlinedButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                    color: tabController.tab.value.index == 1
                                        ? tabController.tab.value.activeColor
                                        : ConstantColors.borderColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Obx(
                            () => ordersController.ordering.isEmpty
                                ? SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: Center(
                                      child: Text(
                                        'No Orders Requested'.tr,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color(0xFF717276),
                                          fontSize: 15,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                          letterSpacing: -0.15,
                                        ),
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      ...ordersController.ordering
                                          .map<Widget>((order) {
                                        List<Orders.AddOn> addOns =
                                            order.addOns!.cast<Orders.AddOn>();
                                        DateTime dateTime =
                                            DateTime.parse(order.date!);
                                        String formattedDate =
                                            DateFormat('MMM d')
                                                .format(dateTime);
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          child: Column(
                                            children: [
                                              OrderItem(
                                                tax: double.parse(
                                                        order.taxPercent!) /
                                                    100,
                                                notes: order.notes ??
                                                    'Notes of the order will show here'
                                                        .tr,
                                                status: order.status ?? '',
                                                car: order.vehicle != null
                                                    ? '${order.vehicle?.carBrand?.name ?? ''} ${order.vehicle?.carModel?.name ?? ''} - ${order.vehicle?.year ?? ''} (${order.vehicle?.color ?? ''})'
                                                    : 'Missing or Deleted Vehicle'
                                                        .tr,
                                                id: order.id.toString() ?? '',
                                                providerLogo:
                                                    order.seller?.logo ??
                                                        providerLogo,
                                                date:
                                                    "$formattedDate, ${ordersController.slots.firstWhere((slot) => slot['id'] == order.slotId)['from']} - ${ordersController.slots.firstWhere((slot) => slot['id'] == order.slotId)['to']}",
                                                price:
                                                    double.parse(order.price!),
                                                name: order.name ?? '',
                                                addOns: addOns ?? [],
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: ordersController.ordered.isEmpty
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: Center(
                                    child: Text('No Orders History'.tr,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color(0xFF717276),
                                          fontSize: 15,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                          letterSpacing: -0.15,
                                        )),
                                  ),
                                )
                              : Column(
                                  children: [
                                    ...ordersController.ordered
                                        .map<Widget>((order) {
                                      List<Orders.AddOn> addOns =
                                          order.addOns!.cast<Orders.AddOn>();
                                      DateTime dateTime =
                                          DateTime.parse(order.date!);
                                      String formattedDate =
                                          DateFormat('MMM d').format(dateTime);
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                        child: Column(
                                          children: [
                                            OrderItem(
                                              tax: double.parse(
                                                      order.taxPercent!) /
                                                  100,
                                              notes: order.notes ??
                                                  'Notes of the order will show here'
                                                      .tr,
                                              status: order.status ?? '',
                                              car: order.vehicle != null
                                                  ? '${order.vehicle?.carBrand?.name ?? ''} ${order.vehicle?.carModel?.name ?? ''} - ${order.vehicle?.year ?? ''} (${order.vehicle?.color ?? ''})'
                                                  : 'Missing or Deleted Vehicle'
                                                      .tr,
                                              id: order.id.toString() ?? '',
                                              providerLogo: providerLogo,
                                              date:
                                                  "$formattedDate, ${ordersController.slots.firstWhere((slot) => slot['id'] == order.slotId)['from']} - ${ordersController.slots.firstWhere((slot) => slot['id'] == order.slotId)['to']}",
                                              price: double.parse(order.price!),
                                              name: order.name ?? '',
                                              addOns: addOns ?? [],
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
        ordersController.loading.value ? const LoadingWidget() : Row()
      ]),
    );
  }
}
