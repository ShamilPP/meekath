import 'package:flutter/material.dart';
import 'package:baitulmaal/model/user_model.dart';
import 'package:baitulmaal/utils/colors.dart';
import 'package:baitulmaal/view_model/payment_view_model.dart';
import 'package:provider/provider.dart';

import '../../utils/enums.dart';
import '../widgets/payment_list.dart';

class TransactionScreen extends StatelessWidget {
  final List<UserModel> users;

  const TransactionScreen({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
            child: AppBar(
              backgroundColor: primaryColor,
              title: const Text(
                'Transactions',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400, color: Colors.white),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'Accepted'),
                  Tab(text: 'Rejected'),
                  Tab(text: 'Not verified'),
                ],
              ),
            ),
          ),
          Consumer<PaymentProvider>(builder: (ctx, provider, child) {
            return Expanded(
              child: TabBarView(
                children: [
                  PaymentList(
                    paymentList: provider.getUserPaymentList(
                      users,
                      PaymentStatus.allPayments,
                    ),
                  ),
                  PaymentList(
                    paymentList: provider.getUserPaymentList(
                      users,
                      PaymentStatus.accepted,
                    ),
                  ),
                  PaymentList(
                    paymentList: provider.getUserPaymentList(
                      users,
                      PaymentStatus.rejected,
                    ),
                  ),
                  PaymentList(
                    paymentList: provider.getUserPaymentList(
                      users,
                      PaymentStatus.notVerified,
                    ),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
