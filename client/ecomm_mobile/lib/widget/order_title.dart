import 'package:ecomm_mobile/utility/app_color.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderTitle extends StatelessWidget {
  const OrderTitle(
      {super.key,
      required this.items,
      required this.paymentMethod,
      required this.date,
      required this.status,
      this.onTap});
  final String items;
  final String paymentMethod;
  final String date;
  final String status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                items,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkOrange),
              ),
              const Gap(8),
              Text(
                'Payment: $paymentMethod',
                style: const TextStyle(fontSize: 16),
              ),
              const Gap(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          status,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.grey;
      case 'processing':
        return Colors.orange;
      case 'shipped':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
