import 'package:ecomm_mobile/core/data/data_provider.dart';
import 'package:ecomm_mobile/screens/tracking_screen/tracking_screen.dart';
import 'package:ecomm_mobile/utility/app_color.dart';
import 'package:ecomm_mobile/utility/extensions.dart';
import 'package:ecomm_mobile/utility/utility_extension.dart';
import 'package:ecomm_mobile/widget/order_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.darkOrange),
        ),
      ),
      body: Consumer<DataProvider>(builder: (context, dataProvider, child) {
        return ListView.builder(
            itemCount: context.dataProvider.orders.length,
            itemBuilder: (context, index) {
              final order = context.dataProvider.orders[index];
              return OrderTitle(
                items:
                    '${(order.items!.safeElementAt(0)?.productName ?? '')} & ${order.items!.length - 1}',
                paymentMethod: order.paymentMethod ?? '',
                date: order.orderDate ?? '',
                status: order.orderStatus ?? 'pending',
                onTap: () {
                  if (order.orderStatus == 'shipped') {
                    Get.to(
                      TrackingScreen(
                        url: order.trackingUrl ?? '',
                      ),
                    );
                  }
                },
              );
            });
      }),
    );
  }
}
