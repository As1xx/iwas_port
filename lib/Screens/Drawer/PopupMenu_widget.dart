import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwas_port/Models/wine.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:provider/provider.dart';

void buildPopupMenu(BuildContext context, GlobalKey widgetKey,List<Wine> wineList){

  void _sortManufacturer() {
   wineList.sort((a, b) => a.manufacturer.compareTo(b.manufacturer));
  }

  void onClickMenu(MenuItemProvider item) {
    if(item.menuTitle == 'Sort (A-Z)'){
      _sortManufacturer();
    }
  }

  PopupMenu menu = PopupMenu(
    context: context,
    maxColumn: 1,
    highlightColor: Theme.of(context).accentColor,
    items: [
      MenuItem(
          title:'Sort (A-Z)',
      image: Icon(
        FontAwesomeIcons.sortAlphaDown,
      )),
      MenuItem(
        title: 'Sort (Z-A)',
        image:Icon(
          FontAwesomeIcons.sortAlphaUp
        ),
      ),
    ],
    onClickMenu: onClickMenu,
    onDismiss: onDismiss,
    stateChanged: stateChanged,
  );

menu.show(widgetKey: widgetKey);

}

void stateChanged(bool isShow) {
  print('menu is ${isShow ? 'showing' : 'closed'}');
}



void onDismiss() {
  print('Menu is dismiss');
}

