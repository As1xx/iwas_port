import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwas_port/Models/Order.dart';
import 'package:timeline_list/timeline_model.dart';

TimelineModel timelineBuilder(BuildContext context, Order order) {
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();

  return TimelineModel(
    SimpleFoldingCell(
      key: _foldingCellKey,
      cellSize: Size(MediaQuery.of(context).size.width, 200),
      frontWidget: buildFrontWidget(order, context, _foldingCellKey),
      innerTopWidget: buildInnerTopWidget(order, context, _foldingCellKey),
      innerBottomWidget: buildInnerBottomWidget(order, context, _foldingCellKey),
    ),
  );
}

Card buildFrontWidget(
    Order order, BuildContext context, GlobalKey<SimpleFoldingCellState> key) {
  final username = order.user.split('@')[0].toUpperCase();
  final formattedDate = formatDate(order.date, [dd, '-', mm, '-', yyyy]);

  var isSoldWidget = Column(
    children: <Widget>[
      Text('+ ${order.amount} €',
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(color: Colors.green)),
      Icon(FontAwesomeIcons.longArrowAltRight, color: Colors.green),
      Text('- ${order.totalOrderQuantity} x',
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(color: Colors.red)),
    ],
  );

  var isBoughtWidget = Column(
    children: <Widget>[
      Text('- ${order.amount} €',
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(color: Colors.red)),
      Icon(FontAwesomeIcons.longArrowAltLeft, color: Colors.red),
      Text('+ ${order.totalOrderQuantity} x',
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(color: Colors.green)),
    ],
  );


  return Card(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    clipBehavior: Clip.antiAlias,
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(username, style: Theme.of(context).textTheme.headline),
              Text(formattedDate, style: Theme.of(context).textTheme.headline),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(order.location.name,
                  style: Theme.of(context).textTheme.headline),
              //order.isSold ? isSoldWidget : isBoughtWidget,
              Text(''
                //order.isSold ? order.customer.name : order.supplier.name,
               // style: Theme.of(context).textTheme.headline,
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                onPressed: () => key?.currentState?.toggleFold(),
                icon: Icon(Icons.arrow_drop_down,
                    color: Theme.of(context).iconTheme.color),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Card buildInnerTopWidget(
    Order order, BuildContext context, GlobalKey<SimpleFoldingCellState> key) {
  final username = order.user.split('@')[0].toUpperCase();
  final formattedDate = formatDate(order.date, [dd, '-', mm, '-', yyyy]);

  var isSoldWidget = Column(
    children: <Widget>[
      Text('+ ${order.amount} €',
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(color: Colors.green)),
      Icon(FontAwesomeIcons.longArrowAltRight, color: Colors.green),
      Text('- ${order.totalOrderQuantity} x',
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(color: Colors.red)),
    ],
  );

  var isBoughtWidget = Column(
    children: <Widget>[
      Text('- ${order.amount} €',
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(color: Colors.red)),
      Icon(FontAwesomeIcons.longArrowAltLeft, color: Colors.red),
      Text('+ ${order.totalOrderQuantity} x',
          style: Theme.of(context)
              .textTheme
              .headline
              .copyWith(color: Colors.green)),
    ],
  );


  return Card(
    margin: EdgeInsets.symmetric(vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    clipBehavior: Clip.antiAlias,
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(username, style: Theme.of(context).textTheme.headline),
              Text(formattedDate, style: Theme.of(context).textTheme.headline),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(order.location.name,
                  style: Theme.of(context).textTheme.headline),
              //order.isSold ? isSoldWidget : isBoughtWidget,
              Text(''
               // order.isSold ? order.customer.name : order.supplier.name,
                //style: Theme.of(context).textTheme.headline,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Card buildInnerBottomWidget(
    Order order, BuildContext context, GlobalKey<SimpleFoldingCellState> key) {
  final productList = order.products;

  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Card(
                  color: Theme.of(context).backgroundColor,
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(productList[index].manufacturer + ' ' + productList[index].type,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ],
                    ),
                    title: Center(
                      child: Text('${productList[index].quantity} x',style: Theme.of(context).textTheme.headline,
                      ),
                    ),
                    //subtitle: Text('test'),
                    trailing: Text('${productList[index].price} €',
                      style: Theme.of(context).textTheme.headline,
                    ),
                    onTap:  () => key?.currentState?.toggleFold(),
                  ),
                );
            },
          ),
        ),
  );
}
