import 'package:flutter/material.dart';
import 'package:iwas_port/Models/Order.dart';
import 'package:iwas_port/Screens/History/HistoryItem_widget.dart';
import 'package:provider/provider.dart';
import 'package:timeline_list/timeline.dart';

class HistoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final orders  = Provider.of<List<Order>>(context);

    return Timeline.builder(
      itemBuilder: (ctx,index) => timelineBuilder(context, orders[index]),
      itemCount: orders.length,
      position: TimelinePosition.Left,
      physics: ClampingScrollPhysics(),

    );
  }
}
