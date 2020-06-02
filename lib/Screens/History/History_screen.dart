import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:iwas_port/Models/Order.dart';
import 'package:iwas_port/Screens/History/HistoryItem_widget.dart';
import 'package:iwas_port/Screens/Loading/loading.dart';
import 'package:iwas_port/Services/OrderDatabaseService.dart';
import 'package:provider/provider.dart';
import 'package:timeline_list/timeline.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool isBusy = true;
  final _databaseService = OrderDatabaseService();

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<List<Order>>(context);

    if (orders != null) {
      setState(() {
        isBusy = false;
      });
    }

    void markOrderAsPaid(Order order) async {
      setState(() {
        order.isPaymentPending = !order.isPaymentPending;
      });
      try {
        await _databaseService.writeToDatabase(order);
        FlushbarHelper.createSuccess(
                message: 'Daten erfolgreich in die Cloud hochgeladen!')
            .show(context);
      } catch (error) {}
    }

    return isBusy
        ? Loading()
        : Timeline.builder(
            itemBuilder: (ctx, index) =>
                timelineBuilder(context, orders[index], markOrderAsPaid),
            itemCount: orders.length,
            position: TimelinePosition.Left,
            physics: ClampingScrollPhysics(),
          );
  }
}
