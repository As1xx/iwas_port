import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwas_port/Models/Order.dart';
import 'package:iwas_port/Models/customer.dart';
import 'package:iwas_port/Models/location.dart';
import 'package:iwas_port/Models/supplier.dart';
import 'package:timeline_list/timeline_model.dart';

TimelineModel timelineBuilder(BuildContext context, Order order, Function stateCallback) {
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();





  return TimelineModel(
    SimpleFoldingCell(
      key: _foldingCellKey,
      cellSize: Size(MediaQuery.of(context).size.width, 200),
      frontWidget: buildFrontWidget(order, context, _foldingCellKey,stateCallback),
      innerTopWidget: buildFrontWidget(order, context, _foldingCellKey,stateCallback),
      innerBottomWidget: buildInnerBottomWidget(order, context, _foldingCellKey)
    ),
  );
}


Card buildFrontWidget(
    Order order, BuildContext context, GlobalKey<SimpleFoldingCellState> key,Function paidCallback) {

  final username = order.user.split('@')[0].toUpperCase();
  final formattedDate = formatDate(order.date, [dd, '-', mm, '-', yyyy]);
  String fromName;
  String toName;
  var transferWidget;
  Widget isPaid;

  if (order.isPaymentPending){
    isPaid = Text('Nein',style: Theme.of(context).textTheme.headline4.copyWith(color:Colors.red),);
  }else{
    isPaid = Text('Ja',style: Theme.of(context).textTheme.headline4.copyWith(color:Colors.green),);
  }

  if (order.from is Location) {
    fromName = (order.from as Location).name;
  } else if (order.from is Supplier) {
    fromName = (order.from as Supplier).name;
  } else if (order.from is Customer) {
    fromName = (order.from as Customer).name;
  }else{
    return null;
  }


  if (order.to is Location) {
    toName = (order.to as Location).name;
  } else if (order.to is Supplier) {
    toName = (order.to as Supplier).name;
  } else if (order.to is Customer) {
    toName = (order.to as Customer).name;
  }else{
    return null;
  }



  var isSoldWidget = Column(
    children: <Widget>[
    Text('+ ${order.amount} €',
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.green),
      ),
      Icon(FontAwesomeIcons.longArrowAltRight, color: Colors.green),
     Text('- ${order.totalOrderQuantity} x',
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.red),
      ),
    ],
  );

  var isBoughtWidget = Column(
    children: <Widget>[
      Text('- ${order.amount} €',
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: Colors.red)),
      Icon(FontAwesomeIcons.longArrowAltLeft, color: Colors.red),
      Text('+ ${order.totalOrderQuantity} x',
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: Colors.green)),
    ],
  );


  var isTransferWidget = Column(
    children: <Widget>[
      Text('- ${order.amount} €',
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: Colors.grey)),
      Icon(FontAwesomeIcons.longArrowAltLeft, color: Colors.grey),
      Text('+ ${order.totalOrderQuantity} x',
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: Colors.grey)),
    ],
  );


  Widget checkTransferWidget(){
    if (order.method == 'Kaufen'){
      transferWidget = isBoughtWidget;
    } else if (order.method == 'Verkaufen'){
      transferWidget = isSoldWidget;
    }else if (order.method =='Transfer'){
      transferWidget = isTransferWidget;
    }
    return transferWidget;
  }

  return Card(
    color: Theme.of(context).backgroundColor.withOpacity(1),
    margin: EdgeInsets.symmetric(vertical: 16.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(username, style: Theme.of(context).textTheme.headline5),
              Text(formattedDate, style: Theme.of(context).textTheme.headline5),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(fromName,
                  style: Theme.of(context).textTheme.headline4),
              checkTransferWidget(),
              Text(
                toName,
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
          //Spacer(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(children: <Widget>[
                Text('Bezahlt?'),
                FlatButton(child: isPaid,
                onPressed: () => paidCallback(order)),
              ],),
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



Card buildInnerBottomWidget(
    Order order, BuildContext context, GlobalKey<SimpleFoldingCellState> key) {
  final productList = order.products;

  return Card(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    child: Padding(
      padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Card(
                  color: Theme.of(context).backgroundColor.withOpacity(1),
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(productList[index].manufacturer + ' ' + productList[index].type,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                    title: Center(
                      child: Text('${productList[index].quantity} x',style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    //subtitle: Text('test'),
                    trailing: Text('${productList[index].price} €',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    onTap:  () => key?.currentState?.toggleFold(),
                  ),
                );
            },
          ),
        ),
  );
}
