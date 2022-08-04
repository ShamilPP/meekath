import 'package:baitulmaal/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/payment_model.dart';
import '../service/analytics_service.dart';
import 'admin_view_model.dart';

class RequestProvider extends ChangeNotifier {
  final listKey = GlobalKey<AnimatedListState>();
  late List<PaymentModel> _notVerifiedList;

  List<PaymentModel> get notVerifiedList => _notVerifiedList;

  void setNotVerifiedList(BuildContext context) {
    var adminProvider = Provider.of<AdminProvider>(context, listen: false);
    var paymentList = AnalyticsService.getPaymentListWithStatus(adminProvider.payments, PaymentStatus.notVerified);
    _notVerifiedList = paymentList;
  }

  void updatePaymentList(BuildContext context, PaymentModel payment, PaymentStatus status) {
    AdminProvider adminProvider = Provider.of<AdminProvider>(context, listen: false);
    int paymentIndex = adminProvider.payments.indexWhere((_payment) => payment.docId == _payment.docId);
    adminProvider.payments[paymentIndex].verify = status.index;
    _notVerifiedList.remove(payment);
    adminProvider.updateData();
  }

  List<PaymentModel> getNotVerifiedPayments(BuildContext context) {
    var allPayments = Provider.of<AdminProvider>(context, listen: false).payments;
    return AnalyticsService.getPaymentListWithStatus(allPayments, PaymentStatus.notVerified);
  }
}