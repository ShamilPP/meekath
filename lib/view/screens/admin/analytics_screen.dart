import 'package:baitulmaal/utils/enums.dart';
import 'package:baitulmaal/view/widgets/logout_button.dart';
import 'package:baitulmaal/view_model/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/admin_overview_model.dart';
import '../../../view_model/admin_view_model.dart';
import '../../widgets/amount_percentage_indicator.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Analytics',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Refresh button
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Material(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: InkWell(
                          splashColor: Colors.white,
                          child: const Icon(Icons.refresh, color: Colors.white),
                          onTap: () async {
                            // Update all data's
                            AdminProvider provider = Provider.of<AdminProvider>(context, listen: false);
                            Provider.of<PaymentProvider>(context, listen: false)
                                .showLoadingDialog(context, 'Updating...');
                            await provider.initData(context);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Consumer<AdminProvider>(
                builder: (ctx, provider, child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 17, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnalyticsSection(adminOverview: provider.adminOverview),
                        const PaymentSection(),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),

          // Logout button
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: LogoutButton(),
            ),
          ),
        ],
      ),
    );
  }
}

class AnalyticsSection extends StatelessWidget {
  final AdminOverviewModel adminOverview;

  const AnalyticsSection({Key? key, required this.adminOverview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AmountPercentageIndicator(
          percentage: 1 - (adminOverview.pendingAmount / adminOverview.totalAmount),
          centerIconColor: Colors.black,
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsText(
              text: 'Total Amount : ₹ ${adminOverview.totalAmount}',
            ),
            DetailsText(
              text: 'Total Received : ₹ ${adminOverview.totalReceivedAmount}',
            ),
            DetailsText(
              text: 'Pending Amount : ₹ ${adminOverview.pendingAmount}',
            ),
            DetailsText(
              text: 'Extra Amount : ₹ ${(adminOverview.extraAmount)}',
            ),
          ],
        ),
      ],
    );
  }
}

class PaymentSection extends StatelessWidget {
  const PaymentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(builder: (ctx, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40, bottom: 10),
            child: Text(
              'Payment details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          DetailsText(
            text: 'Total Not verified amount : ₹ ${provider.getTotalAmount(PaymentStatus.notVerified)}',
          ),
          DetailsText(
            text: 'Total Accepted amount : ₹ ${provider.getTotalAmount(PaymentStatus.accepted)}',
          ),
          DetailsText(
            text: 'Total Rejected amount : ₹ ${provider.getTotalAmount(PaymentStatus.rejected)}',
          ),
        ],
      );
    });
  }
}

class DetailsText extends StatelessWidget {
  final String text;

  const DetailsText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Text(
        text,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }
}
